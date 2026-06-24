# GroPath

Grow ideas into shippable code.

GroPath 是一套面向 AI 编程任务的成长路径 skill system。它把模糊想法逐步推进成可验证、可评审、可交付的代码。

核心路径：

```text
定目标 -> 挑毛病 -> 找证据 -> 写需求 -> 做设计 -> 写规格
-> 拆计划 -> 开始做 -> 修问题 -> 验证它 -> 做评审 -> 记经验
```

当前 core skills：

```text
set-goal     poke-holes   find-proof    write-brief
make-design  write-spec   make-plan     build-it
fix-bug      prove-it     review-it     save-lesson
```

系统分三层：

- `skills/` - 通用路径 skill，跨项目适用。
- `packs/` - 可选能力包，例如 research、Flutter、Figma、agent-ops。
- `overlays/` - 个人、公司或具体项目规则。

核心规则：core 保持通用和轻量，差异放进 packs 或 overlays。

## 当前文档

- [GroPath Skill System](docs/README.md)
- [GroPath Skill System v0.1 HTML](docs/gropath-skill-system-v1.html)
