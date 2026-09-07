import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
        title: const Text('About',
            style: TextStyle(
                color: Color(0xFF1B5E20),
                fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(
            width: 90, height: 90,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF66BB6A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.eco, color: Colors.white, size: 48),
          ),
          const SizedBox(height: 14),
          const Text('CocoScan',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20))),
          const Text('Version 1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 24),
          const _AboutCard(
              title: 'What is CocoScan?',
              content:
                  'CocoScan is an offline Android application that uses YOLOv8 + TFLite to identify coconut diseases directly on your device — no internet required.'),
          const SizedBox(height: 14),
          const _AboutCard(
              title: 'Detectable Conditions',
              content:
                  'Bud Rot, Crown Rot, Gray Leaf Blight, Leaf Spot, Lethal Yellowing, Nutrient Deficiency, and Healthy.'),
          const SizedBox(height: 14),
          const _AboutCard(
              title: 'Model Information',
              content:
                  'Architecture: YOLOv8\nDeployment: TensorFlow Lite (Quantized)\nDataset: Mendeley Coconut Disease Dataset\nAccuracy: ≥90% mAP on test set'),
          const SizedBox(height: 14),
          const _AboutCard(
              title: 'Research Team',
              content:
                  'Angelo Carl Ibañez\nJames Jagonase\nBrandon Julz Salomia\n\nUniversity of Mindanao\nCollege of Engineering Education\nDavao City, Philippines'),
        ]),
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  final String title;
  final String content;
  const _AboutCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF1B5E20))),
        const SizedBox(height: 8),
        Text(content,
            style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF546E7A),
                height: 1.6)),
      ]),
    );
  }
}

// ─────────────────────────────────────────────
// CONNECTIVITY BADGE
