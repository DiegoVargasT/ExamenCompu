import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        AuthBackgorundBubbles(),
        SafeArea(
          child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 20),
          child: const Icon(
            Icons.person_4,
            color: Colors.white,
            size: 110,
          ),
        )),
        child,
      ]),
    );
  }
}

class AuthBackgorundBubbles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size_screen = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size_screen.height * 0.4,
      decoration: orangeDecoration(),
      child: Stack(
        children: [
          Positioned(
            child: Bubble(),
            top: 90,
            left: 30,
          ),
          Positioned(
            child: Bubble(),
            top: -40,
            left: -30,
          ),
          Positioned(
            child: Bubble(),
            top: -40,
            right: -30,
          ),
          Positioned(
            child: Bubble(),
            top: 120,
            left: 45,
          ),
        ],
      ),
    );
  }

  BoxDecoration orangeDecoration() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(240, 162, 19, 1),
        Color.fromRGBO(255, 120, 37, 1),
      ]));
}

class Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.438)),
    );
  }
}