# カラーカスタマイズ機能

## 概要
この機能により、ユーザーはメトロノームアプリ全体で使用されるプライマリブルーカラーをカスタマイズできます。ユーザーは設定画面のカラーピッカーから任意の色を選択でき、その選択はハードコードされたブルーカラーを使用していたすべてのUI要素に適用されます。

## 実装詳細

### 追加された新ファイル
- `lib/property/color_settings.dart` - SharedPreferencesを使用したカラー状態と永続化の管理

### 変更されたファイル
- `pubspec.yaml` - 依存関係を追加：`shared_preferences: ^2.0.15`および`flutter_colorpicker: ^1.0.3`
- `lib/main.dart` - ColorSettingsプロバイダーを追加し、テーマを動的にした
- `lib/home/bpm/settings.dart` - カラーピッカーUIを追加
- `lib/home/rhythm/pendulum.dart` - ハードコードされたブルーの代わりに動的カラーを使用
- `lib/home/rhythm/beat.dart` - ビートインジケーターに動的カラーを使用
- `lib/property/home_property.dart` - ボタンアイコンに動的カラーを使用
- `lib/home/footer/footer.dart` - フッターボタンに動的カラーを使用

### 機能
1. **カラーピッカー**: 直感的なUIで設定画面に追加
2. **永続ストレージ**: SharedPreferencesを使用してユーザーのカラー選択を保存
3. **動的テーマ**: カラー変更時にアプリテーマが自動的に更新
4. **リアルタイム更新**: カラー変更がアプリ全体に即座に反映

### 使用方法
1. 設定アイコンをタップして設定画面を開く
2. 設定リストの上部にある「カラーテーマ」オプションをタップ
3. カラーピッカーダイアログを使用してお好みの色を選択
4. カラーがすべてのブルーUI要素に即座に適用される
5. アプリを再起動してもカラー選択が保持される

### 技術実装
- 状態管理にProviderパターンを使用
- ColorSettingsクラスがChangeNotifierを継承
- 永続ストレージにSharedPreferences
- テーマ互換性のためのMaterialColorスウォッチ生成
- リアクティブUI更新のためのConsumer/Providerウィジェット

### メリット
- ユーザーカスタマイズの向上
- ユーザー体験の改善
- アプリの一貫性を維持
- Flutterのベストプラクティスに従う
- パフォーマンスへの影響が最小限