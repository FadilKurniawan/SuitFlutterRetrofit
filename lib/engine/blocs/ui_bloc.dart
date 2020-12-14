import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class UIBloc extends Bloc<UIEvent, UIState> {
  dynamic value;

  UIBloc(UIState initialState) : super(initialState);

  UIState get initialState => UIStateDidInit(null);

  @override
  Stream<UIState> mapEventToState(UIEvent event) async* {
    if (event is UIEventTapped) {
      yield UIStateDidTapped();
    } else if (event is UIEventChangeValue) {
      this.value = event.value;
      yield UIStateDidChangeValue(this.value);
    }
  }
}

abstract class UIState extends Equatable {}

abstract class UIEvent extends Equatable {}

// STATES
//

class UIStateDidInit extends UIState {
  final value;

  UIStateDidInit(this.value);

  @override
  List<Object> get props => null;
}

class UIStateDidTapped extends UIState {
  @override
  List<Object> get props => null;
}

class UIStateDidChangeValue extends UIState {
  final value;

  UIStateDidChangeValue(this.value);

  @override
  List<Object> get props => [value];
}

// EVENTS
//

class UIEventTapped extends UIEvent {
  @override
  List<Object> get props => null;
}

class UIEventChangeValue extends UIEvent {
  final value;

  UIEventChangeValue(this.value);

  @override
  List<Object> get props => [value];
}
