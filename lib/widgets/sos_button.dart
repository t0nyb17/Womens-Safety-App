import 'package:flutter/material.dart';
import '../utils/colors.dart';

class SOSButton extends StatefulWidget {
  final VoidCallback onPressed;

  const SOSButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  _SOSButtonState createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _pressController;
  late Animation<double> _ring1;
  late Animation<double> _ring1Opacity;
  late Animation<double> _ring2;
  late Animation<double> _ring2Opacity;
  late Animation<double> _pressScale;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2200),
      vsync: this,
    )..repeat();

    _pressController = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );

    _ring1 = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );
    _ring1Opacity = Tween<double>(begin: 0.3, end: 0.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );

    _ring2 = Tween<double>(begin: 1.0, end: 1.85).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: const Interval(0.15, 1.0, curve: Curves.easeOut),
      ),
    );
    _ring2Opacity = Tween<double>(begin: 0.15, end: 0.0).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: const Interval(0.15, 1.0, curve: Curves.easeOut),
      ),
    );

    _pressScale = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _pressController.forward();
        setState(() => _isPressed = true);
      },
      onTapUp: (_) {
        _pressController.reverse();
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () {
        _pressController.reverse();
        setState(() => _isPressed = false);
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([_pulseController, _pressController]),
        builder: (context, _) {
          return SizedBox(
            width: 230,
            height: 230,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.scale(
                  scale: _ring2.value,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.sosRed.withOpacity(_ring2Opacity.value),
                    ),
                  ),
                ),
                Transform.scale(
                  scale: _ring1.value,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.sosRed.withOpacity(_ring1Opacity.value),
                    ),
                  ),
                ),
                Transform.scale(
                  scale: _pressScale.value,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        center: Alignment(-0.25, -0.25),
                        colors: [
                          Color(0xFFEF5350),
                          AppColors.sosRed,
                          AppColors.sosDark,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.sosRed
                              .withOpacity(_isPressed ? 0.2 : 0.5),
                          blurRadius: _isPressed ? 12 : 32,
                          spreadRadius: _isPressed ? 2 : 6,
                        ),
                      ],
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SOS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 44,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 3,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'EMERGENCY',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ],
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

  @override
  void dispose() {
    _pulseController.dispose();
    _pressController.dispose();
    super.dispose();
  }
}
