# Gro Skills

AI coding skills for clearer plans, safer changes, and verified delivery.

Gro Skills 是一组给 AI 编程用的技能。它的作用是把一次 AI 编程任务拆成更清楚的关键阶段：先确认目标和边界，再补齐证据和规格，然后拆计划、实现、验证、评审，最后把经验沉淀下来。

这样用 AI 写代码时，就不只是把需求丢给它生成代码，而是让它按一个更接近真实工程协作的流程推进：知道什么时候该问清楚，什么时候该查依据，什么时候该停下来验证，什么时候该把规则写回项目。

工作路径：

```text
定目标 -> 挑毛病 -> 找证据 -> 写需求 -> 做设计 -> 写规格
-> 拆计划 -> 开始做 -> 修问题 -> 验证它 -> 做评审 -> 记经验
```

包含的 skills：

```text
set-goal     poke-holes   find-proof    write-brief
make-design  write-spec   make-plan     build-it
fix-bug      prove-it     review-it     save-lesson
```

当前结构：

- `skills/` - 通用路径 skill，跨项目适用。
- `docs/` - 公开介绍文档和 HTML 视图。

核心规则：skills 保持短小、通用、可执行；具体项目规则放在使用方仓库里。

## 当前文档

- [Gro Skills System](docs/README.md)
- [Gro Skills System v0.1 HTML](docs/gro-skills-system-v1.html)

## 接入方式

推荐方式是：**本地 clone 一份 Gro Skills，然后在项目里用软链引用 `skills/`**。这样后续更新只需要 `git pull`，不用在每个项目里复制一份。

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

进入你的项目根目录：

```bash
mkdir -p .agents/skills
for skill in ~/tools/gro-skills/skills/*; do
  ln -sfn "$skill" ".agents/skills/$(basename "$skill")"
done
```

`.agents/skills` 适合作为跨 AI 工具的共享目录。

如果你的工具只识别特定目录，再从同一份 `~/tools/gro-skills/skills` 软链过去：

```bash
# Claude Code 项目级 skills
mkdir -p .claude/skills
for skill in ~/tools/gro-skills/skills/*; do
  ln -sfn "$skill" ".claude/skills/$(basename "$skill")"
done
```

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

如果使用软链，更新 Gro Skills 只需要：

```bash
cd ~/tools/gro-skills
git pull
```

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
```
