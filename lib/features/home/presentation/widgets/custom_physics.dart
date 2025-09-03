import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnhancedSwipeBackGesture extends StatefulWidget {
  final Widget child;
  final PageController pageController;
  final VoidCallback? onSwipeStart;
  final VoidCallback? onSwipeEnd;
  final double edgeWidth;
  final double velocityThreshold;
  final double dragThreshold;

  const EnhancedSwipeBackGesture({
    super.key,
    required this.child,
    required this.pageController,
    this.onSwipeStart,
    this.onSwipeEnd,
    this.edgeWidth = 80.0,
    this.velocityThreshold = 300.0,
    this.dragThreshold = 100.0,
  });

  @override
  State<EnhancedSwipeBackGesture> createState() =>
      _EnhancedSwipeBackGestureState();
}

class _EnhancedSwipeBackGestureState extends State<EnhancedSwipeBackGesture>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  bool _isDragging = false;
  bool _isValidSwipe = false;
  double _dragDistance = 0;
  double _startX = 0;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _handlePanStart(DragStartDetails details) {
    _startX = details.localPosition.dx;

    if (_startX <= widget.edgeWidth) {
      _isValidSwipe = true;
      _isDragging = true;
      widget.onSwipeStart?.call();

      HapticFeedback.selectionClick();
    }
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (!_isValidSwipe) return;

    final currentX = details.localPosition.dx;
    _dragDistance = currentX - _startX;

    if (_dragDistance > 0) {
      final progress = (_dragDistance / widget.dragThreshold).clamp(0.0, 1.0);

      _slideController.value = progress;
      _scaleController.value = progress * 0.5;

      if (_dragDistance > widget.dragThreshold * 0.7 && !_isDragging) {
        HapticFeedback.mediumImpact();
        _isDragging = true;
      }
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    if (!_isValidSwipe) return;

    final velocity = details.velocity.pixelsPerSecond.dx;
    final shouldNavigateBack =
        velocity > widget.velocityThreshold ||
        _dragDistance > widget.dragThreshold;

    if (shouldNavigateBack) {
      HapticFeedback.heavyImpact();

      _slideController.forward().then((_) {
        widget.pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
        );
        _resetAnimations();
      });

      widget.onSwipeEnd?.call();
    } else {
      _slideController.reverse();
      _scaleController.reverse();
      HapticFeedback.selectionClick();
    }

    _isValidSwipe = false;
    _isDragging = false;
    _dragDistance = 0;
  }

  void _resetAnimations() {
    _slideController.reset();
    _scaleController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handlePanStart,
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      child: AnimatedBuilder(
        animation: Listenable.merge([_slideAnimation, _scaleAnimation]),
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              boxShadow: _slideAnimation.value > 0
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          0.1 * _slideAnimation.value,
                        ),
                        blurRadius: 10 * _slideAnimation.value,
                        offset: Offset(-5 * _slideAnimation.value, 0),
                      ),
                    ]
                  : null,
            ),
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.translate(
                offset: Offset(_slideAnimation.value * 20, 0),
                child: Stack(
                  children: [
                    widget.child,

                    if (_slideAnimation.value > 0)
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        width: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.withOpacity(_slideAnimation.value),
                                Colors.blue.withOpacity(
                                  _slideAnimation.value * 0.5,
                                ),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(2),
                              bottomRight: Radius.circular(2),
                            ),
                          ),
                        ),
                      ),

                    if (_slideAnimation.value > 0.3)
                      Positioned(
                        left: 20,
                        top: MediaQuery.of(context).size.height / 2 - 12,
                        child: Opacity(
                          opacity: ((_slideAnimation.value - 0.3) * 2.5).clamp(
                            0.0,
                            1.0,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white.withOpacity(0.8),
                            size: 24,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
