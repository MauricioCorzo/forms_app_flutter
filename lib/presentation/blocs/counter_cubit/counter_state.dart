part of 'counter_cubit.dart';

// Equatable package: for compare to identical object even in separate memory space
class CounterState extends Equatable {
  final int counter;
  final int transactionCount;

  const CounterState({
    required this.counter,
    required this.transactionCount,
  });

  CounterState copyWith({
    int? counter,
    int? transactionCount,
  }) =>
      CounterState(
        counter: counter ?? this.counter,
        transactionCount: transactionCount ?? this.transactionCount,
      );

  @override
  List<Object> get props => [counter, transactionCount];
}
