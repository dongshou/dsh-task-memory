#!/usr/bin/env bash
# 新项目接入任务记忆协议（阶段 0 引导脚本）
# 用法: bash bin/bootstrap-task-memory.sh <项目目录> [仓库名]
# 动作: 复制协议文件 → git init + 提交 → 建私有 GitHub 仓库并推送 → 建置顶 #1「项目记忆」
set -euo pipefail

TARGET="${1:?用法: bash bin/bootstrap-task-memory.sh <项目目录> [仓库名]}"
REPO_NAME="${2:-$(basename "$TARGET")}"
OWNER="$(gh api user -q .login)"

mkdir -p "$TARGET"

# 1. 复制协议文件（AGENTS.md = 所有 agent 的纪律入口；.dsh/skills = 技能随仓库跨设备）
cp AGENTS.md "$TARGET/AGENTS.md"
cp -r .dsh "$TARGET/.dsh"

cd "$TARGET"

# 2. git init + 提交协议
if [ ! -d .git ]; then git init -b main >/dev/null; fi
git add AGENTS.md .dsh
git -c user.name="$OWNER" -c user.email="$OWNER@users.noreply.github.com" \
    commit -m "chore: add agent task-memory protocol" >/dev/null 2>&1 || true

# 3. 建私有仓库并推送（已存在则跳过）
if ! gh repo view "$OWNER/$REPO_NAME" >/dev/null 2>&1; then
  gh repo create "$REPO_NAME" --private --source=. --remote=origin --push
else
  git remote add origin "https://github.com/$OWNER/$REPO_NAME.git" 2>/dev/null || true
  git push -u origin main 2>/dev/null || true
fi

# 4. 建置顶 #1「项目记忆」（已存在则跳过）
if ! gh issue list --state all --limit 300 --json title -q '.[] | select(.title=="项目记忆")' | grep -q .; then
  gh issue create --title "项目记忆" \
    --body "本仓库所有任务共享的知识层。规则见 AGENTS.md：只追加结论、永不改旧评论。" >/dev/null
  gh issue pin 1
fi

echo "✅ $TARGET 已接入任务记忆协议"
echo "   仓库: https://github.com/$OWNER/$REPO_NAME"
echo "   #1「项目记忆」已置顶（过渡形态）"
echo "   下一步: 在网页打开上面的仓库 /wiki 点一次 Create the first page，激活 Wiki 后把内容迁入"
echo "   开始新任务: cd $TARGET && gh issue create --title <任务名> --label area:memory"
