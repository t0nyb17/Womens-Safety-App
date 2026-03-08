import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../utils/colors.dart';
import '../services/alert_service.dart';

class SafeWalkScreen extends StatefulWidget {
  const SafeWalkScreen({super.key});

  @override
  _SafeWalkScreenState createState() => _SafeWalkScreenState();
}

class _SafeWalkScreenState extends State<SafeWalkScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _selectedMinutes = 15;
  int _totalSeconds = 15 * 60;
  int _remainingSeconds = 15 * 60;
  bool _isRunning = false;
  late AnimationController _progressController;
  final AlertService _alertService = AlertService();

  final List<int> _durations = [5, 10, 15, 30, 60];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: Duration(seconds: _totalSeconds),
    );
  }

  void _startWalk() {
    final total = _selectedMinutes * 60;
    setState(() {
      _isRunning = true;
      _totalSeconds = total;
      _remainingSeconds = total;
    });
    _progressController.duration = Duration(seconds: total);
    _progressController.forward(from: 0.0);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _remainingSeconds--);
      if (_remainingSeconds <= 0) {
        _timer?.cancel();
        _progressController.stop();
        setState(() => _isRunning = false);
        HapticFeedback.heavyImpact();
        _alertService.sendSOSAlert(context);
        _showSOSTriggeredDialog();
      }
    });
    HapticFeedback.mediumImpact();
  }

  void _checkIn() {
    setState(() => _remainingSeconds = _totalSeconds);
    _progressController.forward(from: 0.0);
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Check-in successful! Timer reset.'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _stopWalk() {
    _timer?.cancel();
    _progressController.reset();
    setState(() {
      _isRunning = false;
      _remainingSeconds = _selectedMinutes * 60;
    });
  }

  void _showSOSTriggeredDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text('SOS Triggered'),
          ],
        ),
        content: const Text(
            'Your safe walk timer expired. An SOS alert has been sent.'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  double get _progress =>
      _totalSeconds == 0 ? 0.0 : 1.0 - (_remainingSeconds / _totalSeconds);

  bool get _isUrgent => _isRunning && _remainingSeconds < 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Safe Walk'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () {
            _stopWalk();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          children: [
            // Info card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(14),
                border:
                    Border.all(color: const Color(0xFFFFD54F), width: 1),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline_rounded,
                      color: Color(0xFFE65100), size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'If you don\'t check in before the timer ends, an SOS alert will be sent automatically.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4E342E),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Timer circle
            SizedBox(
              width: 210,
              height: 210,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 210,
                    height: 210,
                    child: CircularProgressIndicator(
                      value: _isRunning ? _progress : 0.0,
                      strokeWidth: 9,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _isUrgent ? AppColors.sosRed : AppColors.primary,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isRunning
                            ? _formatTime(_remainingSeconds)
                            : _formatTime(_selectedMinutes * 60),
                        style: TextStyle(
                          fontSize: 46,
                          fontWeight: FontWeight.w700,
                          color: _isUrgent
                              ? AppColors.sosRed
                              : AppColors.textPrimary,
                          letterSpacing: -1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _isRunning ? 'remaining' : 'duration',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Duration selector
            if (!_isRunning) ...[
              const Text(
                'Select Duration',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: _durations.map((minutes) {
                  final selected = _selectedMinutes == minutes;
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedMinutes = minutes;
                      _remainingSeconds = minutes * 60;
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Text(
                        '${minutes}m',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],
            // Action buttons
            if (!_isRunning)
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _startWalk,
                  icon: const Icon(Icons.directions_walk_rounded,
                      color: Colors.white),
                  label: const Text(
                    'Start Safe Walk',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              )
            else
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: _checkIn,
                      icon: const Icon(Icons.check_circle_outline_rounded,
                          color: Colors.white),
                      label: const Text(
                        "I'm Safe — Check In",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: OutlinedButton(
                      onPressed: _stopWalk,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Cancel Walk',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    super.dispose();
  }
}
