# dsh-task-memory — AI Agent 任务记忆协议

用 GitHub 原生能力（Issue + Wiki + skills + git）为多个 AI agent 建立**任务级共享记忆**：跨 session 续接、跨 agent 协作、跨设备同步。**零自研服务、零运行时代码。**

## 解决的问题

| 痛点 | 通常现状 | 本协议 |
|---|---|---|
| 跨 session 记忆断裂 | 每个会话从零开始，靠人复述 | 任务状态存在 issue 时间线，开工即续 |
| 按 session 而非任务组织 | 一个会话混多个任务，上下文互相污染 | **任务 = Issue**，session 只是执行场所 |
| 各 agent 各记各的 | 记忆锁死在单一产品里 | AGENTS.md + git 仓库 = 跨产品通用共享层 |
| 跨设备协作 | 状态在本机 | git + GitHub 即同步、即审计 |

## 架构

```
真相源（每项目仓库）:  Issues（任务层，时间组织）
                      + Wiki（项目层，主题组织）
                      + .dsh/skills/（系统层，按需加载）
派生视图:              GitHub Projects 看板（可选，可随时重建）
证据层（不进仓库）:    agent 各自的 session 日志
同步/审计:             git + GitHub
```

### 三层知识

| 层 | 在哪 | 写入时机 |
|---|---|---|
| 任务层 | issue 评论时间线 | 每次 checkpoint |
| 项目层 | 仓库 Wiki | 任务关闭时：把"别的任务还需要"的结论蒸馏进去 |
| 系统层 | `.dsh/skills/<名>/SKILL.md` | 同一知识在第二个项目再出现时升格（二现规则） |

Wiki 页面目录**不预设**，按项目实际定义：用项目语言命名、按主题分页、首页放简介+索引、有内容才建页（要求 + 示例见 [task-memory 技能](.dsh/skills/task-memory/SKILL.md)）。

### 四条纪律

1. **任务 = GitHub Issue**：开工先读时间线尾部；收工写结论评论。
2. **只蒸馏结论，不搬原文**：判据 = "下一个接手的人不知道这条会走错路吗？"；原始对话留在 session。
3. **永不改旧评论**：事实更新 = 追加新评论并声明取代；最新评论即当前真相。
4. **三层各归其位**：任务专属知识随 issue 归档；跨任务的进 Wiki；跨项目的升格技能。

## 同步与跨 agent

**跨设备同步**：一切状态都在 git 数据里——Issues、Wiki、技能文件都是 git 仓库的一部分，`push/pull` 即同步。换设备 `git clone` 即可无缝接续，不需要任何中心化服务迁移。

**跨 agent 协作**：协议不绑定任何 agent 产品，靠三层通用入口：

| 入口 | 机制 |
|---|---|
| 纪律 | `AGENTS.md` 是跨产品通用协议文件，Claude Code / Codex / Cursor / DSH 等自动读取 |
| 工具 | 读写 issue 用 `gh` CLI 或 GitHub MCP server——各 agent 产品均支持（DSH 内置 MCP 客户端，Claude Code / Codex 原生支持） |
| 技能 | `.dsh/skills/*/SKILL.md` 是普通 markdown，非 DSH 的 agent 可直接阅读 |

**审计**：issue 评论自带作者/时间/编辑历史，代码和文档有 git blame——谁在哪个会话改了什么，双向可查（评论的「来源」字段 ↔ session 首条消息的 issue 号）。

**任务拆分（分支）**：issue 时间线刻意线性；拆分 = 新 issue + 父子引用（`gh issue create --parent <父issue号>` 创建 sub-issue，或正文写「从 #N 拆出」）。

## 快速开始

### 新项目

```bash
git clone https://github.com/dongshou/dsh-task-memory.git
bash dsh-task-memory/bin/bootstrap-task-memory.sh <项目目录> [仓库名]
```

（DSH agent 可直接说："用 project-init 技能创建项目"。Wiki 首页需人工在网页激活一次，见 [Wiki: 已知问题](https://github.com/dongshou/dsh-task-memory/wiki/已知问题)。）

### 历史项目

只做三件事：① 复制 `AGENTS.md` + `.dsh/skills/` 进仓库（与已有 CLAUDE.md 等合并，不覆盖）；② 播种 Wiki（写项目简介/架构/已知问题）；③ 给**当前要做的**工作开 issue。不回填历史，只接未来。

### 日常使用

任何 agent 进仓库即读 `AGENTS.md` 四条纪律。DSH agent 可加载 `task-memory` 技能获得完整模板。Claude Code / Codex 等同样支持 AGENTS.md，技能文件对它们是普通 markdown。

## 目录

```
AGENTS.md                    协议入口（所有 agent 必读）
.dsh/skills/task-memory/     任务执行手册（开工/checkpoint/关闭模板）
.dsh/skills/project-init/    新项目自动接入手册
bin/bootstrap-task-memory.sh 新项目接入脚本（一条命令）
```

## 改进本协议

本仓库自己就按这套协议运行（吃自己的狗粮）：

1. 改进意见 → 开 [issue](https://github.com/dongshou/dsh-task-memory/issues) 讨论；
2. 定案的决定 → 写进 [Wiki: 变更与决策](https://github.com/dongshou/dsh-task-memory/wiki/变更与决策)；
3. 成熟可复用的模式 → 升格为 `.dsh/skills/` 里的技能；
4. 修改提交 PR，欢迎 fork / clone / 贡献。

## 协议文件

[AGENTS.md](AGENTS.md) · [task-memory 技能](.dsh/skills/task-memory/SKILL.md) · [project-init 技能](.dsh/skills/project-init/SKILL.md)

## License

[MIT](LICENSE)
