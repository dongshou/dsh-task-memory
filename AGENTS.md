# AGENTS.md — 本仓库的 agent 工作协议

## 任务与记忆纪律（无条件遵守）

1. **任务 = GitHub Issue**。开工前先读目标 issue 的正文和最后几条评论；阶段性收工往 issue 发一条结论评论。
2. **只蒸馏结论进评论，绝不搬运对话原文**。写评论的唯一判据：下一个接手的人不知道这条，会走错路吗？会 → 写；不会 → 不写。原始对话留在 session 日志（证据层），永不进 issue。
3. **永不修改、永不删除旧评论**。事实变了 = 发一条新评论并声明取代哪条（"更新：取代上面第 N 条"）。最新评论即当前真相，旧评论是历史证据。
4. **三层知识各归其位**：任务层 = 本任务 issue 时间线；项目层 = 仓库 Wiki（首页索引 + 具名页面；任务关闭时，把"别的任务还需要"的结论蒸馏进 Wiki；Wiki 未激活时临时用置顶 issue #1 过渡）；系统层 = `.dsh/skills/<名>/SKILL.md`（同一知识在第二个项目再出现时升格为技能）。

## 操作手册

- DSH agent：用 `skill` 工具加载 `task-memory`，内含完整模板（开工确认、评论格式、三层上浮规则）。
- 其他 agent（Claude Code / Codex 等）：直接阅读 `.dsh/skills/task-memory/SKILL.md`。

## 新项目接入

- DSH agent：加载 `project-init` 技能，按步骤自动完成（协议文件复制 → git init → 私有仓库 → Wiki 首页初始化）；或直接运行 `bin/bootstrap-task-memory.sh <项目目录> [仓库名]`。
- 其他 agent：阅读 `.dsh/skills/project-init/SKILL.md` 手动执行。
