# Gro Skills System

Gro Skills 是一组 AI 编程阶段契约。它把用户自己的工作流表达为可触发、可交接、可验证的 skills，但不要求所有任务按同一条链路执行。

## 系统地图

```text
主流程：set-goal -> write-brief -> make-design -> write-spec -> make-plan -> build-it -> prove-it -> review-it
跨阶段：find-proof / poke-holes（仅用户显式要求）
异常分支：fix-bug -> prove-it
显式动作：commit-it / save-lesson
```

任务可从当前风险对应的阶段进入；轻量改动不需要补演上游文档。

## Skills

| Skill id | 中文名 | 角色 | 作用 |
|---|---|---|---|
| `set-goal` | 定目标 | 主流程 | 多轮收敛模糊意图，由用户确认目标。 |
| `write-brief` | 写需求 | 主流程 | 整理场景、范围、约束和验收标准。 |
| `make-design` | 做设计 | 主流程 | 确定模块边界、流转、接口和取舍。 |
| `write-spec` | 写规格 | 主流程 | 形成下一个 AI 可独立执行的自包含契约。 |
| `make-plan` | 拆计划 | 主流程 | 默认落库为有依赖、验证和检查点的执行基线。 |
| `build-it` | 开始做 | 主流程 | 按计划落地并记录验证与偏移。 |
| `prove-it` | 验证它 | 主流程 | 用新鲜证据给出通过/失败/部分验证/阻塞结论。 |
| `review-it` | 做评审 | 主流程 | 评审已完成 diff、规格覆盖、证据和剩余风险。 |
| `find-proof` | 找证据 | 跨阶段 | 验证会影响工程决策的 claim。 |
| `poke-holes` | 挑毛病 | 跨阶段 | 仅在用户显式要求时对指定主张做对抗性审视。 |
| `fix-bug` | 修问题 | 异常分支 | 对具体失败确认根因、最小修复并复验。 |
| `commit-it` | 提交代码 | 显式动作 | 明确授权后分组 commit；push 需要独立授权。 |
| `save-lesson` | 记经验 | 显式动作 | 按授权将当前 session 的可复用经验写入正确作用域。 |

## Structure

| Path | 放什么 | 不放什么 |
|---|---|---|
| `skills/` | 通用路径、证据边界、阶段责任 | 具体技术栈命令、公司流程、项目路径 |
| `docs/` | 公开介绍文档和 HTML 视图 | 历史调研、私有参考资料 |

## 工程验证契约

- 关键路径验证：按风险定义证据层级、状态准备、清理动作和
  `通过 / 失败 / 部分验证 / 阻塞`结论。
- 运行时证明：补足低层测试覆盖不到的真实运行风险，不写死项目服务、设备、命令和凭据。

## 持续维护

主力模型或 skill 触发机制大版本变更时，用固定的有 skill / 无 skill 对照用例，重新审计指令是仍必要、已冗余还是可能有害。

## Public Docs

- [Gro Skills System Map](./gro-skills-system-v1.html)
