---
name: write-spec
description: "Use when 用户需要写规格、可执行规格、agent spec、实现说明、测试契约；also use when an approved design must become a self-contained spec that another AI agent can implement without reopening original PRD, research, or design sources."
---

# 写规格 write-spec

## 核心原则

规格是给下一位执行者的完整上下文。好的规格让 AI 不需要猜字段、文案、路径、接口和验收方式。

## 什么时候用

- 设计已被认可，需要进入实现。
- 任务要交给另一个 AI、另一个线程或未来的自己。
- 原始资料很多，需要压缩成可执行上下文。
- 需要把需求和设计转成文件级、接口级、测试级说明。

## 不要用于

- 需求或设计还没定；先用 `write-brief` 或 `make-design`。
- 只是拆任务；用 `make-plan`。
- 只是记录调研结论；用 `find-proof` 或文档。

## 输入

- 已认可的需求和设计。
- 必要证据。
- 项目规则和现有约定。
- 待实现范围。

## 操作

1. 写清目标、范围和非目标。
2. 写清关键决定和原因；重要取舍能追溯到需求、设计或证据。
3. 列出文件级或模块级改动。
4. 明确字段名、函数签名、路由、事件名、文案、常量和状态。
5. 写出 Given/When/Then 或等价测试契约。
6. 单独写 `Verification`：单元、集成、端到端、视觉、手动验收，以及每类检查的通过标准。
7. 单独写 `Change Policy`：实现中发现规格错误时怎么回流，而不是让执行者自己猜。
8. 标出不得改动的边界。
9. 标注开放问题；不能让执行者猜关键事实。

## 输出

- 自包含实现规格。
- 目标、范围、非目标和关键决定。
- 文件和接口清单。
- 确定的命名、常量、文案和契约。
- `Verification` 验证分类和验收标准。
- `Change Policy` 变更回流规则。
- 不做事项和风险。

## 停止条件

另一个 AI 只读这份规格，就能拆计划并开始实现。

## 升级条件

- 规格需要引用未读来源才能执行：回到 `find-proof` 或补充规格。
- 方案仍有争议：回到 `make-design`。
- 范围过大：拆成多个规格。

## 成功证据

规格里没有“按需”“等等”“类似”这类会让执行者猜测的关键占位。
