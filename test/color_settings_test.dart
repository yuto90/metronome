import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metronome/property/color_settings.dart';

void main() {
  group('ColorSettings Tests', () {
    test('ColorSettings should initialize with default blue color', () {
      final colorSettings = ColorSettings();
      expect(colorSettings.primaryColor, equals(Colors.blue));
    });

    test('ColorSettings should update primary color', () async {
      final colorSettings = ColorSettings();
      const newColor = Colors.red;
      
      await colorSettings.setPrimaryColor(newColor);
      expect(colorSettings.primaryColor, equals(newColor));
    });

    test('ColorSettings should generate correct MaterialColor swatch', () {
      final colorSettings = ColorSettings();
      colorSettings.setPrimaryColor(Colors.red);
      
      final swatch = colorSettings.primarySwatch;
      expect(swatch[500], equals(Colors.red.withOpacity(0.6)));
      expect(swatch[900], equals(Colors.red.withOpacity(1.0)));
    });
  });
}