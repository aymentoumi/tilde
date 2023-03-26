library tilde;

import 'package:event/event.dart';
import 'package:eventsubscriber/eventsubscriber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_router/url_router.dart';

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
  final _event = Event();

  ///
  /// Builds [Component] widget.
  ///
  Widget render(BuildContext context);

  ///
  /// Notifys component to refresh widget.
  ///
  void setState([VoidCallback? fn]) {
    fn?.call();
    _event.broadcast();
  }

  ///
  /// Returns [Component] widget.
  ///
  Widget operator ~() =>
      EventSubscriber(event: _event, builder: (context, _) => render(context));
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
  /// Returns the current [url] params.
  ///
  Map<String, String>? get queryParams => _router.queryParams;

  ///
  /// Returns the current [route].
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
