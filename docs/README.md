# Gro Skills System

Gro Skills 是一套面向 AI 编程任务的 skill system。它的核心方法是 GroPath：把模糊想法推进成可验证、可评审、可交付的代码。

## Core Path

```text
set-goal -> poke-holes -> find-proof -> write-brief -> make-design -> write-spec
-> make-plan -> build-it -> fix-bug -> prove-it -> review-it -> save-lesson
```

中文记忆版：

```text
定目标 -> 挑毛病 -> 找证据 -> 写需求 -> 做设计 -> 写规格
-> 拆计划 -> 开始做 -> 修问题 -> 验证它 -> 做评审 -> 记经验
```

## Skills

| Skill id | 中文名 | 作用 |
|---|---|---|
| `set-goal` | 定目标 | 把模糊请求整理成清楚的问题、目标、约束和成功标准。 |
| `poke-holes` | 挑毛病 | 主动攻击想法、需求、方案和计划里的漏洞。 |
| `find-proof` | 找证据 | 判断证据力度，并从代码、运行结果、文档、数据、网页或调研库中找依据。 |
| `write-brief` | 写需求 | 把目标和证据整理成可设计、可验收的需求。 |
| `make-design` | 做设计 | 决定模块边界、数据流、接口、取舍和风险。 |
| `write-spec` | 写规格 | 写成下一位 AI 不看原始资料也能执行、验证和回流变更的规格。 |
| `make-plan` | 拆计划 | 把规格拆成有顺序、有依赖、有文件范围、有预期结果的小任务。 |
| `build-it` | 开始做 | 执行已有规格或计划，不作为普通编码入口，并记录偏离。 |
| `fix-bug` | 修问题 | 失败时先复现、建假设、找证据，再最小修复。 |
| `prove-it` | 验证它 | 用本轮新鲜验证证据证明可用；没有证据不声明完成。 |
| `review-it` | 做评审 | 审 diff、风险和证据，准备交付或 handoff。 |
| `save-lesson` | 记经验 | 把重复失败、项目规则、领域语言和流程缺口沉淀成长期上下文或自动化。 |

## Structure

| Path | 放什么 | 不放什么 |
|---|---|---|
| `skills/` | 通用路径、证据边界、阶段责任 | 具体技术栈命令、公司流程、项目路径 |
| `docs/` | 公开介绍文档和 HTML 视图 | 历史调研、私有参考资料 |

## Public Docs

- [Gro Skills System v0.1 HTML](./gro-skills-system-v1.html)
