import 'package:cdb_mobile/features/presentation/widgets/measures_size_render_object.dart';
import 'package:flutter/material.dart';

class Automator extends StatefulWidget {
  final String tag;
  final Widget child;
  final VoidCallback onTap;

  Automator({@required this.tag, @required this.child, this.onTap});

  @override
  State<Automator> createState() => _AutomatorState();
}

class _AutomatorState extends State<Automator> {
  var myChildSize = Size.zero;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        MeasureSize(
            onChange: (size) {
              setState(() {
                myChildSize = size;
              });
            },
            child: widget.child),
        InkWell(
          onTap: () {
            if (widget.onTap != null) widget.onTap();
          },
          child: Container(
            width: myChildSize.width,
            height: myChildSize.height,
            // color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.tag ?? 'Tag', style: TextStyle(color: Colors.transparent),),
            ),
          ),
        )
      ],
    );
  }
}
