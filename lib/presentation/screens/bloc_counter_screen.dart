import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_bloc/counter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: const _CounterBloCView(),
    );
  }
}

class _CounterBloCView extends StatelessWidget {
  const _CounterBloCView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Text("BloC counter transactions: ${state.transactionCount}");
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              // context.read<CounterBloc>().add(const CounterResetEvent());
              context.read<CounterBloc>().resetCounter();
            },
          )
        ],
      ),
      body: Center(
        child: BlocSelector<CounterBloc, CounterState, int>(
          selector: (state) => state.counter,
          builder: (context, counter) {
            return Text("Counter value: $counter");
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Wrap(
        spacing: 10,
        direction: Axis.vertical,
        children: [
          FloatingActionButton(
              heroTag: "1",
              child: const Text("+3"),
              onPressed: () => {
                    // context
                    //     .read<CounterBloc>()
                    //     .add(const CounterIncreasedEvent(value: 3))
                    context.read<CounterBloc>().increaseCounter(3)
                  }),
          FloatingActionButton(
              heroTag: "2",
              child: const Text("+2"),
              onPressed: () => context
                  .read<CounterBloc>()
                  .add(const CounterIncreasedEvent(value: 2))),
          FloatingActionButton(
              heroTag: "3",
              child: const Text("+1"),
              onPressed: () => context
                  .read<CounterBloc>()
                  .add(const CounterIncreasedEvent(value: 1))),
        ],
      ),
    );
  }
}
