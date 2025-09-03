import 'package:chatbox/features/home/data/models/storymodels/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DraggableTextOverlay extends StatefulWidget {
  final TextOverlay overlay;
  final double width;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Function(Offset) onPositionChanged;

  const DraggableTextOverlay({
    super.key,
    required this.overlay,
    required this.onTap,
    required this.onLongPress,
    required this.onPositionChanged,
    required this.width,
  });

  @override
  State<DraggableTextOverlay> createState() => _DraggableTextOverlayState();
}

class _DraggableTextOverlayState extends State<DraggableTextOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  Offset _currentPosition = Offset.zero;
  bool _isDragging = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.overlay.position;

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didUpdateWidget(DraggableTextOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.overlay.position != widget.overlay.position && !_isDragging) {
      _currentPosition = widget.overlay.position;
    }
  }

  void _onPanStart(DragStartDetails details) {
    _isDragging = true;
    _isPressed = true;
    _scaleController.forward();
    HapticFeedback.selectionClick();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    setState(() {
      _currentPosition += details.delta;
    });

    widget.onPositionChanged(_currentPosition);
  }

  void _onPanEnd(DragEndDetails details) {
    _isDragging = false;
    _isPressed = false;
    _scaleController.reverse();
    HapticFeedback.lightImpact();
  }

  void _onTapDown(TapDownDetails details) {
    if (!_isDragging) {
      setState(() => _isPressed = true);
      _scaleController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (!_isDragging && _isPressed) {
      setState(() => _isPressed = false);
      _scaleController.reverse();
      widget.onTap();
      HapticFeedback.selectionClick();
    }
  }

  void _onTapCancel() {
    if (!_isDragging && _isPressed) {
      setState(() => _isPressed = false);
      _scaleController.reverse();
    }
  }

  void _onLongPressStart(LongPressStartDetails details) {
    if (!_isDragging) {
      HapticFeedback.mediumImpact();
      widget.onLongPress();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screendim = MediaQuery.of(context).size;

    return Positioned(
      left: _currentPosition.dx,
      top: _currentPosition.dy,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              onTapCancel: _onTapCancel,
              onLongPressStart: _onLongPressStart,
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: AnimatedContainer(
                constraints: BoxConstraints(maxWidth: screendim.width * 0.9),
                duration: Duration(milliseconds: _isDragging ? 0 : 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: widget.overlay.getBackgroundColor(),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _isDragging || _isPressed
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Text(
                  widget.overlay.text,
                  maxLines: 8,
                  softWrap: true,
                  textAlign: widget.overlay.textAlign,
                  style: TextStyle(
                    color: widget.overlay.color,
                    fontSize: widget.overlay.fontSize,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: const Offset(1, 1),
                        blurRadius: 3,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
