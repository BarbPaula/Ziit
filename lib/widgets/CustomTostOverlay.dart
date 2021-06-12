import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomToastOverlay {
  OverlayEntry overlayEntry;
  void show(BuildContext context,
      {String mainText,
      Color backgroundColor,
      String fontFamily,
      Color mainTextColor,
      Duration toastLength}) {
    OverlayState overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return _CustomOverlaySingleButton(overlayEntry,
          backgroundColor: backgroundColor,
          mainText: mainText,
          fontFamily: fontFamily,
          mainTextColor: mainTextColor,
          toastLength: toastLength);
    });

    overlayState.insert(overlayEntry);
  }

  void dismiss() {
    overlayEntry.remove();
  }
}

class _CustomOverlaySingleButton extends StatefulWidget {
  final OverlayEntry overlayEntry;
  final String mainText;
  final Color backgroundColor;
  final String fontFamily;
  final Color mainTextColor;
  final Duration toastLength;
  _CustomOverlaySingleButton(this.overlayEntry,
      {this.backgroundColor,
      this.mainText,
      this.fontFamily,
      this.mainTextColor,
      this.toastLength});
  @override
  State<StatefulWidget> createState() {
    return _CustomOverlaySingleButtonState(overlayEntry,
        backgroundColor: backgroundColor,
        mainText: mainText,
        fontFamily: fontFamily,
        mainTextColor: mainTextColor,
        toastLength: toastLength);
  }
}

class _CustomOverlaySingleButtonState extends State<_CustomOverlaySingleButton>
    with TickerProviderStateMixin {
  final OverlayEntry overlayEntry;
  final String mainText;
  final Color backgroundColor;
  final String fontFamily;
  final Color mainTextColor;
  final Duration toastLength;

  _CustomOverlaySingleButtonState(this.overlayEntry,
      {this.backgroundColor,
      this.mainText,
      this.fontFamily,
      this.mainTextColor,
      this.toastLength});
  AnimationController controller;
  AnimationController fadeController;
  Animation<Offset> scaleAnimation;
  Animation<double> fadeAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    scaleAnimation = Tween<Offset>(
      end: Offset.zero,
      begin: const Offset(0, 1.6),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.bounceOut,
    ));
    fadeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: fadeController, curve: Curves.easeOut));

    controller.forward();

    Future.delayed(toastLength ?? Duration(milliseconds: 3000), () {
      fadeController.forward();
      fadeController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          overlayEntry.remove();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          //You can change this to show toast in different locations
          bottom: 40,
          left: (MediaQuery.of(context).size.width / 2) -
              ((MediaQuery.of(context).size.width / 1.5) / 2),
          child: FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: scaleAnimation,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0.5, 0.5, 0.5, 0),
                      decoration: BoxDecoration(
                          color: backgroundColor ?? Colors.black54,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              mainText ??
                                  "Are You Sure You want to add some text here ?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: mainTextColor ?? Colors.white,
                                  fontFamily: fontFamily ?? "",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
