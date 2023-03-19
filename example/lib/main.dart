import 'package:flutter/material.dart';
import 'package:tilde/tilde.dart';

void main() => runApp(MaterialApp(home: ~MyApp()));

class MyApp extends SPA {
  final _counter = Counter();

  @override
  Widget onNavigate(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo Home Page'),
        ),
        body: ~_counter,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _counter.increment(),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}

class Counter extends Component {
  int _count = 0;

  void increment() => setState(() => _count++);

  @override
  Widget render(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_count',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ElevatedButton(
            onPressed: () => setState(() => _count = 0),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
