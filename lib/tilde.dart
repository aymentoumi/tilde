library tilde;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_router/url_router.dart';

class _Controller {
  late void Function(void Function() fn) _setState;
  late void Function() _initState;
  late TickerProvider _vsync;
  late bool Function() _mounted;
  late void Function() _didChangeDependencies;
  late void Function(Widget oldWidget) _didUpdateWidget;
  late void Function() _deactivate;
  late void Function() _dispose;
}

class _Subscriber extends StatefulWidget {
  const _Subscriber({required this.controller, required this.builder});

  final _Controller controller;
  final Widget Function(BuildContext) builder;

  @override
  State<_Subscriber> createState() => _State();
}

class _State extends State<_Subscriber> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.controller._mounted = () => mounted;
    widget.controller._vsync = this;
    widget.controller._setState = setState;
    widget.controller._initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.controller._didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);

  @override
  void didUpdateWidget(covariant _Subscriber oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller._didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.controller._deactivate();
  }

  @override
  void dispose() {
    widget.controller._dispose();
    super.dispose();
  }
}

///
/// Application type: material for [MaterialApp] and cupertino for [CupertinoApp].
///
enum AppType { material, cupertino }

///
/// [Component] class allows to create a widget with mutable state.
///
/// Sample use :
/// ```dart
/// class Counter extends Component {
///   int _count = 0;
///
///   @override
///   Widget render(BuildContext context) {
///     return Center(
///       child: Column(
///         mainAxisAlignment: MainAxisAlignment.center,
///         children: <Widget>[
///           const Text(
///             'You have pushed the button this many times:',
///           ),
///           Text(
///             '$_count',
///             style: Theme.of(context).textTheme.headlineMedium,
///           ),
///           ElevatedButton(
///             onPressed: () => setState(() => _count++),
///             child: const Text('Increment'),
///           ),
///         ],
///       ),
///     );
///   }
/// }
/// ```
///
abstract class Component {
  final _controller = _Controller();

  Component() {
    _controller._initState = initState;
    _controller._didChangeDependencies = didChangeDependencies;
    _controller._didUpdateWidget = didUpdateWidget;
    _controller._deactivate = deactivate;
    _controller._dispose = dispose;
  }

  ///
  /// the [TickerProvider] for the current context.
  ///
  TickerProvider get vsync => _controller._vsync;

  ///
  /// The framework will call this method exactly once for each [State] object it creates.
  ///
  void initState() {}

  ///
  /// Whether this object widget [State] is currently in a tree.
  ///
  bool get mounted => _controller._mounted();

  ///
  /// This method is also called immediately after [initState].
  ///
  void didChangeDependencies() {}

  ///
  /// Called whenever this object widget configuration changes.
  ///
  void didUpdateWidget(covariant Widget oldWidget) {}

  ///
  /// Called when this object widget is removed from the tree.
  ///
  void deactivate() {}

  ///
  /// Called when this object widget is removed from the tree permanently.
  ///
  void dispose() {}

  ///
  /// Builds [Component] widget.
  ///
  Widget render(BuildContext context);

  ///
  /// Notifys component to refresh widget.
  ///
  void setState([VoidCallback? fn]) {
    fn?.call();
    _controller._setState(() {});
  }

  ///
  /// Returns [Component] widget.
  ///
  Widget operator ~() => _Subscriber(
      controller: _controller, builder: (context) => render(context));
}

///
/// Exists only for compatibility reason, use XComponent instead of ComponentX.
///

@Deprecated('Use XComponent instead of ComponentX')
class ComponentX<T> extends XComponent<T> {
  ComponentX({required super.x, required super.builder});
}

///
/// Creates Component for [T] attribut
///
class XComponent<T> extends Component {
  T _x;
  final Widget Function(BuildContext, XComponent<T>) builder;

  XComponent({required T x, required this.builder}) : _x = x;

  ///
  /// Returns the attribut value
  ///
  T get x => _x;

  ///
  /// Modifies the attribut value
  ///
  set x(T v) => setState(() => _x = v);

  @override
  Widget render(BuildContext context) => builder(context, this);
}

extension Cmp on dynamic {
  ///
  /// Extension method to create Component for variable.
  ///
  /// Sample use :
  /// ```dart
  /// final _counter = 0.component<int>((ctx, self) => Center(
  ///         child: Column(
  ///           mainAxisAlignment: MainAxisAlignment.center,
  ///           children: <Widget>[
  ///             const Text(
  ///               'You have pushed the button this many times:',
  ///             ),
  ///             Text(
  ///               '${self.x}',
  ///               style: Theme.of(ctx).textTheme.headlineMedium,
  ///             ),
  ///             ElevatedButton(
  ///               onPressed: () => self.setState(() => self.x = 0),
  ///               child: const Text('Reset'),
  ///             ),
  ///           ],
  ///         ),
  ///       ));
  /// ```
  ///
  XComponent<T> component<T>(
          Widget Function(BuildContext, XComponent<T>) builder) =>
      XComponent<T>(x: this, builder: builder);
}

///
/// Abstract Single-Page Application [SPA] class.
///
abstract class SPA {
  ///
  /// The application initial route is set to / as default.
  ///
  String get initialRoute => '/';

  ///
  /// The application type by default is material.
  ///
  final AppType appType;

  late UrlRouter _router;

  ///
  /// Constructor that defines the default application type.
  ///
  SPA({this.appType = AppType.material}) {
    _instance = this;
  }

  ///
  /// Returns the [SPA] widget, used only when don't need App route management.
  ///
  Widget operator ~() => appType == AppType.cupertino
      ? CupertinoApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: routeInformationParser,
          routerDelegate: routerDelegate,
        )
      : MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: routeInformationParser,
          routerDelegate: routerDelegate,
        );

  ///
  /// Return the current [url] params.
  ///
  Map<String, String>? get queryParams => _router.queryParams;

  ///
  /// Return the current [route].
  ///
  String get route => _router.url;

  ///
  /// Modify the current [route].
  ///
  set route(String value) => _router.url = value;

  ///
  /// Called after a location is resolved to build the application widget.
  ///
  Widget onNavigate(BuildContext context);

  ///
  /// Optional, protect or redirect routes.
  ///
  String onChanging(String newRoute) => newRoute;

  ///
  /// Route information parser ready to be used by the [MaterialApp.router] at a later stage.
  ///
  final RouteInformationParser<Object>? routeInformationParser =
      UrlRouteParser();

  ///
  /// Router delegate ready to be used by the [MaterialApp.router] at a later stage.
  ///
  RouterDelegate<Object>? get routerDelegate => UrlRouter(
        url: initialRoute,
        onChanging: (router, newUrl) {
          _router = router;
          return onChanging(newUrl);
        },
        builder: ((router, navigator) {
          _router = router;
          return Navigator(
            onGenerateRoute: (_) => appType == AppType.cupertino
                ? CupertinoPageRoute(builder: onNavigate)
                : MaterialPageRoute(builder: onNavigate),
          );
        }),
      );

  ///
  /// Get access to the [SPA] application.
  ///
  static T? of<T extends SPA>() => _instance as T;

  static SPA? _instance;
}
