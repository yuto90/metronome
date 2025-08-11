# TestFlight自動化セットアップガイド

このガイドでは、プルリクエスト向けのTestFlight自動配布システムのセットアップ方法を説明します。

## 概要

プルリクエストが作成または更新されると、GitHub Actionsが自動的に以下を実行します：
1. FlutterでiOSアプリをビルド
2. アプリのアーカイブとコード署名
3. TestFlightへのアップロード
4. ビルドステータスのPRコメント投稿

## 必要なGitHubシークレット

GitHubリポジトリ設定で以下のシークレットを設定する必要があります：

### Apple Developer証明書

1. **APPLE_CERTIFICATE_BASE64**
   - キーチェーンアクセスからiOS配布証明書（.p12）をエクスポート
   - base64に変換：`base64 -i certificate.p12 | pbcopy`
   - base64文字列をシークレット値として貼り付け

2. **APPLE_CERTIFICATE_PASSWORD**
   - .p12証明書をエクスポートする際に使用したパスワード

3. **APPLE_PROVISIONING_PROFILE_BASE64**
   - Apple Developer PortalからApp Storeプロビジョニングプロファイルをダウンロード
   - base64に変換：`base64 -i profile.mobileprovision | pbcopy`
   - base64文字列をシークレット値として貼り付け

### App Store Connect API

4. **APP_STORE_CONNECT_API_KEY_ID**
   - App Store ConnectでAPIキーを作成（ユーザーとアクセス → キー）
   - キーID（例：「2X9R4HXF34」）を使用

5. **APP_STORE_CONNECT_API_ISSUER_ID**
   - App Store Connectで確認（ユーザーとアクセス → キー）
   - 発行者ID（UUID形式）をコピー

6. **APP_STORE_CONNECT_API_KEY_BASE64**
   - App Store Connectから.p8キーファイルをダウンロード
   - base64に変換：`base64 -i AuthKey_XXXXXXXXXX.p8 | pbcopy`
   - base64文字列をシークレット値として貼り付け

## セットアップ手順

### 1. Apple Developerアカウントセットアップ

1. Apple Developer Programの有効なメンバーシップを確保
2. アプリのApp Store Connectレコードが存在しない場合は作成
3. アプリのバンドル識別子を設定：`com.yuto.smooth.metronome`

### 2. 証明書とプロビジョニングプロファイル

1. Apple Developer PortalでiOS配布証明書を作成
2. アプリ用のApp Storeプロビジョニングプロファイルを作成
3. 両方をダウンロードし、上記のようにbase64に変換

### 3. App Store Connect APIキー

1. App Store Connect → ユーザーとアクセス → キーに移動
2. 「+」ボタンをクリックして新しいAPIキーを作成
3. 名前を付ける（例：「CI/CD TestFlight」）
4. 「Developer」ロールを選択
5. .p8ファイルをダウンロードし、キーIDと発行者IDをメモ

### 4. GitHubリポジトリ設定

1. リポジトリ設定 → シークレットと変数 → Actionsに移動
2. 上記のすべての必要なシークレットを追加
3. シークレットがワークフローで利用可能であることを確認

### 5. チーム設定（オプション）

`ios/fastlane/Appfile`をチーム情報で更新：
```ruby
apple_id("your-apple-id@example.com")
itc_team_id("YOUR_APP_STORE_CONNECT_TEAM_ID")
team_id("YOUR_DEVELOPER_PORTAL_TEAM_ID")
```

## セットアップのテスト

1. 小さな変更でテスト用プルリクエストを作成
2. Actionsタブでワークフローが実行されるかを確認
3. ビルドログで問題がないかを監視
4. TestFlightがビルドを受信したことを確認

## トラブルシューティング

### よくある問題

1. **証明書の期限切れ**
   - iOS配布証明書を更新
   - APPLE_CERTIFICATE_BASE64シークレットを更新

2. **プロビジョニングプロファイルが無効**
   - プロファイルに正しい証明書が含まれていることを確認
   - 再生成してAPPLE_PROVISIONING_PROFILE_BASE64を更新

3. **APIキーの問題**
   - APIキーが正しい権限を持っていることを確認
   - キーIDと発行者IDが一致することを確認

4. **ビルドの失敗**
   - Flutterバージョンの互換性を確認
   - すべての依存関係が利用可能であることを確認
   - 具体的なエラーについてワークフローログを確認

### デバッグのヒント

- 詳細なエラーメッセージについてGitHub Actionsログを確認
- すべてのシークレットが適切に設定され、アクセス可能であることを確認
- 最初にXcodeで証明書とプロファイルをローカルでテスト
- ワークフローの失敗コメントを使用して問題を迅速に特定

## セキュリティの考慮事項

- 証明書やAPIキーをリポジトリにコミットしない
- APIキーと証明書を定期的にローテーション
- APIキーの権限を必要最小限に制限
- App Store Connectのアクセスログを監視
- CI用とローカル開発用で異なる証明書の使用を検討

## ワークフローのカスタマイズ

以下を変更してワークフローをカスタマイズできます：
- `.github/workflows/testflight-pr.yml` - メインワークフロー設定
- `ios/fastlane/Fastfile` - ビルドとアップロードのロジック
- `ios/fastlane/Appfile` - アプリとチームの設定

## 追加リソース

- [Fastlaneドキュメント](https://docs.fastlane.tools/)
- [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi)
- [GitHub Actionsドキュメント](https://docs.github.com/en/actions)
- [Flutter CI/CDベストプラクティス](https://docs.flutter.dev/deployment/cd)