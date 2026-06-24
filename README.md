# Gro Skills

AI coding skills for growing ideas into shippable code.

Gro Skills 是一套面向 AI 编程任务的 skill system。它的核心方法是 GroPath：把模糊想法逐步推进成可验证、可评审、可交付的代码。

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

当前结构：

- `skills/` - 通用路径 skill，跨项目适用。
- `docs/` - 公开介绍文档和 HTML 视图。

核心规则：skill 保持通用和轻量，项目差异先放在使用方仓库里。

## 当前文档

- [Gro Skills System](docs/README.md)
- [Gro Skills System v0.1 HTML](docs/gro-skills-system-v1.html)
