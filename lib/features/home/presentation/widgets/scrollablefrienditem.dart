import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/widget/OnlineAvatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSlidableMessageItem extends StatefulWidget {
  // final String name;
  // final String message;
  // final String time;
  // final String avatarUrl;
  // final int unreadCount;
  final bool isOnline;
  final VoidCallback? onTap;
  final VoidCallback? onMute;
  final VoidCallback? onDelete;

  const CustomSlidableMessageItem({
    super.key,
    // required this.name,
    // required this.message,
    // required this.time,
    // required this.avatarUrl,
    // this.unreadCount = 0,
    this.isOnline = true,
    this.onTap,
    this.onMute,
    this.onDelete,
  });

  @override
  State<CustomSlidableMessageItem> createState() =>
      _CustomSlidableMessageItemState();
}

class _CustomSlidableMessageItemState extends State<CustomSlidableMessageItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  double _dragStartX = 0;
  double _currentOffset = 0;
  final double _maxSlideDistance = 120;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(-1, 0)).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _dragStartX = details.globalPosition.dx;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final dragDistance = _dragStartX - details.globalPosition.dx;

    setState(() {
      _currentOffset = dragDistance.clamp(0, _maxSlideDistance);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_currentOffset > _maxSlideDistance * 0.5) {
      // Snap to open position
      setState(() {
        _currentOffset = _maxSlideDistance;
      });
    } else {
      setState(() {
        _currentOffset = 0;
      });
    }
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 60,
          height: double.infinity,
          color: Color(0xffF1F6FA),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                widget.onMute?.call();
                setState(() {
                  _currentOffset = 0;
                  _isMuted = !_isMuted;
                });
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.black,
                    shape: BoxShape.circle,
                  ),
                  child: _isMuted
                      ? Icon(CupertinoIcons.bell_slash, color: Colors.white)
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
              onTap: () {
                widget.onDelete?.call();
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      color: _currentOffset > 0 ? Color(0xffF1F6FA) : AppTheme.primary,
      child: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: InkWell(
          onTap: () {
            if (_currentOffset > 0) {
              setState(() {
                _currentOffset = 0;
              });
            } else {
              widget.onTap?.call();
            }
          },
          child: SizedBox(
            height: size.height * 0.1,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  width: _maxSlideDistance,
                  child: _buildActionButtons(),
                ),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: Matrix4.translationValues(-_currentOffset, 0, 0),
                  child: Material(
                    color: _currentOffset > 0
                        ? Color(0xffF1F6FA)
                        : AppTheme.primary,
                    child: SizedBox(
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
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(color: AppTheme.black),
                        ),
                        subtitle: Text(
                          'Hello',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: AppTheme.gray),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '2 min ago',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppTheme.gray),
                            ),
                            SizedBox(height: 5),
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: AppTheme.red,
                              child: Text(
                                '1',
                                style: Theme.of(context).textTheme.bodySmall
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
