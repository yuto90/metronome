// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String hello(Object name) {
    return 'ようこそ $name';
  }

  @override
  String get option_color_theme => 'カラーテーマ';

  @override
  String get option_color_theme_subtitle => 'タップしてアプリの色を変更';

  @override
  String get color_picker_title => '色を選択';

  @override
  String get color_picker_close => '閉じる';

  @override
  String get option_beat => '拍子を非表示にする';

  @override
  String get option_pendulum => '振り子を非表示にする';

  @override
  String get option_change_beat => '最後の拍子で音を変える';

  @override
  String get option_just_vibration => 'ジャストタイミングでタップした時にバイブを鳴らす';
}
