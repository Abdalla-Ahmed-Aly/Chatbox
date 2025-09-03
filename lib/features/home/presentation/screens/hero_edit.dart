import 'package:another_xlider/another_xlider.dart';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/home/presentation/widgets/shrink_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextEditScreen extends StatefulWidget {
  final String imageName;
  final String? initialText;
  final Color? initialColor;
  final double? initialFontSize;
  final int? initialBackgroundCount;
  final Function(String, Color, double, int, TextAlign) onTextSubmitted;

  const TextEditScreen({
    super.key,
    required this.imageName,
    this.initialBackgroundCount,
    this.initialColor,
    this.initialFontSize,
    this.initialText,
    required this.onTextSubmitted,
  });

  @override
  State<TextEditScreen> createState() => _TextEditScreenState();
}

class _TextEditScreenState extends State<TextEditScreen>
    with TickerProviderStateMixin {
  late TextEditingController _textController;
  late FocusNode _focusNode;
  late Color _selectedColor;
  late Color _originalColor;
  late double _fontSize;
  int _textAlignmentIndex = 0;
  int _backgroundCount = 0;
  bool _isKeyboardVisible = false;

  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  final List<GlobalKey> excludedKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  static const List<Color> _colors = [
    Colors.white,
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.amber,
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeValues();
    _setupKeyboardListener();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _onKeyboardClosed();
      }
    });
  }

  void _onKeyboardClosed() {
    _textController.text.isNotEmpty ? _submitText() : Navigator.pop(context);
  }

  void _initializeControllers() {
    _textController = TextEditingController(text: widget.initialText ?? '');
    _focusNode = FocusNode();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    // Start animations
    _fadeController.forward();
    _scaleController.forward();

    // Auto-focus after animation
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  void _initializeValues() {
    _selectedColor = widget.initialColor ?? Colors.white;
    _originalColor = _selectedColor;
    _fontSize = widget.initialFontSize ?? 32.0;
    _backgroundCount = widget.initialBackgroundCount ?? 0;
  }

  void _setupKeyboardListener() {
    _focusNode.addListener(() {
      if (mounted) {
        setState(() {
          _isKeyboardVisible = _focusNode.hasFocus;
        });
      }
    });
  }

  void _cycleTextAlignment() {
    setState(() {
      _textAlignmentIndex = (_textAlignmentIndex + 1) % 3;
    });
    HapticFeedback.selectionClick();
  }

  void _cycleBackgroundColor() {
    setState(() {
      _backgroundCount = (_backgroundCount + 1) % 3;
    });
    HapticFeedback.selectionClick();
  }

  Color _lightenColor(Color color, [double amount = 0.3]) {
    final hsl = HSLColor.fromColor(color);
    final lighter = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return lighter.toColor();
  }

  Color _getBackgroundColor() {
    switch (_backgroundCount) {
      case 0:
        _selectedColor = _originalColor;
        return Colors.transparent;
      case 1:
        if (_selectedColor == Colors.white) {
          return Colors.black.withOpacity(0.8);
        } else if (_selectedColor == Colors.black) {
          return Colors.white.withOpacity(0.8);
        } else {
          return _lightenColor(_selectedColor).withOpacity(0.8);
        }
      case 2:
        if (_selectedColor == Colors.white) {
          _selectedColor = Colors.black;
          return Colors.white.withOpacity(0.8);
        } else if (_selectedColor == Colors.black) {
          _selectedColor = Colors.white;
          return Colors.black.withOpacity(0.8);
        } else {
          final bgColor = _selectedColor;
          _selectedColor = _lightenColor(_selectedColor);
          return bgColor.withOpacity(0.8);
        }
      default:
        return Colors.transparent;
    }
  }

  TextAlign get _currentTextAlign {
    switch (_textAlignmentIndex) {
      case 0:
        return TextAlign.center;
      case 1:
        return TextAlign.left;
      case 2:
        return TextAlign.right;
      default:
        return TextAlign.center;
    }
  }

  IconData get _currentAlignIcon {
    switch (_textAlignmentIndex) {
      case 0:
        return FontAwesomeIcons.alignCenter;
      case 1:
        return FontAwesomeIcons.alignLeft;
      case 2:
        return FontAwesomeIcons.alignRight;
      default:
        return FontAwesomeIcons.alignCenter;
    }
  }

  void _submitText() {
    if (_textController.text.trim().isNotEmpty) {
      HapticFeedback.mediumImpact();
      widget.onTextSubmitted(
        _textController.text.trim(),
        _selectedColor,
        _fontSize,
        _backgroundCount,
        _currentTextAlign,
      );
    } else {
      HapticFeedback.lightImpact();
      _focusNode.requestFocus();
    }
  }

  void _cancel() {
    HapticFeedback.mediumImpact();
    Navigator.pop(context);
  }

  bool _isInsideExcludedWidgets(Offset globalPosition) {
    for (final key in excludedKeys) {
      final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) continue;

      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      final rect = position & size;

      if (rect.contains(globalPosition)) {
        return true; // tapped inside one of the excluded widgets
      }
    }
    return false;
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: _buildMainContent(screenSize, keyboardHeight),
        ),
      ),
    );
  }

  Widget _buildMainContent(Size screenSize, double keyboardHeight) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: MediaQuery.of(context).padding.top + 20,
        bottom: keyboardHeight + 20,
      ),
      child: Column(
        children: [
          _buildTopBar(),

          SizedBox(height: 20),

          Row(
            children: [
              SizedBox(
                key: excludedKeys[3],
                height: 200,
                width: 40,
                child: FlutterSlider(
                  values: [_fontSize],
                  min: 16,
                  max: 48,
                  axis: Axis.vertical,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    setState(() {
                      _fontSize = lowerValue;
                    });
                  },
                ),
              ),

              _buildTextInputArea(screenSize),
            ],
          ),

          SizedBox(height: 20),

          if (!_isKeyboardVisible) _buildColorPicker(),

          _buildControlButtons(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIconButton(icon: Icons.close, size: 30, onTap: _cancel),
        Text(
          'Add Text',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        _buildIconButton(icon: Icons.check, size: 30, onTap: _submitText),
      ],
    );
  }

  Widget _buildTextInputArea(Size screendim) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screendim.width * 0.78,
            child: ShrinkTextField(
              maxWidth: screendim.width * 0.78,
              textController: _textController,
              color: _selectedColor,
              backGroundColor: _getBackgroundColor(),
              fontSize: _fontSize,
              onTapOustSide: (event) {
                if (!_isInsideExcludedWidgets(event.position)) {
                  if (_textController.text.isEmpty) {
                    HapticFeedback.lightImpact();
                    Navigator.pop(context);
                  } else {
                    _submitText();
                  }
                }
              },
              onTapUpOustSide: (event) {
                if (!_isInsideExcludedWidgets(event.position)) {
                  if (_textController.text.isEmpty) {
                    HapticFeedback.lightImpact();
                    Navigator.pop(context);
                  } else {
                    _submitText();
                  }
                }
              },
              textAlign: _currentTextAlign,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorPicker() {
    return SizedBox(
      key: excludedKeys[2],
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _colors.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final color = _colors[index];
          final isSelected = _originalColor == color;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = color;
                _originalColor = color;
              });
              HapticFeedback.selectionClick();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 45 : 35,
              height: isSelected ? 45 : 35,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.transparent,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildControlButton(
          key: excludedKeys[0],
          icon: _currentAlignIcon,
          label: 'Align',
          onTap: _cycleTextAlignment,
        ),
        _buildControlButton(
          key: excludedKeys[1],
          icon: FontAwesomeIcons.palette,
          label: 'Background',
          onTap: _cycleBackgroundColor,
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required GlobalKey key,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      key: key,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(icon, color: AppTheme.primary, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
    double? size,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, color: Colors.white, size: size ?? 24),
        ),
      ),
    );
  }
}
