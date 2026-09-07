import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const List<Map<String, dynamic>> _history = [
    {'disease': 'Bud Rot', 'date': 'April 25, 2026', 'confidence': '94%',
      'color': Color(0xFFEF5350), 'icon': Icons.dangerous_outlined},
    {'disease': 'Leaf Spot', 'date': 'April 23, 2026', 'confidence': '88%',
      'color': Color(0xFFFFCA28), 'icon': Icons.circle_outlined},
    {'disease': 'Healthy', 'date': 'April 21, 2026', 'confidence': '97%',
      'color': Color(0xFF43A047), 'icon': Icons.check_circle_outline},
    {'disease': 'Nutrient Deficiency', 'date': 'April 18, 2026',
      'confidence': '76%', 'color': Color(0xFF42A5F5),
      'icon': Icons.science_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Color(0xFF1B5E20)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Scan History',
            style: TextStyle(
                color: Color(0xFF1B5E20),
                fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text('Clear',
                  style: TextStyle(color: Color(0xFFEF5350)))),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _history.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final item = _history[i];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Row(children: [
              Container(
                width: 46, height: 46,
                decoration: BoxDecoration(
                  color: (item['color'] as Color).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(item['icon'] as IconData,
                    color: item['color'] as Color, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['disease'] as String,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xFF37474F))),
                    const SizedBox(height: 2),
                    Text(item['date'] as String,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (item['color'] as Color).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(item['confidence'] as String,
                    style: TextStyle(
                        color: item['color'] as Color,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
              ),
            ]),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ABOUT SCREEN
// ─────────────────────────────────────────────
