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
  late Animation<double> _animation;
  late AnimationController _controller;

  int _count = 0;

  Future<void> increment() async {
    await _controller.reverse();
    _count++;
    await _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200),
        reverseDuration: const Duration(milliseconds: 200),
        vsync: vsync);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() => setState(() {}));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            textScaleFactor: _animation.value,
          ),
          ElevatedButton(
            onPressed: () {
              _count = 0;
              _controller.reset();
              _controller.fling();
            },
            child: const Text('Reset'),
          ),
        ],
      );
}
