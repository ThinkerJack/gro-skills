# Gro Skills

AI coding skills for clearer plans, safer changes, and verified delivery.

Gro Skills 是一组给 AI 编程用的阶段契约。它不教模型通用思考方法，而是说清你的工作流中每个阶段何时进入、要交付什么、如何证明完成，以及什么时候必须停止。

这 13 个 skill 不是 13 个必经步骤。任务可以从当前风险对应的任意阶段进入，跳过没有产生额外价值的上游产物。

主流程：

```text
set-goal -> write-brief -> make-design -> write-spec -> make-plan -> build-it -> prove-it -> review-it
```

其他角色：

```text
跨阶段：find-proof  poke-holes（仅显式触发）
异常分支：fix-bug
显式动作：commit-it  save-lesson
```

当前结构：

- `skills/` - 通用路径 skill，跨项目适用。
- `docs/` - 公开介绍文档和 HTML 视图。

核心规则：skills 只保留目标、产物、完成证据、权限和防漂移边界；具体项目规则留在使用方仓库。模型大版本升级后，用固定 eval 重新判断哪些指令仍必要、已冗余或可能有害。

关键工程路径使用“关键路径验证”：按风险定义证据层级、状态准备、清理动作和
`通过 / 失败 / 部分验证 / 阻塞`结论。

## 当前文档

- [Gro Skills System](docs/README.md)
- [Gro Skills System Map](docs/gro-skills-system-v1.html)

## 接入方式

推荐方式是：**本地 clone 一份 Gro Skills，再由 AI 运行仓库提供的同步脚本建立 skill 软链接**。已有 skill 的内容会随源仓库更新；新增 skill 由脚本补齐，失效链接由脚本报告给 AI 处理。不要复制文件。

接入规则：

1. 优先用软链引用 `gro-skills/skills`，不要复制一份。
2. 优先接入到 `.agents/skills`；如果当前 AI 工具只识别特定 skill 目录，再额外接入对应目录。
3. 如果当前工具不支持可执行 skill，再把工作流写进 `AGENTS.md` / `CLAUDE.md`，作为降级方案。
4. 接入后要验证当前 AI 是否能识别或触发这些 skills。
5. 接入完成后说明：接入方式、文件改动、如何使用、如何更新。

不要把 `docs/references` 或本地草稿资料接入项目；也不要把项目私有规则写回 Gro Skills，项目规则应留在使用方仓库。

### 1. Clone

```bash
mkdir -p ~/tools
git clone https://github.com/ThinkerJack/gro-skills ~/tools/gro-skills
```

如果你想维护自己的版本，再先 fork；只是使用的话不需要 fork。

### 2. 接入项目

让 AI 从 Gro Skills 仓库运行：

```bash
./scripts/sync-project-skills.sh /absolute/path/to/project
```

脚本默认同步 `.agents/skills/`。正确链接保持不变；项目自有的同名文件、目录或指向其他来源的链接会被跳过；指向本仓库但已失效的链接只报告 `STALE`，不自动删除。

如果项目还使用 Claude Code，AI 必须加 `--claude`，同时同步 `.agents/skills/` 和 `.claude/skills/`：

```bash
./scripts/sync-project-skills.sh --claude /absolute/path/to/project
```

项目自有 skill（例如 Gro 的 `research`）继续留在项目仓库，不回写或覆盖到 Gro Skills。AI 运行后要检查 `created`、`skipped`、`stale`，验证新增链接的 `SKILL.md` 可读，并向用户说明需要人工判断的冲突或失效链接。

个人全局使用时，也可以把 skills 链到你的 AI 工具全局 skills 目录。具体路径以工具文档为准。

### 3. 验证

接入后，让你的 AI 做一次检查：

```text
请检查当前项目是否能看到 Gro Skills，并列出可用 skill。
```

也可以直接测试一个 skill：

```text
请使用 set-goal 帮我澄清这个需求：我要给项目加一个新功能。
```

如果 AI 能按“定目标、成功标准、未知项、下一步”的结构回答，说明接入基本可用。

### 4. 更新

更新 Gro Skills 后，由 AI 拉取并重新运行同步脚本：

```bash
cd ~/tools/gro-skills
git pull
./scripts/sync-project-skills.sh --claude /absolute/path/to/project
```

`git pull` 会立即更新已有链接指向的内容，但不会自行创建新入口；因此 AI 不能只执行 `git pull`。`STALE` 链接可能涉及项目选择，AI 只能说明并在获得授权后删除。

不推荐把 `skills/` 复制到每个项目里；复制后需要手动同步，容易漂移。

### 5. 降级方案

如果当前 AI 工具不支持可执行 skill，可以把 Gro Skills 的工作路径写进项目的 `AGENTS.md` / `CLAUDE.md` / AI 使用说明里。

这是降级方案：它能提供流程提醒，但不如可触发 skill 稳定。

## 给 AI 的接入提示词

把下面这段发给 AI，让它帮忙接入当前项目：

```text
请帮我接入 Gro Skills 这套 AI coding skill 体系。

仓库地址：
https://github.com/ThinkerJack/gro-skills

请先 clone 或打开这个仓库，阅读 README.md，并按 README 的推荐方式把 Gro Skills 接入当前项目。

由你执行接入，不要求我手动同步：从 Gro Skills 仓库运行 `./scripts/sync-project-skills.sh /当前项目绝对路径`；项目使用 Claude Code 时加 `--claude`。不要复制文件或覆盖项目自有同名 skill。检查脚本的 `created`、`skipped`、`stale`，验证新增链接的 `SKILL.md` 可读，并列出需要人工处理的冲突或失效链接。
```
