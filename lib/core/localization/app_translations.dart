import 'package:flutter/widgets.dart';

import 'app_language.dart';
import '../services/language_preferences_service.dart';

abstract final class AppTranslations {
  static const _strings = <String, Map<String, String>>{
    'en': {
      'settings': 'Settings',
      'language': 'Language',
      'language_saved': 'Language saved',
      'language_help': 'Your choice is saved on this device.',
      'coconut_disease_identification': 'Coconut Disease\nIdentification',
      'offline_detection': 'AI-powered detection — no internet required',
      'scan_a_coconut': 'Scan a Coconut',
      'scan_instruction': 'Take a photo of leaves, buds, or crown\nto identify diseases instantly.',
      'open_camera': 'Open Camera',
      'detectable_diseases': 'Detectable Diseases',
      'tap_to_learn': 'Tap to learn more',
      'history': 'History',
      'about': 'About',
      'camera': 'Camera',
      'camera_instruction': 'Point at coconut leaves, bud, crown, or stem',
      'photo_captured': 'Photo Captured',
      'image_saved': 'Image saved to device',
      'retake': 'Retake',
      'use_photo': 'Use Photo',
      'scan_history': 'Scan History',
      'clear': 'Clear',
      'model_info': 'YOLOv8 · TFLite · Quantized Model',
      'coconut_disease': 'Coconut Disease',
      'about_disease': 'About',
      'symptoms': 'Symptoms',
      'remedy': 'Remedy',
      'prevention': 'Prevention',
      'scan_for_disease': 'Scan for this Disease',
    },
    'tl': {
      'settings': 'Mga Setting',
      'language': 'Wika',
      'language_saved': 'Nai-save ang wika',
      'language_help': 'Nai-save ang iyong pinili sa device na ito.',
      'coconut_disease_identification': 'Pagkilala sa Sakit\nng Niyog',
      'offline_detection': 'AI na pagkilala — walang internet na kailangan',
      'scan_a_coconut': 'I-scan ang Niyog',
      'scan_instruction': 'Kunan ng larawan ang dahon, usbong, o korona\nupang agad makilala ang sakit.',
      'open_camera': 'Buksan ang Kamera',
      'detectable_diseases': 'Mga Natutukoy na Sakit',
      'tap_to_learn': 'I-tap para malaman',
      'history': 'Kasaysayan',
      'about': 'Tungkol sa App',
      'camera': 'Kamera',
      'camera_instruction': 'Itutok sa dahon, usbong, korona, o puno ng niyog',
      'photo_captured': 'Nakuhang Larawan',
      'image_saved': 'Nai-save ang larawan sa device',
      'retake': 'Kunan Muli',
      'use_photo': 'Gamitin ang Larawan',
      'scan_history': 'Kasaysayan ng Pag-scan',
      'clear': 'Burahin',
      'model_info': 'YOLOv8 · TFLite · Quantized Model',
      'coconut_disease': 'Sakit ng Niyog',
      'about_disease': 'Tungkol',
      'symptoms': 'Mga Sintomas',
      'remedy': 'Lunas',
      'prevention': 'Pag-iwas',
      'scan_for_disease': 'I-scan para sa Sakit na Ito',
    },
    'ceb': {
      'settings': 'Mga Setting',
      'language': 'Pinulongan',
      'language_saved': 'Nasave na ang pinulongan',
      'language_help': 'Nasave ang imong gipili niining device.',
      'coconut_disease_identification': 'Pag-ila sa Sakit\nsa Lubì',
      'offline_detection': 'AI nga pag-ila — walay kinahanglan nga internet',
      'scan_a_coconut': 'I-scan ang Lubì',
      'scan_instruction': 'Kuhai og hulagway ang dahon, tumoy, o korona\narong maila dayon ang sakit.',
      'open_camera': 'Ablihi ang Kamera',
      'detectable_diseases': 'Mga Sakit nga Mailhan',
      'tap_to_learn': 'Pislita aron mahibal-an',
      'history': 'Kasaysayan',
      'about': 'Mahitungod sa App',
      'camera': 'Kamera',
      'camera_instruction': 'Itutok sa dahon, tumoy, korona, o puno sa lubì',
      'photo_captured': 'Nakuhang Hulagway',
      'image_saved': 'Nasave ang hulagway sa device',
      'retake': 'Kuhai Pag-usab',
      'use_photo': 'Gamita ang Hulagway',
      'scan_history': 'Kasaysayan sa Pag-scan',
      'clear': 'Hawanon',
      'model_info': 'YOLOv8 · TFLite · Quantized Model',
      'coconut_disease': 'Sakit sa Lubì',
      'about_disease': 'Mahitungod',
      'symptoms': 'Mga Simtoma',
      'remedy': 'Tambal',
      'prevention': 'Paglikay',
      'scan_for_disease': 'I-scan para sa Sakit nga Ini',
    },
  };

  static String text(AppLanguage language, String key) {
    return _strings[language.code]?[key] ?? _strings['en']![key] ?? key;
  }
}

extension AppTranslationContext on BuildContext {
  String tr(String key) {
    return AppTranslations.text(LanguagePreferencesService.current.value, key);
  }
}
