import 'package:flutter/material.dart';

class LamBackground extends StatelessWidget {
  final Widget child;

  const LamBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        // Background Gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [

                Color(0xFF1E3A8A),

                Color(0xFF2563EB),

                Color(0xFFF5F8FC),

              ],
            ),
          ),
        ),

        // Decorative Circles
        Positioned(
          top: -80,
          right: -60,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .08),
              shape: BoxShape.circle,
            ),
          ),
        ),

        Positioned(
          bottom: -100,
          left: -70,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .06),
              shape: BoxShape.circle,
            ),
          ),
        ),

        SafeArea(child: child),
      ],
    );
  }
}