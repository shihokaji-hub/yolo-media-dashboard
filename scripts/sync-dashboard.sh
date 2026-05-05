#!/bin/bash
# YOLO MEDIA Dashboard Sync
# Mac から WP データを取得してダッシュボード生成 → 暗号化 → GitHub に push
# launchd で毎朝8時に自動実行
set -e

DEPLOY_DIR="/Users/kaji0102/Documents/Antigravity/contents/dashboard-deploy"
ENV_FILE="/Users/kaji0102/Documents/Antigravity/contents/.env"

cd "$DEPLOY_DIR"

# .env から WP 認証情報とダッシュボードパスワードを読み込み（スペース込みのパスワードに対応）
export WP_URL=$(grep '^WP_URL=' "$ENV_FILE" | cut -d= -f2-)
export WP_USER=$(grep '^WP_USER=' "$ENV_FILE" | cut -d= -f2-)
export WP_APP_PASSWORD=$(grep '^WP_APP_PASSWORD=' "$ENV_FILE" | cut -d= -f2-)
DASHBOARD_PASSWORD=$(grep '^DASHBOARD_PASSWORD=' "$ENV_FILE" | cut -d= -f2-)

if [ -z "$DASHBOARD_PASSWORD" ]; then
  echo "ERROR: DASHBOARD_PASSWORD が $ENV_FILE に未定義です。" >&2
  exit 1
fi

# ダッシュボード生成
echo "[1/4] Generating dashboard..."
node scripts/generate-dashboard.js

# パスワード暗号化
echo "[2/4] Encrypting with password..."
rm -rf /tmp/yolo-encrypted
STATICRYPT_PASSWORD="$DASHBOARD_PASSWORD" \
  npx --yes staticrypt docs/index.html docs/dashboard.html \
  -d /tmp/yolo-encrypted --short \
  --template-color-primary '#1a73e8' \
  --template-color-secondary '#1a73e8' \
  --template-button 'ダッシュボードを開く' \
  --template-instructions 'YOLO MEDIA 記事管理ダッシュボード（パスワード保護）' \
  --template-title 'YOLO MEDIA Dashboard'

cp /tmp/yolo-encrypted/index.html docs/index.html
cp /tmp/yolo-encrypted/dashboard.html docs/dashboard.html

# Commit & Push
echo "[3/4] Committing changes..."
git add docs/
if git diff --staged --quiet; then
  echo "  → No changes to commit"
else
  git -c user.email=shiho.kaji@yolo-japan.co.jp -c user.name="shiho" \
    commit -m "auto: update dashboard $(date '+%Y-%m-%d %H:%M')"
fi

echo "[4/4] Pushing to GitHub..."
git push origin main

echo "✅ Done. Dashboard updated at https://yolojapan-content.github.io/media-dashboard/"
