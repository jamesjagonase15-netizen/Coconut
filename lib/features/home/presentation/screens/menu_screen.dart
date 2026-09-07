import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../diseases/data/disease_catalog.dart';
import '../../../diseases/domain/entities/disease_info.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/localization/app_translations.dart';
import '../widgets/connectivity_badge.dart';
import '../../../../core/services/language_preferences_service.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  @override
  void initState() {
    super.initState();
    // Listen for language changes and rebuild
    LanguagePreferencesService.current.addListener(_onLanguageChange);
  }

  @override
  void dispose() {
    LanguagePreferencesService.current.removeListener(_onLanguageChange);
    super.dispose();
  }

  void _onLanguageChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1B5E20), Color(0xFF388E3C)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.eco,
                            color: Colors.white, size: 26),
                      ),
                      const SizedBox(width: 12),
                      const Text('CocoScan',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5)),
                      const Spacer(),
                      const ConnectivityBadge(),
                      IconButton(
                        tooltip: 'Settings',
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRoutes.settings),
                        icon: const Icon(Icons.settings_outlined,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(context.tr('coconut_disease_identification'),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          height: 1.2)),
                  const SizedBox(height: 8),
                  Text(context.tr('offline_detection'),
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 14)),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Scan card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4))
                        ],
                      ),
                      child: Column(children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                              color: Color(0xFFE8F5E9),
                              shape: BoxShape.circle),
                          child: const Icon(Icons.camera_alt,
                              color: Color(0xFF2E7D32), size: 38),
                        ),
                        const SizedBox(height: 16),
                        Text(context.tr('scan_a_coconut'),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B5E20))),
                        const SizedBox(height: 6),
                        Text(
                          context.tr('scan_instruction'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              height: 1.4),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                Navigator.pushNamed(context, AppRoutes.camera),
                            icon: const Icon(Icons.camera_alt),
                            label: Text(context.tr('open_camera')),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E7D32),
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ]),
                    ),

                    const SizedBox(height: 20),

                    // Disease section header
                    Row(
                      children: [
                        Text(context.tr('detectable_diseases'),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B5E20))),
                        const Spacer(),
                        Text(context.tr('tap_to_learn'),
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[500])),
                        const SizedBox(width: 4),
                        Icon(Icons.touch_app,
                            size: 14, color: Colors.grey[500]),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Disease grid — tappable
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.88,
                      ),
                      itemCount: diseases.length,
                      itemBuilder: (_, i) => _DiseaseCard(disease: diseases[i]),
                    ),

                    const SizedBox(height: 20),

                    // Quick links
                    Row(children: [
                      Expanded(
                        child: _QuickLinkCard(
                          icon: Icons.history,
                          label: context.tr('history'),
                          color: const Color(0xFF0288D1),
                          onTap: () =>
                              Navigator.pushNamed(context, AppRoutes.history),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _QuickLinkCard(
                          icon: Icons.info_outline,
                          label: context.tr('about'),
                          color: const Color(0xFF6A1B9A),
                          onTap: () => Navigator.pushNamed(context, AppRoutes.about),
                        ),
                      ),
                    ]),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border:
                            Border.all(color: const Color(0xFFE8F5E9)),
                      ),
                      child: Row(children: [
                        const Icon(Icons.memory,
                            color: Color(0xFF388E3C), size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                              context.tr('model_info'),
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF424242))),
                        ),
                        const Icon(Icons.check_circle,
                            color: Color(0xFF43A047), size: 18),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TAPPABLE DISEASE CARD
// ─────────────────────────────────────────────
class _DiseaseCard extends StatelessWidget {
  final DiseaseInfo disease;
  const _DiseaseCard({required this.disease});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDiseaseDetail(context, disease),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: disease.color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(disease.icon, color: disease.color, size: 22),
            ),
            const SizedBox(height: 8),
            Text(disease.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF37474F),
                    height: 1.3)),
            const SizedBox(height: 4),
            Icon(Icons.arrow_forward_ios,
                size: 9, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DISEASE DETAIL BOTTOM SHEET
// ─────────────────────────────────────────────
void _showDiseaseDetail(BuildContext context, DiseaseInfo disease) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => DiseaseDetailSheet(disease: disease),
  );
}

class DiseaseDetailSheet extends StatelessWidget {
  final DiseaseInfo disease;
  const DiseaseDetailSheet({super.key, required this.disease});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    disease.color.withValues(alpha: 0.15),
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: disease.color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(disease.icon,
                      color: disease.color, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(disease.name,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B5E20))),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: disease.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(context.tr('coconut_disease'),
                            style: TextStyle(
                                fontSize: 11,
                                color: disease.color,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ]),
            ),

            // Scrollable content
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                children: [
                  // Description
                  _SectionTitle(title: context.tr('about_disease'), icon: Icons.info_outline,
                      color: disease.color),
                  const SizedBox(height: 8),
                  Text(disease.description,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF546E7A),
                          height: 1.6)),

                  const SizedBox(height: 20),

                  // Symptoms
                  _SectionTitle(
                      title: context.tr('symptoms'),
                      icon: Icons.medical_information_outlined,
                      color: disease.color),
                  const SizedBox(height: 8),
                  ...disease.symptoms.map((s) => _BulletItem(
                      text: s, color: disease.color)),

                  const SizedBox(height: 20),

                  // Remedies
                  _SectionTitle(
                      title: context.tr('remedy'),
                      icon: Icons.healing_outlined,
                      color: disease.color),
                  const SizedBox(height: 8),
                  ...disease.remedies.asMap().entries.map((e) =>
                      _NumberedItem(
                          number: e.key + 1,
                          text: e.value,
                          color: disease.color)),

                  const SizedBox(height: 20),

                  // Prevention
                  _SectionTitle(
                      title: context.tr('prevention'),
                      icon: Icons.shield_outlined,
                      color: disease.color),
                  const SizedBox(height: 8),
                  ...disease.prevention.map((p) =>
                      _BulletItem(text: p, color: disease.color)),

                  const SizedBox(height: 24),

                  // Scan button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.camera);
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: Text(context.tr('scan_for_disease')),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: disease.color,
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  const _SectionTitle(
      {required this.title, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 18, color: color),
      const SizedBox(width: 6),
      Text(title,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color)),
    ]);
  }
}

class _BulletItem extends StatelessWidget {
  final String text;
  final Color color;
  const _BulletItem({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
                color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF546E7A),
                    height: 1.5)),
          ),
        ],
      ),
    );
  }
}

class _NumberedItem extends StatelessWidget {
  final int number;
  final String text;
  final Color color;
  const _NumberedItem(
      {required this.number, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('$number',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: color)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF546E7A),
                    height: 1.5)),
          ),
        ],
      ),
    );
  }
}

class _QuickLinkCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _QuickLinkCard(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(label,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 13)),
        ]),
      ),
    );
  }
}

