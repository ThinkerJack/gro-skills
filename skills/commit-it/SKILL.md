---
name: commit-it
description: "仅当用户明确要求提交时，把已验证的改动按语义分组提交。触发词：提交代码/提交一下/打提交/commit/commit it。参数 done 表示提交并推送，在 worktree 里则合并回基线分支。"
---

# 提交代码 commit-it

**commit 和 push 默认是两次独立授权。** 「提交」不含「推送」——除非用户带了 `done`。

## 参数

| 调用 | 行为 |
|---|---|
| `commit-it` | 只提交，不推送 |
| `commit-it done` | 提交 → 推送；在 worktree 里则继续合并回基线分支并清理 |

`done` 由用户敲出来，那就是本次的推送授权，不必再问一遍。**AI 不能自己决定加上 `done`。**

## 前提

- 本次请求里有明确的 commit 授权
- 待提交的改动有新鲜验证证据；没有先转 `prove-it`
- 已读过 staged、unstaged、untracked、deleted 四类改动，能区分哪些属于本次任务

## 提交

1. 按语义边界分组。**归属不明、疑似无关、或涉及风险文件时先停下确认**
2. 每组用显式 pathspec 逐一 add，然后复核 staged stat 和必要的 diff
3. 提交标题说明结果；验证摘要只写实际跑过的检查
4. 每次提交后记录 hash 和标题，复查工作区剩余
5. 沿用仓库现有的 commit 风格——先看最近几条 log 判断，不要自创格式

## `done` 的收尾

```bash
git push origin "$(git branch --show-current)"

# 在 worktree 里才继续：
BASE=$(cat .gro-baseline)                  # build-it worktree 写下的基线分支
BRANCH=$(git branch --show-current)
MAIN=$(git worktree list --porcelain | head -1 | cut -d' ' -f2)

cd "$MAIN" && git checkout "$BASE"
git merge --no-ff "$BRANCH"
git push origin "$BASE"
git worktree remove ".worktrees/<主题>"
git branch -d "$BRANCH"
```

**每一步的结果都要报告**，尤其是合并冲突——冲突时停在冲突状态等用户，不要自行选边。

基线分支有保护规则、或 push 被拒时，停下说明情况，不改用 force。

## 不提交的东西

密钥、令牌、本机配置、临时产物、未审查的二进制、与本次任务无关的改动。

用 `git add -A` 会把这些一并带上，所以不用它。

不改写已有历史，不用破坏性恢复命令。

## 交付

每个 commit 的 hash、标题、文件范围和对应验证 · 剩余未提交的改动及原因 · 推送的远端与分支 · 合并与清理结果，或明确说明「未推送」。
