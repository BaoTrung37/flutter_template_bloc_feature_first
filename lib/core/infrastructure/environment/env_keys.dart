import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvKeys {
  static String get baseUrl => dotenv.get('BASE_URL');
}
