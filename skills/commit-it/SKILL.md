---
name: commit-it
description: "仅当用户明确要求提交时，把已验证的改动按语义分组提交。触发词：提交代码/提交一下/打提交/commit/commit it。参数 done 表示提交并推送，在 worktree 里则合并回基线分支。"
disable-model-invocation: true
---

# 提交代码 commit-it

**commit 和 push 默认是两次独立授权。** 「提交」不含「推送」——除非用户带了 `done`。

## 参数

**参数由用户敲出来才成立，AI 不自行补上。** 副作用范围逐级扩大：

| 调用 | 副作用范围 |
|---|---|
| `commit-it` | 只提交到本地 |
| `commit-it done` | 提交 → 推送**当前分支** |
| `commit-it finish` | 在 `done` 基础上收尾：按项目约定合并回基线或开 PR，然后清理 worktree |

`finish` 是唯一会动到基线分支的一档。**走哪条收尾路径由项目决定**——个人仓库直接合并、有人协作的仓库开 PR——约定写在项目的经验文件或 `AGENTS.md` 里，不在这里写死。**项目没写约定时停下来问，不要替它选。**

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

## `done`：推送当前分支

```bash
git push origin "$(git branch --show-current)"
```

push 被拒时先看清原因再动。远端领先且改动面无交集，可以 rebase 后重推；有交集就停下说明。**任何情况都不用 force。**

## `finish`：收尾

先完成 `done`，然后读项目约定决定走哪条路：

```bash
BASE=$(cat .gro-baseline)            # build-it worktree 写下的基线分支
BRANCH=$(git branch --show-current)
```

- **合并路径**：切回主工作区的 `$BASE`，`git merge --no-ff "$BRANCH"`，推送基线
- **PR 路径**：`gh pr create --base "$BASE"`，保留分支待 review

两条路都以清理收尾：`git worktree remove` 加删除已合并的分支；走 PR 的话，清理等 PR 合并之后。

**冲突时停在冲突状态等人，不自行选边。** 基线分支有保护规则或推送被拒，说明情况后停下。

每一步的结果都要报告：合并了什么、推到哪、PR 号是多少、清理了什么。

## 不提交的东西

密钥、令牌、本机配置、临时产物、未审查的二进制、与本次任务无关的改动。

用 `git add -A` 会把这些一并带上，所以不用它。

不改写已有历史，不用破坏性恢复命令。

## 交付

每个 commit 的 hash、标题、文件范围和对应验证 · 剩余未提交的改动及原因 · 推送的远端与分支 · 合并与清理结果，或明确说明「未推送」。
