import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../models/safety_tip.dart';

class SafetyTipCard extends StatelessWidget {
  final SafetyTip tip;
  final int index;

  const SafetyTipCard({Key? key, required this.tip, this.index = 0})
      : super(key: key);

  static const List<List<Color>> _gradients = [
    [Color(0xFF8B1A4A), Color(0xFFB5396E)],
    [Color(0xFF1565C0), Color(0xFF2196F3)],
    [Color(0xFF2E7D32), Color(0xFF43A047)],
    [Color(0xFFBF360C), Color(0xFFE64A19)],
    [Color(0xFF4A148C), Color(0xFF7B1FA2)],
    [Color(0xFF006064), Color(0xFF00838F)],
    [Color(0xFF1A237E), Color(0xFF3949AB)],
    [Color(0xFF880E4F), Color(0xFFC2185B)],
  ];

  @override
  Widget build(BuildContext context) {
    final gradient = _gradients[index % _gradients.length];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradient,
              ),
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(18),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tip.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tip.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
