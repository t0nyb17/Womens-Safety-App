import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../data/safety_tips_data.dart';
import '../widgets/safety_tip_card.dart';

class SafetyTipsScreen extends StatelessWidget {
  const SafetyTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: AppColors.background,
            floating: true,
            pinned: true,
            elevation: 0,
            title: Text(
              'Safety Tips',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Text(
                '${safetyTipsData.length} essential tips to keep you safe',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 250 + (index * 80)),
                  curve: Curves.easeOut,
                  builder: (context, value, child) => Transform.translate(
                    offset: Offset(0, 16 * (1 - value)),
                    child: Opacity(
                      opacity: value,
                      child: SafetyTipCard(
                        tip: safetyTipsData[index],
                        index: index,
                      ),
                    ),
                  ),
                ),
                childCount: safetyTipsData.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
