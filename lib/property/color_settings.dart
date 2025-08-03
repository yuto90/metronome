import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorSettings extends ChangeNotifier {
  Color _primaryColor = Colors.blue; // Default color
  static const String _colorKey = 'primary_color';

  Color get primaryColor => _primaryColor;

  ColorSettings() {
    _loadColor();
  }

  /// Load the saved color from SharedPreferences
  Future<void> _loadColor() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final colorValue = prefs.getInt(_colorKey);
      if (colorValue != null) {
        _primaryColor = Color(colorValue);
        notifyListeners();
      }
    } catch (e) {
      // If loading fails, keep default color
      print('Failed to load color: $e');
    }
  }

  /// Save the selected color to SharedPreferences and update the state
  Future<void> setPrimaryColor(Color color) async {
    try {
      _primaryColor = color;
      notifyListeners();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_colorKey, color.value);
    } catch (e) {
      print('Failed to save color: $e');
    }
  }

  /// Get a MaterialColor swatch for the theme
  MaterialColor get primarySwatch {
    return MaterialColor(
      _primaryColor.value,
      <int, Color>{
        50: _primaryColor.withOpacity(0.1),
        100: _primaryColor.withOpacity(0.2),
        200: _primaryColor.withOpacity(0.3),
        300: _primaryColor.withOpacity(0.4),
        400: _primaryColor.withOpacity(0.5),
        500: _primaryColor.withOpacity(0.6),
        600: _primaryColor.withOpacity(0.7),
        700: _primaryColor.withOpacity(0.8),
        800: _primaryColor.withOpacity(0.9),
        900: _primaryColor.withOpacity(1.0),
      },
    );
  }
}