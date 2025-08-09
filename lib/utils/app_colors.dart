import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors from Figma design
  static const Color primary = Color(0xFF4AB786);
  static const Color secondary = Color(0xFFEA7173);
  static const Color accent = Color(0xFFFFDAA5);
  static const Color white = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;

  // Category Colors
  static const Color groceries = Color(0xFF4AB786);
  static const Color electronics = Color(0xFF6B73FF);
  static const Color fashion = Color(0xFFFF6B6B);
  static const Color mobiles = Color(0xFFFFB800);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF4AB786),
    Color(0xFF4AB786),
  ];

  static const List<Color> secondaryGradient = [
    Color(0xFFEA7173),
    Color(0xFFFFDAA5),
  ];
}