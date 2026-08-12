# 已降级的 skill

这里的 skill 不在同步名单里，不会进入任何项目，也就不占 context。
保留是为了历史可查——需要时可以捞回内容，而不必从 git history 里翻。

降级依据见 [`../docs/decisions/2026-07/使用诊断.md`](../docs/decisions/2026-07/使用诊断.md) 与
[`../docs/decisions/2026-07/迭代方案.md`](../docs/decisions/2026-07/迭代方案.md)。

| skill | 降级时间 | 原因 |
|---|---|---|
| `write-brief` | 2026-07-28 | 全时段调用最低（Codex 9 次、Claude 0 次），作者自评「基本没用到」。产品需求已并入 `write-spec` 的人区。 |
| `set-goal` | 2026-07-28 | 访谈纪律抽成独立的 `ask-it`（原名 `clarify`），其余职能并入 `sketch-it`（原名 `make-sketch`）。 |
| `make-design` | 2026-07-28 降级 · **2026-08-12 以 `design-it` 复活** | 降级理由是产物「很长、细节很多、review 不动」，并判定与 `write-spec` 重叠。后一条判断有误：`write-spec` 的「关键取舍」记录**已经做完**的选型，真正做架构和选型的那一步无处安放。前一条是真问题，但根源是它写于「人区 / AI 区」约定之前——`design-it` 用人区选型卡（一屏）+ AI 区实现契约修掉了这个死因。原文保留在此备查。 |
