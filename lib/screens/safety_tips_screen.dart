import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../data/safety_tips_data.dart';
import '../widgets/safety_tip_card.dart';

class SafetyTipsScreen extends StatelessWidget {
  const SafetyTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPink,
      appBar: AppBar(
        title: const Text('Safety Tips'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: safetyTipsData.length,
        itemBuilder: (context, index) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 300 + (index * 100)),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: SafetyTipCard(
                    tip: safetyTipsData[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}