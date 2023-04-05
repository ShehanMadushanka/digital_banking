abstract class BaseState<K> {
  const BaseState();
}

class BaseInitial extends BaseState {}

class SessionExpireState<K> extends BaseState<K> {}

class APIFailureState<K> extends BaseState<K> {}

class APILoadingState<K> extends BaseState<K> {}
