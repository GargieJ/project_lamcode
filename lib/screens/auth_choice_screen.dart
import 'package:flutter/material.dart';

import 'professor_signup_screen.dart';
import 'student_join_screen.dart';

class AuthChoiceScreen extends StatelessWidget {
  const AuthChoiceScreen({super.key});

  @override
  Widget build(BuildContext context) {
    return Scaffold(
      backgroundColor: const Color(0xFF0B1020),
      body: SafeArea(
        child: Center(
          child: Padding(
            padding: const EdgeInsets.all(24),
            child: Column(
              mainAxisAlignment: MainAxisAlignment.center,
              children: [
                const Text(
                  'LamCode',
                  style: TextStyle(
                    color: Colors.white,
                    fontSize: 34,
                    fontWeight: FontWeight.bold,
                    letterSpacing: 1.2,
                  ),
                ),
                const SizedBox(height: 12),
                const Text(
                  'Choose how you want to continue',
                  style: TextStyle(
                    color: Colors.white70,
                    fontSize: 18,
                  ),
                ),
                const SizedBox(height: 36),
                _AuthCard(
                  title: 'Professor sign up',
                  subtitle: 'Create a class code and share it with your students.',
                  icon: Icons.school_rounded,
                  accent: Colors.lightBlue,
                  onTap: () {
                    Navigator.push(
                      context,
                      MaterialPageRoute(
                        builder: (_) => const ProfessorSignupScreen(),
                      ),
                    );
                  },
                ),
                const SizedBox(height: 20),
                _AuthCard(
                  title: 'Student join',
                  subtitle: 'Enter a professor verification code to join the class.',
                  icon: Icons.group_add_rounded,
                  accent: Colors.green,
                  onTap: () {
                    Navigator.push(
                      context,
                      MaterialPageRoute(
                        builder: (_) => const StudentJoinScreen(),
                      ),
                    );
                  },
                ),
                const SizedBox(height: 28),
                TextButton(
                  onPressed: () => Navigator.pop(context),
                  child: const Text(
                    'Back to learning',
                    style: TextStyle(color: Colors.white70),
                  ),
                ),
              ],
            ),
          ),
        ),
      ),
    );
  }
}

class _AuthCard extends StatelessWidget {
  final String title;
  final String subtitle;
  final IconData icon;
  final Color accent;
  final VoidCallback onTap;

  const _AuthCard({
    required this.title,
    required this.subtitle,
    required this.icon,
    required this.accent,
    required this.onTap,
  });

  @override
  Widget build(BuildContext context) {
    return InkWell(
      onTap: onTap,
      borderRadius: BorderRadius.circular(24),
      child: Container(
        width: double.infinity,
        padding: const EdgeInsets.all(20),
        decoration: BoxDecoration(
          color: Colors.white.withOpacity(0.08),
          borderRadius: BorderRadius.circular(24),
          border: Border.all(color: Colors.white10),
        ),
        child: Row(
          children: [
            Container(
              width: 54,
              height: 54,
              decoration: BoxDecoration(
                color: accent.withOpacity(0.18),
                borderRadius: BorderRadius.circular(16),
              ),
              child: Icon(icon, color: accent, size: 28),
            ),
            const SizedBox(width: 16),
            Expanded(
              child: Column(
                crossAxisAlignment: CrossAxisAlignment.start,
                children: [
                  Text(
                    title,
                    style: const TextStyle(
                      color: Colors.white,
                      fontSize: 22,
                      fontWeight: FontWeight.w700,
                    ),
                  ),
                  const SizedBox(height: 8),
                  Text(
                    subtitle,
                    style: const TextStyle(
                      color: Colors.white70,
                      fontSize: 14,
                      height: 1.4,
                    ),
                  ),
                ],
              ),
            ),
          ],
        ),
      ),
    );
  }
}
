import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class ProfessorAccessManager {
  static const String _currentProfessorCodeKey = 'current_professor_code';
  static const String _currentProfessorLinkKey = 'current_professor_link';
  static const String _currentProfessorNameKey = 'current_professor_name';
  static const String _validProfessorCodesKey = 'valid_professor_codes';

  static String buildShareLink(String code) {
    final normalizedCode = code.trim();
    return 'https://lamcode.app/join?code=$normalizedCode';
  }

  static String generateCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final random = Random();
    final value = List.generate(6, (_) => chars[random.nextInt(chars.length)]).join();
    return 'PROF-$value';
  }

  static Future<String> registerProfessor({
    required String name,
    String email = '',
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final code = generateCode();
    final link = buildShareLink(code);

    final existingCodes = prefs.getStringList(_validProfessorCodesKey) ?? <String>[];
    final updatedCodes = <String>{...existingCodes, code}.toList();

    await prefs.setString(_currentProfessorCodeKey, code);
    await prefs.setString(_currentProfessorLinkKey, link);
    await prefs.setString(_currentProfessorNameKey, name.trim());
    await prefs.setString('current_professor_email', email.trim());
    await prefs.setStringList(_validProfessorCodesKey, updatedCodes);

    return code;
  }

  static Future<Map<String, String>> getCurrentProfessor() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'code': prefs.getString(_currentProfessorCodeKey) ?? '',
      'link': prefs.getString(_currentProfessorLinkKey) ?? '',
      'name': prefs.getString(_currentProfessorNameKey) ?? '',
    };
  }

  static Future<bool> isValidProfessorCode(String? code) async {
    if (code == null || code.trim().isEmpty) {
      return false;
    }

    final trimmed = code.trim();
    final prefs = await SharedPreferences.getInstance();
    final validCodes = prefs.getStringList(_validProfessorCodesKey) ?? <String>[];

    return validCodes.any(
      (item) => item.trim().toUpperCase() == trimmed.toUpperCase(),
    );
  }

  static Future<void> clearProfessorProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentProfessorCodeKey);
    await prefs.remove(_currentProfessorLinkKey);
    await prefs.remove(_currentProfessorNameKey);
    await prefs.remove('current_professor_email');
  }
}
