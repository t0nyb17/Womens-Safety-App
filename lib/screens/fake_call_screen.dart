import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../utils/colors.dart';

class FakeCallScreen extends StatefulWidget {
  const FakeCallScreen({super.key});

  @override
  _FakeCallScreenState createState() => _FakeCallScreenState();
}

class _FakeCallScreenState extends State<FakeCallScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  Timer? _vibrationTimer;
  Timer? _callDurationTimer;

  bool _callAccepted = false;
  int _callSeconds = 0;
  String _callerName = 'Mom';

  final List<String> _callerOptions = [
    'Mom',
    'Dad',
    'Sister',
    'Brother',
    'Friend',
    'Work',
  ];

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.18).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _vibrationTimer =
        Timer.periodic(const Duration(milliseconds: 1800), (_) {
      if (!_callAccepted) HapticFeedback.vibrate();
    });
    HapticFeedback.vibrate();
  }

  void _acceptCall() {
    setState(() => _callAccepted = true);
    _vibrationTimer?.cancel();
    _callDurationTimer =
        Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _callSeconds++);
    });
  }

  void _declineCall() => Navigator.pop(context);

  String _formatDuration(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: _callAccepted ? _buildInCall() : _buildIncoming(),
      ),
    );
  }

  Widget _buildIncoming() {
    return Column(
      children: [
        const Spacer(flex: 2),
        // Caller avatar with pulse
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, _) => Transform.scale(
            scale: _pulseAnimation.value,
            child: Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.primaryLight],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.45),
                    blurRadius: 32,
                    spreadRadius: 8,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _callerName[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        // Caller name dropdown
        Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(0xFF1E1E30),
          ),
          child: DropdownButton<String>(
            value: _callerName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
            underline: const SizedBox(),
            icon: const Icon(Icons.expand_more_rounded,
                color: Colors.white38, size: 22),
            dropdownColor: const Color(0xFF1E1E30),
            items: _callerOptions
                .map((name) => DropdownMenuItem(
                      value: name,
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (val) => setState(() => _callerName = val!),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Incoming Call...',
          style: TextStyle(color: Colors.white38, fontSize: 15),
        ),
        const Spacer(flex: 3),
        // Call action buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CallActionButton(
                icon: Icons.call_end_rounded,
                color: const Color(0xFFD32F2F),
                label: 'Decline',
                onTap: _declineCall,
              ),
              _CallActionButton(
                icon: Icons.call_rounded,
                color: const Color(0xFF2E7D32),
                label: 'Accept',
                onTap: _acceptCall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInCall() {
    return Column(
      children: [
        const Spacer(flex: 2),
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryLight],
            ),
          ),
          child: Center(
            child: Text(
              _callerName[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          _callerName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _formatDuration(_callSeconds),
          style: const TextStyle(color: Colors.white38, fontSize: 15),
        ),
        const Spacer(flex: 3),
        GestureDetector(
          onTap: _declineCall,
          child: Container(
            width: 68,
            height: 68,
            decoration: const BoxDecoration(
              color: Color(0xFFD32F2F),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.call_end_rounded,
                color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _vibrationTimer?.cancel();
    _callDurationTimer?.cancel();
    super.dispose();
  }
}

class _CallActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _CallActionButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 13),
        ),
      ],
    );
  }
}
