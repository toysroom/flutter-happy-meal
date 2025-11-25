import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });

  factory Category.fromJson(dynamic json) {
    return Category(
      id: json["id"] as String,
      title: json["title"] as String,
      color: _colorFromHex(
        json["color"] as String?,
      ),
    );
  }

  static Color _colorFromHex(String? colorString) {
    if (colorString == null || colorString.isEmpty) {
      return Colors.orange;
    }
    final normalized = colorString.replaceFirst('#', '');
    final buffer = StringBuffer();
    if (normalized.length == 6) {
      buffer.write('FF');
    }
    buffer.write(normalized);
    final value = int.tryParse(buffer.toString(), radix: 16);
    if (value == null) {
      return Colors.orange;
    }
    return Color(value);
  }
}
