// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String hello(Object name) {
    return 'Hello $name';
  }

  @override
  String get option_beat => 'Hide the beat';

  @override
  String get option_pendulum => 'Hide the pendulum';

  @override
  String get option_change_beat => 'Change the sound with the last beat';

  @override
  String get option_just_vibration => 'Sounds a vibe when just tapped';

  @override
  String get option_color_theme => 'Color Theme';

  @override
  String get option_color_theme_subtitle => 'Tap to change app color';

  @override
  String get color_picker_title => 'Select Color';

  @override
  String get color_picker_close => 'Close';
}
