import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<CounterIncreasedEvent>(
        (event, emit) => _onCounterIncreased(event, emit));

    on<CounterResetEvent>((event, emit) => _onCounterReset(event, emit));
  }

  void _onCounterIncreased(
      CounterIncreasedEvent event, Emitter<CounterState> emit) {
    emit(state.copyWith(
      counter: state.counter + event.value,
      transactionCount: state.transactionCount + 1,
    ));
  }

  void _onCounterReset(CounterResetEvent event, Emitter<CounterState> emit) {
    emit(state.copyWith(
      counter: 0,
    ));
  }

  void increaseCounter(int value) {
    //Tengo acceso al add() dentro de CounterBLoc
    add(CounterIncreasedEvent(value: value));
  }

  void resetCounter() {
    add(const CounterResetEvent());
  }
}
