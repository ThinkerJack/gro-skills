---
name: review-it
description: "Use when 用户需要评审、review、检查 diff、准备交付、写 handoff、评估风险；also use when changes are ready for final review, handoff, commit or PR preparation, without embedding project-specific git workflow."
---

# 做评审 review-it

## 核心原则

评审关注风险，不是复述改了什么。先看会坏在哪里，再决定能不能交付。

## 什么时候用

- 改动完成，需要最终 review。
- 用户要求检查 diff、风险、遗漏或交付说明。
- 准备提交、PR、handoff 或交给别人继续。
- 需要把验证证据和残余风险整理出来。

## 不要用于

- 还没跑验证；先用 `prove-it`。
- 需要修复失败；用 `fix-bug`。
- 需要挑方案毛病而不是审改动；用 `poke-holes`。

## 输入

- diff 或改动摘要。
- 需求、规格、计划。
- 验证结果。
- 项目交付规则。

## 操作

1. 对照需求和规格检查是否遗漏。
2. 审查 diff 的风险点：行为、数据、边界、安全、性能、兼容、可维护性。
3. 检查验证证据是否覆盖主要风险。
4. 标出未验证或无法验证的内容。
5. 准备交付说明：改了什么、为什么、怎么验证、还剩什么风险。
6. 不把 git/PR 平台细节写死；交给 pack 或 overlay。

## 输出

- 主要发现，按严重程度排序。
- 覆盖的需求和遗漏项。
- 风险摘要。
- 验证证据。
- 交付或 handoff 说明。

## 停止条件

交付方能判断是否合并、继续修、回到设计或请求人工决策。

## 升级条件

- 发现验证不足：回到 `prove-it`。
- 发现实现缺陷：回到 `fix-bug` 或 `build-it`。
- 发现需求或设计问题：回到 `write-brief` 或 `make-design`。

## 成功证据

评审输出优先呈现风险和证据，而不是泛泛总结。
