import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  // Private constructor to prevent external instantiation
  SharedPreferencesService._privateConstructor();

  // The single instance of the class
  static final SharedPreferencesService _instance = SharedPreferencesService._privateConstructor();

  // Factory constructor that returns the single instance
  factory SharedPreferencesService() {
    return _instance;
  }

  // Private field to hold the SharedPreferences instance
  SharedPreferences? _preferences;

  // Ensure SharedPreferences is initialized
  Future<void> _init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  // Method to save a string value
  Future<void> saveString(String key, String value) async {
    await _init();
    await _preferences?.setString(key, value);
  }

  // Method to retrieve a string value
  Future<String?> getString(String key) async {
    await _init();
    return _preferences?.getString(key);
  }

  // Method to save an integer value
  Future<void> saveInt(String key, int value) async {
    await _init();
    await _preferences?.setInt(key, value);
  }

  // Method to retrieve an integer value
  Future<int?> getInt(String key) async {
    await _init();
    return _preferences?.getInt(key);
  }

  // Method to save a boolean value
  Future<void> saveBool(String key, bool value) async {
    await _init();
    await _preferences?.setBool(key, value);
  }

  // Method to retrieve a boolean value
  Future<bool?> getBool(String key) async {
    await _init();
    return _preferences?.getBool(key);
  }

  // Method to clear a specific key
  Future<void> remove(String key) async {
    await _init();
    await _preferences?.remove(key);
  }

  // Method to clear all data
  Future<void> clear() async {
    await _init();
    await _preferences?.clear();
  }
}
