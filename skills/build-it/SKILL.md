---
name: build-it
description: "按已确认的规格或计划实现；worktree 在隔离副本里执行，ship 验证通过后提交并推送功能分支。"
disable-model-invocation: true
---

# 开始做 build-it

按计划逐步实现，每步做完运行该步的验证，再进下一步。

## 参数

**参数由用户敲出来，就是那次授权。AI 不自行补上。**

| 参数 | 副作用范围 |
|---|---|
| 无 | 只改文件，不提交 |
| `worktree` | 在隔离副本里改文件，不提交 |
| `ship` | 改文件 → 验证 → 提交 → 推送功能分支 |
| `worktree ship` | 两者组合 |

**`ship` 不合并、不推送基线分支**——即使自动化跑偏，影响也止于一个功能分支。合并回基线或开 PR 是另一步：`commit-it finish`。

## worktree 模式

```bash
BASE=$(git branch --show-current)          # 记下基线分支
git worktree add .worktrees/<主题> -b <分支名>
echo "$BASE" > .worktrees/<主题>/.gro-baseline
cd .worktrees/<主题>
```

- 位置固定 `.worktrees/<主题>`，分支名从规格或计划的主题推导
- `.worktrees/` 和 `.gro-baseline` 应在 `.gitignore` 里；不在就先加
- **基线分支名写进 `.gro-baseline`**——`commit-it finish` 靠它知道往哪合
- 新副本只带得走**已提交**的内容。规格或计划还留在主工作区没提交时，先提交，否则在 worktree 里读不到

实现全程在 worktree 目录内。汇报时说清当前在哪个 worktree、哪个分支。

## ship 模式

跑规格或计划里定义的验证命令——不是随手挑一个测试——然后给出四态之一：`通过` / `失败` / `部分验证` / `阻塞`。

**只有`通过`才继续**，按 `commit-it done` 的规矩语义分组提交并推送功能分支。其余三种停下报告，如实说出结论，不改写成「基本可用」。`ship` 授权的是「验证通过后自动推送」，不是「跳过验证直接推」。

## 冲突时停下来

上游文档、代码事实、用户最新要求三者打架时，**说出来再继续**——不要挑一个默默执行。

需要自行补齐会改变行为边界的决策时同样停下：那说明规格缺了东西，回到 `write-spec` 或 `make-plan`。

## 交付

实际跑了什么命令得到什么结果 · 偏离计划的地方和原因 · 未覆盖的风险和剩余事项。

## 交接

出现原因未知的失败 → `fix-bug`；功能分支要合并回基线或开 PR → `commit-it finish`。
