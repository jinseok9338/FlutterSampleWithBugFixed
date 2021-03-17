import 'package:flutter/material.dart';
import 'package:flutter_application_2/ColorFilters.dart';
import 'package:flutter_application_2/CustomPainterDemo.dart';
import 'package:flutter_application_2/custom_dropdown.dart';
import 'package:flutter_application_2/googleiofilteroptionanimation.dart';
import 'package:flutter_application_2/menu_dashboard_layout.dart';

enum WidgetMarker { graph, stats, info }

void main() {
  // runApp(ColorFiltersDemo());
  //  runApp(WidgetSwitchDemo());
  // runApp(FilterAnimationGoogleIOTutorial());
  // runApp(CustomPaintDemo());
  // runApp(MenuDashboardPage());
  runApp(CustomDropdown(
    text: 'This is the menu',
  ));
}

class WidgetSwitchDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("WidgetSwitchDemo"),
        ),
        body: BodyWidget(),
      ),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BodyWidgetState();
}

class BodyWidgetState extends State<BodyWidget>
    with SingleTickerProviderStateMixin<BodyWidget> {
  WidgetMarker selectedWidgetMarker = WidgetMarker.graph;
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  selectedWidgetMarker = WidgetMarker.graph;
                });
              },
              child: Text(
                "Graph",
                style: TextStyle(
                    color: (selectedWidgetMarker == WidgetMarker.graph)
                        ? Colors.black
                        : Colors.black12),
              ),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  selectedWidgetMarker = WidgetMarker.stats;
                });
              },
              child: Text("Stats",
                  style: TextStyle(
                      color: (selectedWidgetMarker == WidgetMarker.stats)
                          ? Colors.black
                          : Colors.black12)),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  selectedWidgetMarker = WidgetMarker.info;
                });
              },
              child: Text("Info",
                  style: TextStyle(
                      color: (selectedWidgetMarker == WidgetMarker.info)
                          ? Colors.black
                          : Colors.black12)),
            ),
          ],
        ),
        FutureBuilder(
          future: _playAnimation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return getCustomContainer();
          },
        )
      ],
    );
  }

  _playAnimation() {
    _controller.reset();
    _controller.forward();
  }

  Widget getCustomContainer() {
    switch (selectedWidgetMarker) {
      case WidgetMarker.graph:
        return getGraphContainer();
      case WidgetMarker.stats:
        return getStatsContainer();
      case WidgetMarker.info:
        return getInfoContainer();
    }
    return getGraphContainer();
  }

  Widget getGraphContainer() {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        color: Colors.red,
        height: 200,
      ),
    );
  }

  Widget getStatsContainer() {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        color: Colors.green,
        height: 300,
      ),
    );
  }

  Widget getInfoContainer() {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        color: Colors.blue,
        height: 400,
      ),
    );
  }
}
