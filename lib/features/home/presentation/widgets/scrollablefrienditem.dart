import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/widget/online_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CustomSlidableMessageItem extends StatefulWidget {
  final bool isOnline;
  final VoidCallback? onTap;
  final VoidCallback? onMute;
  final VoidCallback? onDelete;
  final VoidCallback? onSwipeBack; // New callback for right swipe
  final double slideThreshold;
  final double velocityThreshold;
  final double maxSlideDistance;
  final double edgeWidth; // Width from left edge to trigger back swipe
  final double backSwipeThreshold; // Threshold for back swipe

  const CustomSlidableMessageItem({
    super.key,
    this.isOnline = true,
    this.onTap,
    this.onMute,
    this.onDelete,
    this.onSwipeBack,
    this.slideThreshold = 60.0,
    this.velocityThreshold = 400.0,
    this.maxSlideDistance = 120.0,
    this.edgeWidth = 80.0,
    this.backSwipeThreshold = 100.0,
  });

  @override
  State<CustomSlidableMessageItem> createState() =>
      _CustomSlidableMessageItemState();
}

class _CustomSlidableMessageItemState extends State<CustomSlidableMessageItem>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _bounceController;
  late AnimationController _scaleController;
  late AnimationController _backSwipeController;

  late Animation<double> _slideAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<double> _scaleAnimation;

  double _currentOffset = 0;
  double _backSwipeOffset = 0;
  double _startX = 0;
  bool _isMuted = false;
  bool _isValidSlide = false;
  bool _isValidBackSwipe = false;
  bool _isBackSwiping = false;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _backSwipeController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeOut));

    // _backSwipeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(parent: _backSwipeController, curve: Curves.easeOutCubic),
    // );
  }

  @override
  void dispose() {
    _slideController.dispose();
    _bounceController.dispose();
    _scaleController.dispose();
    _backSwipeController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _startX = details.localPosition.dx;
    _isValidSlide = false;
    _isValidBackSwipe = false;

    if (_startX <= widget.edgeWidth) {
      _isValidBackSwipe = true;
      _isBackSwiping = true;
      HapticFeedback.selectionClick();
    }

    _scaleController.forward();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final currentX = details.localPosition.dx;
    final dragDistance = _startX - currentX;
    final rightDragDistance = currentX - _startX;

    if (_isValidBackSwipe && rightDragDistance > 0) {
      _backSwipeOffset = rightDragDistance;
      final progress = (rightDragDistance / widget.backSwipeThreshold).clamp(
        0.0,
        1.0,
      );

      _backSwipeController.value = progress;

      if (progress > 0.7 && !_isBackSwiping) {
        HapticFeedback.mediumImpact();
        _isBackSwiping = true;
      }

      setState(() {});
      return;
    }

    if (dragDistance > 10) {
      _isValidSlide = true;

      final progress = (dragDistance / widget.maxSlideDistance).clamp(0.0, 1.0);
      _currentOffset = dragDistance.clamp(0.0, widget.maxSlideDistance);

      _slideController.value = progress;

      if (progress > 0.5 && !_bounceController.isAnimating) {
        try {
          HapticFeedback.selectionClick();
        } catch (e) {}
      }

      setState(() {});
    } else if (dragDistance < -10) {
      if (_currentOffset > 0) {
        _closeSlide();
      }
    }
  }

  void _onPanEnd(DragEndDetails details) {
    _scaleController.reverse();

    final velocity = details.velocity.pixelsPerSecond.dx;

    if (_isValidBackSwipe) {
      final shouldNavigateBack =
          velocity > widget.velocityThreshold ||
          _backSwipeOffset > widget.backSwipeThreshold;

      if (shouldNavigateBack) {
        HapticFeedback.heavyImpact();

        _backSwipeController.forward().then((_) {
          widget.onSwipeBack?.call();
          _resetBackSwipe();
        });
      } else {
        _backSwipeController.reverse();
        HapticFeedback.selectionClick();
        _resetBackSwipe();
      }

      _isValidBackSwipe = false;
      _isBackSwiping = false;
      return;
    }

    if (!_isValidSlide) return;

    final shouldOpen =
        velocity < -widget.velocityThreshold ||
        _currentOffset > widget.slideThreshold;

    if (shouldOpen) {
      _openSlide();
    } else {
      _closeSlide();
    }
    _isValidSlide = false;
  }

  void _resetBackSwipe() {
    _backSwipeOffset = 0;
    _backSwipeController.reset();
  }

  void _openSlide() {
    _slideController.forward();
    _currentOffset = widget.maxSlideDistance;

    _bounceController.forward().then((_) {
      if (mounted) _bounceController.reverse();
    });

    try {
      HapticFeedback.mediumImpact();
    } catch (e) {}

    setState(() {});
  }

  void _closeSlide() {
    _slideController.reverse();
    _currentOffset = 0;

    try {
      HapticFeedback.selectionClick();
    } catch (e) {}

    setState(() {});
  }

  void _onMuteTap() {
    widget.onMute?.call();
    setState(() {
      _isMuted = !_isMuted;
    });
    _closeSlide();

    try {
      HapticFeedback.mediumImpact();
    } catch (e) {}
  }

  void _onDeleteTap() {
    HapticFeedback.heavyImpact();

    widget.onDelete?.call();
  }

  Widget _buildActionButtons() {
    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _bounceAnimation.value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 60,
                height: double.infinity,
                color: Color(0xffF1F6FA),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _onMuteTap,
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _isMuted ? Colors.orange : AppTheme.black,
                          shape: BoxShape.circle,
                        ),
                        child: _isMuted
                            ? Icon(
                                CupertinoIcons.bell_slash,
                                color: Colors.white,
                                size: 20,
                              )
                            : SvgPicture.asset('assets/svg/notification.svg'),
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                width: 60,
                height: double.infinity,
                color: Color(0xffF1F6FA),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _onDeleteTap,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.red,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset('assets/svg/Vector.svg'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Material(
            color: _currentOffset > 0 ? Color(0xffF1F6FA) : AppTheme.primary,
            elevation: _currentOffset > 0 ? 2 : 0,
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: InkWell(
                onTap: () {
                  if (_currentOffset > 0) {
                    _closeSlide();
                  } else {
                    widget.onTap?.call();
                  }
                },
                child: SizedBox(
                  height: size.height * 0.1,
                  child: Stack(
                    children: [
                      if (_currentOffset > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          width: widget.maxSlideDistance,
                          child: _buildActionButtons(),
                        ),

                      AnimatedBuilder(
                        animation: _slideAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                              -_slideAnimation.value * widget.maxSlideDistance,
                              0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _currentOffset > 0
                                    ? Color(0xffF1F6FA)
                                    : AppTheme.primary,
                                boxShadow: _currentOffset > 0
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(-4, 0),
                                        ),
                                      ]
                                    : null,
                              ),
                              height: size.height * 0.1,
                              child: ListTile(
                                leading: OnlineAvatar(
                                  imagePath: 'assets/images/model1.png',
                                  isOnline: widget.isOnline,
                                  radius: 25,
                                  onTap: () {
                                    print("Avatar tapped");
                                  },
                                ),
                                title: Text(
                                  'Abdelrahman Ghareeb',
                                  softWrap: true,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(color: AppTheme.black),
                                ),
                                subtitle: Text(
                                  'Hello',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: AppTheme.gray),
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '2 min ago',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: AppTheme.gray),
                                    ),
                                    SizedBox(height: 5),
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundColor: AppTheme.red,
                                      child: Text(
                                        '1',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: AppTheme.primary,
                                              fontSize: 10,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
