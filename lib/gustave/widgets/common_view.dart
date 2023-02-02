import 'package:flutter/material.dart';
import 'drawer.dart';

// TODO nice hiding drawer animation
class CommonView extends StatefulWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  _CommonViewState createState() => _CommonViewState();

  CommonView(
    this.title,
    this.body, {
    this.floatingActionButton,
  });
}

class _CommonViewState extends State<CommonView> {
  bool forceHideDrawer = false;

  void _switchForceHideDrawer() {
    setState(() {
      forceHideDrawer = !forceHideDrawer;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const breakpoint = 600;
    if (screenWidth < breakpoint) {
      return narrowView();
    } else if (forceHideDrawer) {
      return wideViewHiddenDrawer();
    } else {
      return wideView();
    }
  }

  Scaffold narrowView() {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: widget.body,
        drawer: AppDrawer(context),
        floatingActionButton: widget.floatingActionButton);
  }

  Scaffold wideViewHiddenDrawer() {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _switchForceHideDrawer,
            icon: Icon(Icons.menu),
          ),
          title: Text(widget.title),
        ),
        body: widget.body,
        floatingActionButton: widget.floatingActionButton);
  }

  Scaffold wideView() {
    const double menuWidth = 240;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: _switchForceHideDrawer,
              icon: Icon(Icons.arrow_back_ios_new)),
          title: Text(widget.title),
        ),
        body: Row(
          children: [
            SizedBox(
              width: menuWidth,
              child: AppDrawer.getBody(context),
            ),
            Container(width: 0.5, color: Colors.black),
            Expanded(child: widget.body),
          ],
        ),
        floatingActionButton: widget.floatingActionButton);
  }
}
