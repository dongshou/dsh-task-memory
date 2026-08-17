---
name: task-memory
description: 任务记忆协议操作手册。Use when starting work on a task (reading its issue timeline and writing an opening confirmation), when finishing a work segment (writing a checkpoint comment), when closing a task (distilling into project memory), or when deciding whether a fact should be promoted to a skill.
---

# task-memory：任务记忆协议

核心一句话：**任务 = Issue；知识 = Comment；证据 = session 日志（永不进 issue）；纪律 = 结论进评论、证据留 session、永不改旧评论。**

## 开工（OPEN）

1. 读目标 issue 的正文 + 最后 3~5 条评论。
2. 向用户回显 5 行确认：我理解的目标 / 当前进行到哪 / 下一步做什么 / 已知阻塞 / 关联任务。

## 收工（CHECKPOINT）——何时写评论

四种时机（满足任一即写，都不满足不写）：

- 有了**可验证的进展**（完成了什么 + 下一步）；
- 产生了**决定**（选了 X，理由 Y）；
- 遇到了**阻塞**（卡在 X，原因 Y，需要 Z）；
- **目标/范围变了**。

判据永远是：**下一个接手的人不知道这条，会走错路吗？** 会 → 写；不会 → 不写。一个长 session 通常只写 3~5 条评论，每条 1~5 行，**绝不搬运对话原文**——原文留在 session 日志，那是证据层，由 DSH 自动持久化。

## 评论模板

```markdown
进展: 完成了 X；下一步 Y
决定: 用 X 方案，理由 Y（见 #12 或 PR #15）
阻塞: 卡在 X，原因 Y，需要 Z（@某人）
更新: SMTP 已恢复（取代上面第 3 条）——事实变了发新评论，旧评论永不改动
完成提议: 验收对照 [x]① [x]② [ ]③ → 人确认后 close
```

## 三层知识

| 层 | 在哪 | 写入时机 |
|---|---|---|
| 任务层 | 本任务 issue 时间线 | 每次 CHECKPOINT |
| 项目层 | 仓库 Wiki（Home 项目简介 + 具名页面：架构/环境与部署/约定/变更与决策/已知问题；Wiki 未激活时临时用置顶 issue #1） | 任务关闭时：把"别的任务还需要"的结论蒸馏进 Wiki |
| 系统层 | `.dsh/skills/<名>/SKILL.md` | 同一知识在**第二个项目**再出现时升格为技能（二现规则） |

互链：issue 评论可贴 Wiki 页链接；Wiki 页里写 `#编号` 自动链接 issue。任务专属知识留在 issue 随任务归档，只有熬过"别的任务还需要"考核的结论才进 Wiki。

调用节奏：任务层每回合读尾部；项目层每开工读一次摘要；系统层按需加载，不常驻注入。

## 事实更新规则

- 事件永远为真，事实会变——事实变了只做一件事：**追加新评论并声明取代**。
- 同名事实多条并存时，最新评论胜出；旧评论是历史证据，永不删除。
