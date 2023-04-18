import 'package:flutter/material.dart';
import 'package:tilde/tilde.dart';

void main() => runApp(MaterialApp(home: ~MyApp()));

class MyApp extends SPA {
  final _counter = Counter();
  final _counter1 = 0.component<int>((ctx, self) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Counter I:',
          ),
          Text(
            '${self.x}',
            style: Theme.of(ctx).textTheme.headlineMedium,
          ),
          ElevatedButton(
            onPressed: () => self.x = 0,
            child: const Text('Reset'),
          ),
        ],
      ));

  @override
  Widget onNavigate(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo Home Page'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ~_counter,
              const Padding(padding: EdgeInsets.all(8)),
              ~_counter1,
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _counter.increment();
            _counter1.setState(() => _counter1.x++);
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}

class Counter extends Component {
  int _count = 0;

  void increment() => setState(() => _count++);

  @override
  Widget render(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Counter:',
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
      );
}
