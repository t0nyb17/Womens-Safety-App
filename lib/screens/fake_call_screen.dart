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
  late AnimationController _ring1Controller;
  late AnimationController _ring2Controller;
  late Animation<double> _ring1Animation;
  late Animation<double> _ring2Animation;
  Timer? _vibrationTimer;
  Timer? _callDurationTimer;

  bool _callAccepted = false;
  int _callSeconds = 0;
  String _callerName = 'Mom';
  bool _isMuted = false;
  bool _isSpeaker = false;

  final List<String> _callerOptions = [
    'Mom', 'Dad', 'Sister', 'Brother', 'Friend', 'Work'
  ];

  @override
  void initState() {
    super.initState();

    _ring1Controller = AnimationController(
        duration: const Duration(milliseconds: 1600), vsync: this)
      ..repeat();
    _ring2Controller = AnimationController(
        duration: const Duration(milliseconds: 1600), vsync: this);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _ring2Controller.repeat();
    });

    _ring1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ring1Controller, curve: Curves.easeOut),
    );
    _ring2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ring2Controller, curve: Curves.easeOut),
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0F1E),
        body: _callAccepted ? _buildInCall() : _buildIncoming(),
      ),
    );
  }

  Widget _buildIncoming() {
    return Stack(
      children: [
        // Background gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1A1A2E), Color(0xFF0A0F1E)],
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                'Incoming call',
                style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                    letterSpacing: 0.5),
              ),
              const Spacer(flex: 1),
              // Fixed-size box prevents rings from shifting layout
              SizedBox(
                width: 220,
                height: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _ring1Animation,
                      builder: (_, __) => Container(
                        width: 100 + (_ring1Animation.value * 110),
                        height: 100 + (_ring1Animation.value * 110),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withOpacity(
                                0.45 * (1 - _ring1Animation.value)),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _ring2Animation,
                      builder: (_, __) => Container(
                        width: 100 + (_ring2Animation.value * 110),
                        height: 100 + (_ring2Animation.value * 110),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withOpacity(
                                0.45 * (1 - _ring2Animation.value)),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    // Caller avatar
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.primary, AppColors.primaryLight],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.4),
                            blurRadius: 28,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _callerName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Caller name picker (outside animation scope — no pulsing)
              Theme(
                data: Theme.of(context)
                    .copyWith(canvasColor: const Color(0xFF1E1E30)),
                child: DropdownButton<String>(
                  value: _callerName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                  underline: const SizedBox(),
                  icon: const Icon(Icons.expand_more_rounded,
                      color: Colors.white38, size: 22),
                  dropdownColor: const Color(0xFF1E1E30),
                  items: _callerOptions
                      .map((name) => DropdownMenuItem(
                            value: name,
                            child: Text(name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600)),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => _callerName = val!),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Mobile',
                style: TextStyle(
                    color: Colors.white38,
                    fontSize: 14,
                    letterSpacing: 0.3),
              ),
              const Spacer(flex: 2),
              // Quick actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 52),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _QuickCallAction(
                        icon: Icons.alarm_rounded, label: 'Remind me'),
                    _QuickCallAction(
                        icon: Icons.message_rounded, label: 'Message'),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Accept / Decline buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 44),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CallActionButton(
                      icon: Icons.call_end_rounded,
                      color: const Color(0xFFEF5350),
                      label: 'Decline',
                      onTap: _declineCall,
                    ),
                    _CallActionButton(
                      icon: Icons.call_rounded,
                      color: const Color(0xFF43A047),
                      label: 'Accept',
                      onTap: _acceptCall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 52),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInCall() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0F1F0F), Color(0xFF0A0F0A)],
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),
              // Active call indicator
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color(0xFF43A047).withOpacity(0.45)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                          color: Color(0xFF66BB6A), shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    const Text('Active call',
                        style: TextStyle(
                            color: Color(0xFF66BB6A),
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              // Caller avatar
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.primaryLight],
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.primary.withOpacity(0.35),
                        blurRadius: 20,
                        spreadRadius: 4),
                  ],
                ),
                child: Center(
                  child: Text(_callerName[0].toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 16),
              Text(_callerName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              // Call duration timer
              Text(_formatDuration(_callSeconds),
                  style: const TextStyle(
                      color: Color(0xFF66BB6A),
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              const Spacer(flex: 2),
              // In-call controls
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _InCallButton(
                      icon: _isMuted
                          ? Icons.mic_off_rounded
                          : Icons.mic_rounded,
                      label: 'Mute',
                      isActive: _isMuted,
                      onTap: () => setState(() => _isMuted = !_isMuted),
                    ),
                    _InCallButton(
                      icon: Icons.dialpad_rounded,
                      label: 'Keypad',
                      isActive: false,
                      onTap: () {},
                    ),
                    _InCallButton(
                      icon: _isSpeaker
                          ? Icons.volume_up_rounded
                          : Icons.hearing_rounded,
                      label: 'Speaker',
                      isActive: _isSpeaker,
                      onTap: () =>
                          setState(() => _isSpeaker = !_isSpeaker),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // End call button
              Column(
                children: [
                  GestureDetector(
                    onTap: _declineCall,
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF5350),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color:
                                  const Color(0xFFEF5350).withOpacity(0.5),
                              blurRadius: 18,
                              spreadRadius: 2),
                        ],
                      ),
                      child: const Icon(Icons.call_end_rounded,
                          color: Colors.white, size: 30),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('End',
                      style:
                          TextStyle(color: Colors.white54, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 52),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _ring1Controller.dispose();
    _ring2Controller.dispose();
    _vibrationTimer?.cancel();
    _callDurationTimer?.cancel();
    super.dispose();
  }
}

class _QuickCallAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickCallAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white70, size: 22),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: const TextStyle(color: Colors.white38, fontSize: 11)),
      ],
    );
  }
}

class _InCallButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _InCallButton(
      {required this.icon,
      required this.label,
      required this.isActive,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white.withOpacity(0.25)
                  : Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon,
                color: isActive ? Colors.white : Colors.white70, size: 24),
          ),
          const SizedBox(height: 6),
          Text(label,
              style:
                  const TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }
}

class _CallActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;
  const _CallActionButton(
      {required this.icon,
      required this.color,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 4)
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
        const SizedBox(height: 10),
        Text(label,
            style: const TextStyle(
                color: Colors.white60,
                fontSize: 13,
                fontWeight: FontWeight.w400)),
      ],
    );
  }
}
