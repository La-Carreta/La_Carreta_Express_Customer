import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment{
  static String apiKey = dotenv.env['NODE_API_KEY'] ?? "No hay api key";
  static String urlSupabase = dotenv.env['SUPABASE_URL'] ?? "No hay url del proyecto de supabase";
  static String anonPublicKey = dotenv.env['ANON_PUBLIC_KEY'] ?? "No hay la clave publica.";
}