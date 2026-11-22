import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// Kotak pesan error umum di atas tombol form.
class ErrorBanner extends StatelessWidget {
  const ErrorBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: warnaMerah.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: warnaMerah.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: warnaMerah),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message, style: const TextStyle(color: warnaPutih)),
          ),
        ],
      ),
    );
  }
}
