# YOLO MEDIA 記事管理ダッシュボード

WordPress と自動同期する記事管理ダッシュボードです。
毎朝8時(JST)に GitHub Actions で自動更新され、GitHub Pages で公開されます。

## 公開URL

GitHub Pages を有効化後、以下のURLで閲覧できます:

```
https://<github-username>.github.io/<repo-name>/
```

## 必要なシークレット

リポジトリの Settings → Secrets and variables → Actions で以下を登録:

| 名前 | 値 |
|---|---|
| `WP_URL` | `https://media.yolo-japan.com` |
| `WP_USER` | WordPress ユーザー名 |
| `WP_APP_PASSWORD` | WordPress アプリパスワード |

## 手動実行

Actions タブ → "Update Dashboard" ワークフロー → "Run workflow"
