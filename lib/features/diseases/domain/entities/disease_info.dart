import 'package:flutter/material.dart';

class DiseaseInfo {
  final String name;
  final IconData icon;
  final Color color;
  final String description;
  final List<String> symptoms;
  final List<String> remedies;
  final List<String> prevention;

  const DiseaseInfo({
    required this.name,
    required this.icon,
    required this.color,
    required this.description,
    required this.symptoms,
    required this.remedies,
    required this.prevention,
  });
}
