import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class TombolUtama extends StatelessWidget {
  const TombolUtama({
    super.key,
    required this.teks,
    required this.onPressed,
    this.isLoading = false,
  });

  final String teks;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: warnaEmas,
          foregroundColor: Colors.black,
          disabledBackgroundColor: warnaEmas.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.black,
                ),
              )
            : Text(
                teks,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
      ),
    );
  }
}
