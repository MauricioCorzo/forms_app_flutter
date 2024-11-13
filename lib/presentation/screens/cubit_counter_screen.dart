import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: const _CubitCounterView(),
    );
  }
}

class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView();

  @override
  Widget build(BuildContext context) {
    // final counterState = context.watch<CounterCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: BlocConsumer<CounterCubit, CounterState>(
          listener: (context, state) {
            // if (state.counter % 4 == 0) {
            //   print("Is odd");
            // }
          },
          builder: (context, state) {
            return Text("Cubit counter: ${state.transactionCount}");
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              context.read<CounterCubit>().reset();
            },
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, CounterState>(
          buildWhen: (previous, current) => current.counter != previous.counter,
          builder: (context, state) {
            return Text("Counter value: ${state.counter}");
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
              onPressed: () {
                context.read<CounterCubit>().incrementBy(3);
              }),
          FloatingActionButton(
              heroTag: "2",
              child: const Text("+2"),
              onPressed: () {
                context.read<CounterCubit>().incrementBy(2);
              }),
          FloatingActionButton(
              heroTag: "3",
              child: const Text("+1"),
              onPressed: () {
                context.read<CounterCubit>().incrementBy(1);
              }),
        ],
      ),
    );
  }
}
