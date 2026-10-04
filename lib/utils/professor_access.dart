import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class ProfessorAccessManager {
  static const String _currentProfessorCodeKey = 'current_professor_code';
  static const String _currentProfessorLinkKey = 'current_professor_link';
  static const String _currentProfessorNameKey = 'current_professor_name';
  static const String _validProfessorCodesKey = 'valid_professor_codes';
  static const String _currentRoleKey = 'lamcode_current_role';
  static const String _currentStudentNameKey = 'lamcode_student_name';
  static const String _currentStudentCodeKey = 'lamcode_student_code';

  static String normalizeCode(String? value) {
    final raw = (value ?? '').trim();
    if (raw.isEmpty) {
      return '';
    }

    String candidate = raw;
    final maybeUri = Uri.tryParse(raw);
    if (maybeUri != null && maybeUri.queryParameters.containsKey('code')) {
      candidate = maybeUri.queryParameters['code'] ?? candidate;
    }

    final upper = candidate.trim().toUpperCase();
    return upper.startsWith('PROF-') ? upper : 'PROF-$upper';
  }

  static String buildShareLink(String code) {
    final normalizedCode = normalizeCode(code);
    if (normalizedCode.isEmpty) {
      return 'https://lamcode.app/join';
    }
    return 'https://lamcode.app/join?code=$normalizedCode';
  }

  static String generateCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final random = Random();
    final value = List.generate(6, (_) => chars[random.nextInt(chars.length)]).join();
    return normalizeCode('PROF-$value');
  }

  static Future<Map<String, String>> registerProfessor({
    required String name,
    String email = '',
  }) async {
    final cleanedName = name.trim();
    if (cleanedName.isEmpty) {
      throw ArgumentError('Professor name is required.');
    }

    final prefs = await SharedPreferences.getInstance();
    final code = generateCode();
    final link = buildShareLink(code);

    final existingCodes = prefs.getStringList(_validProfessorCodesKey) ?? <String>[];
    final normalizedCodes = existingCodes
        .map(normalizeCode)
        .where((value) => value.isNotEmpty)
        .toSet();
    normalizedCodes.add(code);

    await prefs.setString(_currentProfessorCodeKey, code);
    await prefs.setString(_currentProfessorLinkKey, link);
    await prefs.setString(_currentProfessorNameKey, cleanedName);
    await prefs.setString('current_professor_email', email.trim());
    await prefs.setStringList(_validProfessorCodesKey, normalizedCodes.toList()..sort());
    await prefs.setString(_currentRoleKey, 'professor');

    return {
      'code': code,
      'link': link,
      'name': cleanedName,
    };
  }

  static Future<bool> registerStudent({
    required String name,
    required String code,
  }) async {
    final cleanedName = name.trim();
    final normalizedCode = normalizeCode(code);

    if (cleanedName.isEmpty || normalizedCode.isEmpty) {
      return false;
    }

    if (!await isValidProfessorCode(normalizedCode)) {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentRoleKey, 'student');
    await prefs.setString(_currentStudentNameKey, cleanedName);
    await prefs.setString(_currentStudentCodeKey, normalizedCode);
    return true;
  }

  static Future<Map<String, String>> getCurrentProfessor() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'code': prefs.getString(_currentProfessorCodeKey) ?? '',
      'link': prefs.getString(_currentProfessorLinkKey) ?? '',
      'name': prefs.getString(_currentProfessorNameKey) ?? '',
    };
  }

  static Future<Map<String, String>> getCurrentStudent() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(_currentStudentNameKey) ?? '',
      'code': prefs.getString(_currentStudentCodeKey) ?? '',
      'role': prefs.getString(_currentRoleKey) ?? '',
    };
  }

  static Future<bool> isValidProfessorCode(String? code) async {
    final normalized = normalizeCode(code);
    if (normalized.isEmpty) {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();
    final validCodes = prefs.getStringList(_validProfessorCodesKey) ?? <String>[];
    final normalizedValidCodes = validCodes
        .map(normalizeCode)
        .where((value) => value.isNotEmpty)
        .toSet();

    return normalizedValidCodes.contains(normalized);
  }

  static Future<void> clearProfessorProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentProfessorCodeKey);
    await prefs.remove(_currentProfessorLinkKey);
    await prefs.remove(_currentProfessorNameKey);
    await prefs.remove('current_professor_email');
    await prefs.remove(_validProfessorCodesKey);
  }

  static Future<void> clearStudentProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentStudentNameKey);
    await prefs.remove(_currentStudentCodeKey);
    await prefs.remove(_currentRoleKey);
  }

  static Future<void> clearAuthState() async {
    await clearProfessorProfile();
    await clearStudentProfile();
  }
}
