import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../data/models/responses/city_response.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/drop_down/drop_down_bloc.dart';
import '../../bloc/drop_down/drop_down_event.dart';
import '../../bloc/drop_down/drop_down_state.dart';
import '../../views/base_view.dart';
import '../cdb_text_fields/cdb_search_text_field.dart';
import '../cdb_toast/cdb_toast.dart';
import 'drop_down_list_item.dart';

class DropDownViewScreenArgs {
  final bool isSearchable;
  final String pageTitle;
  final DropDownEvent dropDownEvent;

  DropDownViewScreenArgs({this.isSearchable, this.pageTitle, this.dropDownEvent});
}

class DropDownView extends BaseView {
  final DropDownViewScreenArgs dropDownViewScreenArgs;

  const DropDownView(this.dropDownViewScreenArgs);

  @override
  _DropDownViewState createState() => _DropDownViewState();
}

class _DropDownViewState extends BaseViewState<DropDownView> {
  // List<CommonDropDownResponse> filteredList = [];
  final _bloc = inject<DropDownBloc>();
  List<CommonDropDownResponse> allDropDownData = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(widget.dropDownViewScreenArgs.dropDownEvent);
  }

  @override
  Widget buildView(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: BlocListener<DropDownBloc, BaseState<DropDownState>>(
        listener: (context,state) {
          if (state is DropDownFailedState){
            Navigator.of(context).pop();
            ToastUtils.showCustomToast(context, state.message, ToastStatus.fail);
          }
        },
        child: AnnotatedRegion(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: kLeftRightMarginOnBoarding,
                    right: kLeftRightMarginOnBoarding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.dropDownViewScreenArgs.pageTitle,
                        style: AppStyling.normal500Size16.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                if (widget.dropDownViewScreenArgs.isSearchable)
                  SizedBox(
                    height: 20.h,
                  )
                else
                  Container(),
                if (widget.dropDownViewScreenArgs.isSearchable)
                  BlocBuilder<DropDownBloc, BaseState<DropDownState>>(
                    builder: (context, state) {
                      if (state is DropDownDataLoadedState) {
                        allDropDownData = state.data;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: kLeftRightMarginOnBoarding,
                          right: kLeftRightMarginOnBoarding,
                        ),
                        child: CdbSearchTextField(
                          hintText: AppString.search.localize(context),
                          onChange: (value) {
                            _bloc.add(FilterEvent(dropDownData: allDropDownData, searchText: value));
                          },
                        ),
                      );
                    },
                  )
                else
                  Container(),
                BlocBuilder<DropDownBloc, BaseState<DropDownState>>(
                  builder: (context, state) {
                    if (state is DropDownFilteredState) {
                      final List<CommonDropDownResponse> data = state.data;
                      return DropDownDataLoadedContainer(isSearchable: widget.dropDownViewScreenArgs.isSearchable, data: data);
                    } else if (state is DropDownDataLoadedState) {
                      final List<CommonDropDownResponse> data = state.data;
                      return DropDownDataLoadedContainer(isSearchable: widget.dropDownViewScreenArgs.isSearchable, data: data);
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}

class DropDownDataLoadedContainer extends StatelessWidget {
  const DropDownDataLoadedContainer({Key key, this.isSearchable, this.data}) : super(key: key);

  final bool isSearchable;
  final List<CommonDropDownResponse> data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: isSearchable,
        child: RawScrollbar(
          thumbColor: AppColors.accentColor,
          radius: const Radius.circular(10.0),
          thickness: 6,
          child: ListView.builder(
            itemCount: data.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                ),
                child: DropDownListItem(
                  title: data[index].description ?? "-",
                  onTap: () {
                    Navigator.pop(context, data[index]);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
