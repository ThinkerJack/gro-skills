---
name: build-it
description: "按已确认的规格或计划落地改动。触发词：开始做/按计划实现/执行计划/落地任务/build it/implement/execute plan。支持参数 worktree（隔离执行）和 auto（做完自动验证提交）。"
---

# 开始做 build-it

按计划逐步实现，每步做完就运行该步的验证、读完整输出，再进下一步。

## 参数

用户可以在调用时带参数，**参数由用户敲出来，就是那次授权**：

| 参数 | 行为 |
|---|---|
| 无 | 在当前工作区实现，不提交 |
| `worktree` | 先建 worktree，在隔离副本里实现 |
| `auto` | 实现 → 跑 `prove-it` → **通过才**提交并推送 |
| `worktree auto` | 两者组合 |

## worktree 模式

规格和计划留在主分支，实现在隔离副本里进行，主工作区不受影响。

```bash
BASE=$(git branch --show-current)          # 记下基线分支
git worktree add .worktrees/<主题> -b <分支名>
echo "$BASE" > .worktrees/<主题>/.gro-baseline
cd .worktrees/<主题>
```

- 位置固定 `.worktrees/<主题>`，分支名从规格或计划的主题推导
- `.worktrees/` 和 `.gro-baseline` 应在 `.gitignore` 里；不在就先加
- **基线分支名写进 `.gro-baseline`**——`commit-it done` 靠它知道合并回哪
- worktree 与主工作区共享 `.git`，所以主分支上的规格、计划、文档在这里照样读得到

实现全程在 worktree 目录内进行。汇报时说清当前在哪个 worktree、哪个分支。

## auto 模式

实现完成后自己接着走：跑 `prove-it` → 结论是`通过`才转 `commit-it done`。

**结论是`失败`、`部分验证`或`阻塞`时停下报告，不提交。** 这一条没有例外——auto 授权的是「验证通过后自动提交」，不是「跳过验证直接提交」。

## 冲突时停下来

上游文档、代码事实、用户最新要求三者打架时，**说出来再继续**——不要挑一个默默执行。影响行为边界的冲突要停下等确认。

需要自行补齐会改变行为边界的决策时，同样停下：那说明规格缺了东西，回到 `write-spec` 或 `make-plan`。

## 交付时说清三件事

- 每一步的验证结果，以及实际跑了什么命令
- 偏离计划的地方、原因和影响
- 未覆盖的风险和剩余事项

必需证据是`失败`、`部分验证`或`阻塞`时，如实这么说。

## 交接

- 计划本身错了、或执行事实改变了整体顺序 → `make-plan`
- 出现原因未知的失败 → `fix-bug`
- 改动完成、验证入口齐备 → `prove-it`
