# Color Customization Feature

## Overview
This feature allows users to customize the primary blue color used throughout the metronome app. Users can select any color from a color picker in the settings screen, and their choice will be applied to all UI elements that previously used the hardcoded blue color.

## Implementation Details

### New Files Added
- `lib/property/color_settings.dart` - Manages color state and persistence using SharedPreferences

### Modified Files
- `pubspec.yaml` - Added dependencies: `shared_preferences: ^2.0.15` and `flutter_colorpicker: ^1.0.3`
- `lib/main.dart` - Added ColorSettings provider and made theme dynamic
- `lib/home/bpm/settings.dart` - Added color picker UI
- `lib/home/rhythm/pendulum.dart` - Uses dynamic color instead of hardcoded blue
- `lib/home/rhythm/beat.dart` - Uses dynamic color for beat indicators
- `lib/property/home_property.dart` - Uses dynamic color for button icons
- `lib/home/footer/footer.dart` - Uses dynamic color for footer buttons

### Features
1. **Color Picker**: Added to the settings screen with an intuitive UI
2. **Persistent Storage**: User's color choice is saved using SharedPreferences
3. **Dynamic Theme**: App theme updates automatically when color changes
4. **Real-time Updates**: Color changes are immediately reflected throughout the app

### Usage
1. Open the settings screen by tapping the settings icon
2. Tap on the "Color Theme" option at the top of the settings list
3. Select your preferred color using the color picker dialog
4. The color will be immediately applied to all blue UI elements
5. Your color choice will be preserved when you restart the app

### Technical Implementation
- Uses Provider pattern for state management
- ColorSettings class extends ChangeNotifier
- SharedPreferences for persistent storage
- MaterialColor swatch generation for theme compatibility
- Consumer/Provider widgets for reactive UI updates

### Benefits
- Enhanced user customization
- Improved user experience
- Maintains app consistency
- Follows Flutter best practices
- Minimal performance impact