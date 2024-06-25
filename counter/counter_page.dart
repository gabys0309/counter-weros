import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../cubit/counter_cubit.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      fontSize: 10.0,  
      timeInSecForIosWeb: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                'Counter',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                final count = context.read<CounterCubit>().state;
                if (count < 10) {
                  context.read<CounterCubit>().increment();
                } else {
                  _showToast("Límite superior alcanzado");
                }
              },
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 5),
            const CounterText(),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                final count = context.read<CounterCubit>().state;
                if (count > -10) {
                  context.read<CounterCubit>().decrement();
                } else {
                  _showToast("Límite inferior alcanzado");
                }
              },
              child: const Icon(Icons.remove),
            ),
            const SizedBox(height: 2),
            ElevatedButton(
              onPressed: () => context.read<CounterCubit>().reset(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(6.0), // Ajusta el padding para hacer el botón más pequeño
                minimumSize: const Size(20, 20), // Tamaño mínimo del botón
              ),
              child: const Icon(Icons.refresh, size: 18), // Ajusta el tamaño del icono
            ),
          ],
        ),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayMedium);
  }
}
