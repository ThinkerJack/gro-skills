---
name: commit-it
description: "按语义提交已验证的改动；done 推送当前分支，finish 按项目约定合并或开 PR 并清理。仅在用户明确要求提交时使用。"
disable-model-invocation: true
---

# 提交代码 commit-it

**commit 和 push 是两次独立授权。参数由用户敲出来才成立，AI 不自行补上。** 副作用范围逐级扩大：

| 调用 | 副作用范围 |
|---|---|
| `commit-it` | 只提交到本地 |
| `commit-it done` | 提交 → 推送**当前分支** |
| `commit-it finish` | 在 `done` 基础上收尾：按项目约定合并回基线或开 PR，然后清理 worktree |

## 前提

- 本次请求里有明确的 commit 授权
- 待提交的改动有新鲜验证证据；没有先转 `prove-it`
- 已读过 staged、unstaged、untracked、deleted 四类改动，能区分哪些属于本次任务

## 提交

1. 按语义边界分组。**归属不明、疑似无关、或涉及风险文件时先停下确认**
2. 每组用显式 pathspec 逐一 add，然后复核 staged stat 和必要的 diff
3. 提交标题说明结果；验证摘要只写实际跑过的检查
4. 沿用仓库现有的 commit 风格——先看最近几条 log 判断，不要自创格式

密钥、令牌、本机配置、临时产物、未审查的二进制、与本次任务无关的改动都不进提交。`git add -A` 会把这些一并带上，所以不用它。不改写已有历史，不用破坏性恢复命令。

## `done`：推送当前分支

```bash
git push origin "$(git branch --show-current)"
```

被拒时先看清原因：远端领先且改动面无交集，可以 rebase 后重推；有交集就停下说明。**任何情况都不用 force。**

## `finish`：收尾

`finish` 是唯一会动到基线分支的一档。先完成 `done`，基线分支名从 `.gro-baseline` 读（`build-it worktree` 写下的）。**走合并还是 PR 由项目决定**——约定写在项目的经验文件或 `AGENTS.md` 里，不在这里写死；**项目没写约定时停下来问，不要替它选。**

- **合并路径**：切回主工作区的基线分支，`git merge --no-ff <分支>`，推送，然后 `git worktree remove` 并删掉已合并的分支
- **PR 路径**：`gh pr create --base <基线>`，保留分支待 review，清理等 PR 合并之后

**冲突时停在冲突状态等人，不自行选边。** 基线分支有保护规则或推送被拒，说明情况后停下。

## 交付

每个 commit 的 hash、标题、文件范围和对应验证 · 剩余未提交的改动及原因 · 推送的远端与分支 · 合并与清理结果，或明确说明「未推送」。
