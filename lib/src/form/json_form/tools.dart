import 'package:flutter/material.dart';
import 'package:he/src/tools/tools.dart';

TextStyle parseTextStyle(String? styleString, {TextStyle? defaultStyle}) {
  if (styleString == null || styleString.isEmpty) {
    return defaultStyle ?? TextStyle(); // 默认样式
  }

  final styleMap = <String, String>{};

  for (var part in styleString.split(';')) {
    final kv = part.split(':');
    if (kv.length == 2) {
      styleMap[kv[0].trim()] = kv[1].trim();
    }
  }

  final r = TextStyle(
    fontSize: styleMap.containsKey('size')
        ? double.tryParse(styleMap['size']!)
        : null,
    fontWeight: styleMap['bold'] == 'true' ? FontWeight.bold : null,
    color:
        styleMap.containsKey('color') ? parseColor(styleMap['color']!) : null,
  );

  print("r color: ${r.color}  ${styleMap['bold']}");

  return r;
}

Alignment parseAlignment(String? alignmentString) {
  if (alignmentString == null || alignmentString.isEmpty) {
    return Alignment.center;
  }

  switch (alignmentString) {
    case "center":
      return Alignment.center;
    case "left":
      return Alignment.centerLeft;
    case "right":
      return Alignment.centerRight;
    default:
      return Alignment.center;
  }
}
