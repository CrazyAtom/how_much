import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get geminiApiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
  }

  static Future<void> initializeForEnvironment(String env) async {
    await dotenv.load(fileName: '.env.$env');
  }
}