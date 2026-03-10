import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  String _reportType = 'Bug';
  final _descriptionController = TextEditingController();

  static const List<Map<String, dynamic>> _reportTypes = [
    {'label': 'Bug Report', 'value': 'Bug', 'icon': Icons.bug_report_outlined},
    {'label': 'Feature Request', 'value': 'Feature Request', 'icon': Icons.lightbulb_outline_rounded},
    {'label': 'Feedback', 'value': 'Feedback', 'icon': Icons.rate_review_outlined},
    {'label': 'Other', 'value': 'Other', 'icon': Icons.help_outline_rounded},
  ];

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
            title: Text('Report & Feedback',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            sliver: SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('What would you like to report?',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _reportTypes.map((type) {
                        final isSelected = _reportType == type['value'];
                        return GestureDetector(
                          onTap: () => setState(() => _reportType = type['value']),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : AppColors.surface,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.shade200),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(type['icon'] as IconData, size: 16,
                                    color: isSelected ? Colors.white : AppColors.textSecondary),
                                const SizedBox(width: 6),
                                Text(type['label'] as String,
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500,
                                        color: isSelected ? Colors.white : AppColors.textSecondary)),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 28),
                    const Text('Description',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 7,
                      decoration: const InputDecoration(
                          hintText: 'Describe your issue or suggestion...',
                          alignLabelWithHint: true),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                              ? 'Please enter a description'
                              : null,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _submitReport,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        child: const Text('Submit Report',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitReport() async {
    if (_formKey.currentState!.validate()) {
      final subject =
          Uri.encodeComponent('[SafeAura] $_reportType Report');
      final body = Uri.encodeComponent(
        'Report Type: $_reportType\n\n${_descriptionController.text.trim()}\n\n-- Sent via SafeAura App',
      );
      final mailUri = Uri.parse(
          'mailto:tnmybngrwork@gmail.com?subject=$subject&body=$body');
      try {
        await launchUrl(mailUri);
      } catch (_) {}

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Report submitted — thank you!'),
              backgroundColor: AppColors.success),
        );
        _descriptionController.clear();
        setState(() => _reportType = 'Bug');
      }
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
