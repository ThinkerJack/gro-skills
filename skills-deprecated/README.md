# 已降级的 skill

这里的 skill 不在同步名单里，不会进入任何项目，也就不占 context。
保留是为了历史可查——需要时可以捞回内容，而不必从 git history 里翻。

降级依据见 [`../docs/decisions/2026-07/使用诊断.md`](../docs/decisions/2026-07/使用诊断.md) 与
[`../docs/decisions/2026-07/迭代方案.md`](../docs/decisions/2026-07/迭代方案.md)。

| skill | 降级时间 | 原因 |
|---|---|---|
| `write-brief` | 2026-07-28 | 全时段调用最低（Codex 9 次、Claude 0 次），作者自评「基本没用到」。产品需求已并入 `write-spec` 的人区。 |
| `set-goal` | 2026-07-28 | 访谈纪律抽成独立的 `clarify`，其余职能并入 `make-sketch`。 |
| `make-design` | 2026-07-28 | 产物「很长、细节很多、review 不动」，与 `write-spec` 职能重叠。设计决策并入 `write-spec` 的人区「关键取舍」。 |
