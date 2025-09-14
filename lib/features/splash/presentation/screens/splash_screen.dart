import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/features/auth/data/storage/token_storage.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _positionController;
  late Animation<Offset> _positionAnimation;

  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  late AnimationController _image2Controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _positionController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _positionAnimation =
        Tween<Offset>(begin: Offset(-2.0, -2.0), end: Offset(0.0, 0.0)).animate(
          CurvedAnimation(
            parent: _positionController,
            curve: Curves.easeOutBack,
          ),
        );

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _bounceAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticIn),
    );

    _image2Controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _image2Controller, curve: Curves.easeOut),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _image2Controller, curve: Curves.easeIn));
    _rotationAnimation = Tween<double>(begin: -0.05, end: 0.0).animate(
      CurvedAnimation(parent: _image2Controller, curve: Curves.easeOut),
    );

    startAnimationSequence();
  }

  Future<void> startAnimationSequence() async {
    await _positionController.forward();
    await _bounceController.forward();
    await _image2Controller.forward();

    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    final token = await TokenStorage().getToken();

    if (token != null && token.isNotEmpty) {
      context.pushReplacement(RouteCenter.home);
    } else {
      context.pushReplacement(RouteCenter.onboarding);
    }
  }

  @override
  void dispose() {
    _positionController.dispose();
    _bounceController.dispose();
    _image2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _positionController,
          _bounceController,
          _image2Controller,
        ]),
        builder: (context, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, -_bounceAnimation.value),
                  child: SlideTransition(
                    position: _positionAnimation,
                    child: Image.asset(
                      'assets/images/c.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Image.asset('assets/images/Chatbox.png'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
