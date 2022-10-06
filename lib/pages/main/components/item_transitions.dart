import 'package:flutter/material.dart';

class ItemTransitions extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  final double slideSide;

  ItemTransitions({
    required this.animation,
    required this.child,
    required this.slideSide,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(curve: Curves.easeOut, parent: animation).drive(Tween<double>(begin: 0, end: 1)),
      child: SizeTransition(
        sizeFactor: CurvedAnimation(curve: Curves.easeOut, parent: animation).drive(Tween<double>(begin: 0, end: 1)),
        child: SlideTransition(
          position: CurvedAnimation(curve: Curves.easeOut, parent: animation).drive(
            Tween<Offset>(begin: Offset(slideSide, 0), end: Offset(0, 0)),
          ),
          child: child,
        ),
      ),
    );
  }
}
