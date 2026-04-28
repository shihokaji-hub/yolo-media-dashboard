# GitHub Pages 公開セットアップ手順

ブラウザ操作だけで完結。約20分。

## ⚠️ 事前確認

このダッシュボードには **下書き記事のタイトル・URL** も含まれます。

セキュリティ対策の選択肢:

1. **パスワード保護（推奨・無料）**: ページ表示時にパスワード入力を求める
   - URLを知っていてもパスワードがないと見られない
   - 設定方法は Step 3 を参照
2. **公開URL（誰でも見られる）**: パスワード保護なし
   - URLを共有した相手だけ見られる前提
   - 下書きが漏れる可能性あり

このガイドでは **パスワード保護** を前提に進めます。

---

## Step 1: GitHub リポジトリ作成（3分）

### 1-1. GitHub にログイン

[https://github.com](https://github.com)

### 1-2. 新規リポジトリ作成

右上の **+** → **New repository**

| 項目 | 値 |
|---|---|
| Repository name | `yolo-media-dashboard`（任意） |
| Description | YOLO MEDIA 記事管理ダッシュボード |
| Public/Private | **Public**（無料でPagesが使える） |
| Initialize with | チェックなし（空のまま） |

→ **Create repository**

---

## Step 2: ファイルをアップロード（5分）

### 2-1. 「uploading an existing file」をクリック

新規リポジトリのトップページに表示される **「uploading an existing file」** リンクをクリック

### 2-2. ファイルをドラッグ&ドロップ

Finder で `/Users/kaji0102/Documents/Antigravity/contents/dashboard-deploy/` を開く

→ 中身（`.github/`、`docs/`、`scripts/`、`package.json`、`.gitignore`、`README.md`、`SETUP.md` 全部）を**選択してドラッグ&ドロップ**

> ⚠️ Finder で隠しファイル（`.gitignore`）を見るには `Cmd + Shift + .` を押す

### 2-3. コミット

- Commit message: `初回セットアップ`
- **Commit changes** をクリック

---

## Step 3: シークレット登録（5分）

### 3-1. リポジトリの Settings へ

リポジトリページ上部 **Settings** タブ → 左サイドバー **Secrets and variables** → **Actions**

### 3-2. シークレット追加

**「New repository secret」** ボタンを4回クリックして以下を登録:

| Name | Secret（値はローカルの .env から取得） |
|---|---|
| `WP_URL` | WordPress サイトのURL（例: `https://example.com`） |
| `WP_USER` | WordPress ユーザー名 |
| `WP_APP_PASSWORD` | WordPress アプリパスワード |
| `DASHBOARD_PASSWORD` | チームに共有するパスワード（任意） |

各登録後 **「Add secret」** で保存

> 💡 `DASHBOARD_PASSWORD` を設定するとダッシュボード閲覧時にパスワード入力が必要になります。
> 設定しなければパスワード保護なし（誰でもURLで見られる）。

---

## Step 4: GitHub Pages 有効化（2分）

### 4-1. Settings → Pages

左サイドバー **Pages**

### 4-2. ソース指定

**Build and deployment** セクション:

- **Source**: `Deploy from a branch`
- **Branch**: `main`
- **Folder**: `/docs`
- **Save**

数分待つと、ページ上部に公開URLが表示されます:

```
https://<your-username>.github.io/yolo-media-dashboard/
```

---

## Step 5: 初回実行（5分）

### 5-1. Actions タブを開く

リポジトリ上部 **Actions** タブ

### 5-2. ワークフロー手動実行

左側 **Update Dashboard** をクリック → 右側 **Run workflow** ボタン → **Run workflow** を確定

→ 1〜2分で完了

### 5-3. 完了確認

✅ 緑チェックがついたら成功

→ Step 4 で表示された GitHub Pages の URL にアクセス
→ パスワード入力画面が出る → Step 3 で設定した `DASHBOARD_PASSWORD` を入力
→ ダッシュボード表示OK

### 5-4. メンバーへの共有

メンバーには以下を伝える:

```
URL: https://<your-username>.github.io/yolo-media-dashboard/
パスワード: <DASHBOARD_PASSWORDの値>
```

「次回からパスワード入力を省略する」チェックボックスをONにすると、ブラウザに記憶されます。

---

## 自動更新

設定不要。**毎朝8時(JST)** に自動で:
1. WP から最新記事取得
2. ダッシュボード再生成
3. リポジトリにコミット
4. GitHub Pages が自動デプロイ

メンバーには Step 4 の URL を共有してください。

---

## トラブル対応

### Actions が失敗する
- Actions タブで失敗したジョブをクリック → ログ確認
- よくある原因: シークレットの値間違い、改行が混ざってる

### Pages が表示されない
- 初回デプロイは10分かかることあり
- Settings → Pages で URL が表示されているか確認

### 手動更新したい
- Actions タブ → Update Dashboard → Run workflow
