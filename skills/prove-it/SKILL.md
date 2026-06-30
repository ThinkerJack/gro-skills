---
name: prove-it
description: "用新鲜验证证据证明改动可用,运行检查、分类失败、修复并复验。触发词:验证/跑测试/QA/自测/证明可用/修到通过/验收/prove it/verify/test。Use before claiming work is complete, fixed, working, passing, or ready, and when running validation and repair loops."
---

# 验证它 prove-it

## 核心原则

不要说它好了，要证明它好了。完成声明必须有新鲜、具体、可复查的验证证据。

## 什么时候用

- 实现完成，准备交付。
- 用户要求验证、QA、自测、跑检查。
- 你准备说“完成了”“修好了”“可以用了”。
- 检查失败后需要修复并复验。

## 不要用于

- 还没实现且已有计划；用 `build-it`。没有计划先回到 `write-spec` 或 `make-plan`。
- 失败原因未知；先用 `fix-bug`。
- 需要评审 diff 和交付说明；用 `review-it`。

## 输入

- 改动内容。
- 需求、规格或验收标准。
- 项目可用的验证方式。

## 操作

1. 列出验证矩阵：测试、构建、静态检查、手动验收、视觉检查等。
2. 运行与改动风险匹配的检查。
3. 阅读完整输出，不只看最后一行。
4. 分类失败：阻塞、相关非阻塞、无关已有问题。
5. 对相关失败进行修复，并重新运行对应检查。
6. 如果无法验证，说明原因和残余风险。
7. 只有在证据支持时，才能声明通过。

## Lab 运行时证明

当仓库属于 lab-ai 前后端工程体系,或发现项目已有 env/config、结构化日志、
JSONL/trace、真实后端探针时:

1. 先从项目代码和文档发现默认 dev endpoint / 环境配置,不要直接问用户 URL。
2. 普通测试链默认不打真实外网、真机、付费资源;真实探针必须显式 opt-in
   (如 `RUN_REAL_*_PROBE=true`),但可复用项目默认 dev endpoint。
3. 真实运行时证据要落脱敏产物,优先用项目既有目录,否则用 `build/prove_it/`:
   原始结构化日志/JSONL + 人可读 summary。
4. 优先使用仓库已有结构化日志、JSONL、trace tree 或契约链工具复盘链路;
   不要只贴控制台最后一行。
5. token、secret、cookie、Authorization、refresh token 原值不得写进日志、
   summary 或最终回复;只记录 `has_token`、`authorization_raw`、
   `has_bearer_prefix` 这类布尔证明。
6. 跳过真实探针时必须真正停止执行。Dart/Flutter 测试里
   `markTestSkipped(...)` 后要 `return;`。

## 红线

- 没有本轮新鲜验证证据，不能说完成、修好、通过、可用。
- 只跑了部分检查，就只能声明部分检查结果。
- 没读完整输出，等于没验证。
- 检查失败不能被总结成成功；必须分类、修复、复验或明确列为阻塞。

## 输出

- 验证矩阵。
- 实际运行的检查。
- 失败和分类。
- 修复记录。
- 复验结果。
- 残余风险。

## 停止条件

关键验证通过，或明确列出阻塞和未通过原因。

## 升级条件

- 失败原因不明：转 `fix-bug`。
- 验收标准缺失：回到 `write-spec` 或 `write-brief`。
- 发现交付风险：转 `review-it`。

## 成功证据

最终回复能列出具体检查名称、结果、失败处理和未覆盖风险。
