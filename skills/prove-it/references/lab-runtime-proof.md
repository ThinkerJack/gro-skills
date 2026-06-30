# Lab Runtime Proof

用于 lab-ai 体系内项目的真实运行时验证。项目具体 URL、接口路径、bundle id
留在项目仓库;本文件只规定验证形态。

## 分层

1. Backend smoke:直连真实 dev endpoint,只输出 HTTP 状态和字段存在性。
2. Code probe:用项目代码路径(repository/client/interceptor/store)接真实 endpoint,
   生成脱敏 JSONL/summary。默认跳过,显式开关才打外网。
3. App/runtime probe:在模拟器、真机或实际进程跑应用启动链路,读取应用落盘的
   结构化日志或 JSONL,再用项目 trace 工具复盘。

## 产物

- `build/prove_it/<feature>_<scenario>.jsonl`
- `build/prove_it/<feature>_<scenario>_summary.json`

summary 只放状态、字段存在性、布尔证明和非敏感业务状态;不得放 token 原文。

## Flutter/Dart 常见形态

- 先查 `EnvConfig`、`README`、生成脚本和测试探针里的默认 dev endpoint。
- 真实测试使用 `--dart-define=RUN_REAL_*_PROBE=true` 开启。
- dev endpoint 可有项目默认值;prod endpoint 必须显式注入。
- `markTestSkipped(...)` 后必须 `return;`。
- 如果有 JSONL/trace tree,最终用工具读产物证明链路,不要只依赖控制台日志。
