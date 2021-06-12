import 'package:flutter/material.dart';

class UnfocusOnTap extends StatelessWidget {
  final Widget child;

  const UnfocusOnTap({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocus(context),
      child: child,
    );
  }

  static void unfocus(BuildContext context) {
    FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }
}
