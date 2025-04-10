import 'package:flutter/material.dart';

Color? parseColor(String hex) {
  // 支持 "#RRGGBB" 或 "#AARRGGBB"
  if (hex.startsWith('#')) {
    hex = hex.substring(1);
  }

  if (hex.length == 6) {
    hex = 'FF$hex'; // 加上不透明 alpha
  }

  if (hex.length != 8) return null;

  return Color(int.parse(hex, radix: 16));
}
