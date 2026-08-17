---
name: project-init
description: Use when creating a new project that should join the task-memory protocol — copying AGENTS.md and the task-memory skill, initializing git, creating a private GitHub repo, and bootstrapping the pinned #1 project-memory issue.
---

# project-init：新项目接入任务记忆协议

目标：把一个新项目目录变成遵守任务记忆协议、可在 GitHub 上跨设备协作的仓库。

## 协议文件来源（按顺序找，找到即用）

1. 当前仓库已有 `AGENTS.md` 与 `.dsh/skills/task-memory/` → 直接复制；
2. 本机用户级 `~/.dsh/skills/task-memory/` 存在 → 技能复制为 `<项目>/.dsh/skills/task-memory/`，`AGENTS.md` 从协议仓库取；
3. 都没有 → `gh repo clone dongshou/dsh-workhere /tmp/dsh-workhere-protocol`，从其复制两份文件。

## 执行步骤

1. **复制协议文件**：
   - `<项目>/AGENTS.md`
   - `<项目>/.dsh/skills/task-memory/SKILL.md`
   - 只复制协议文件，绝不复制来源仓库的其他内容。

2. **初始化并推送**：
   ```bash
   cd <项目>
   git init -b main
   git add AGENTS.md .dsh
   git commit -m "chore: add agent task-memory protocol"
   gh repo create <仓库名> --private --source=. --remote=origin --push
   ```

3. **建标签**（已存在则跳过）：
   ```bash
   gh label create area:memory --color 0366d6 --force
   gh label create status:in-progress --color 1a7f37 --force
   ```

4. **初始化项目层 Wiki**：
   - GitHub 无公开 Wiki API，首次需人操作一次：请用户在网页打开 `<仓库URL>/wiki`，点击 "Create the first page"。
   - 激活后 agent 维护：`git clone <仓库URL>.wiki.git`，写入 `Home.md`（项目简介 + 页面索引）；具体分页按项目实际定义——要求见 task-memory 技能的「Wiki 页面定义要求」，有真实内容才建页。提交推送。
   - 用户暂未激活时：临时 `gh issue create --title "项目记忆"` 并 `gh issue pin 1` 过渡；Wiki 激活后把内容迁过去并关闭该 issue。

5. **向用户回显**：仓库 URL、Wiki 激活状态（或 #1 过渡状态）、开第一个任务的命令（`gh issue create --title <任务名>`）。

## 快捷方式

若 `bin/bootstrap-task-memory.sh` 存在，直接运行
`bash bin/bootstrap-task-memory.sh <项目目录> [仓库名]`，
一步完成第 1~3 步并建过渡 #1；Wiki 仍需按第 4 步由用户人工激活一次，然后回显结果。

## 纪律

- 仓库一律 `--private`，除非用户明确要求公开。
- 新项目初始只含协议文件；第一个任务 issue 由用户在需要时开。
