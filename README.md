# Gro Skills

AI coding skills for clearer plans, safer changes, and verified delivery.

Gro Skills 是一组给 AI 编程用的阶段契约。它不教模型通用思考方法，而是说清你的工作流中每个阶段何时进入、要交付什么、如何证明完成，以及什么时候必须停止。

12 个 skill 分两层。**动作由你敲出来，纪律自动生效**——这个划分是关键：自动跑完的流程你感知不到，也就谈不上控制。

只有三个保持自动：它们要么需要被别的 skill 调用（`interviewing`、`find-proof`），要么触发时机由现象决定而非由你决定（`fix-bug`）。

```text
控制点（手动触发，不占自动路由）
  make-sketch   一屏内确认方向
  write-spec    把多个信息源固化成规格真源
  make-plan     把测试和验收绑进完成定义
  build-it      按计划落地；参数 worktree / auto
  prove-it      四态结论：通过 / 失败 / 部分验证 / 阻塞
  review-it     交付前评审 diff
  commit-it     分组提交；参数 done 表示推送并合并回基线
  sharpen-it    反驳、补角度、追问、换维度
  save-lesson   沉淀经验，并记录 skill 自身的摩擦

自动触发（模型自行判断时机，也可被其他 skill 调用）
  interviewing  追问到共识
  find-proof    为决策取证
  fix-bug       定位根因再修
```

任务从当前风险对应的位置进入，跳过没有额外价值的上游产物。轻量改动直接做，不必先画草图。

当前结构：

- `skills/` — 通用 skill，跨项目适用
- `skills-deprecated/` — 已降级，不进任何项目
- `docs/` — 公开文档与迭代决策链

核心规则：skill 只保留目标、产物、完成证据、权限和防漂移边界；具体项目规则留在使用方仓库的 `references/` 里。写指令前先问一句——**这句话相对模型默认行为改变了什么？** 没有就删掉。

关键工程路径使用「关键路径验证」：按风险定义证据层级、状态准备、清理动作和
`通过 / 失败 / 部分验证 / 阻塞`结论。

## 当前文档

- [Gro Skills System](docs/README.md)
- [Gro Skills System Map](docs/gro-skills-system-v1.html)

## 接入方式

推荐方式是：**本地 clone 一份 Gro Skills，再运行 `scripts/sync.py` 把 skill 生成到项目里**。产出的是真实文件，可以提交进项目仓库——同事 clone 即用，不需要各自安装 Gro Skills。

> 2026-07 起改用生成式同步，取代原来的软链方案。软链存的是绝对路径，提交后在别人机器上是死链；生成式还多出一层项目适配能力（见下）。旧的 `scripts/sync-project-skills.sh` 已废弃。

每个 skill 有两种模式，在项目根的 `.gro-skills.json` 里声明：

| 模式 | 行为 | 用于 |
|---|---|---|
| `mirror` | 整目录逐字覆盖 | 纯通用纪律，项目无需干预 |
| `adapter` | 项目保留 `SKILL.md` 薄壳和自己的 `references/*.md`，只覆盖生成的 `references/common.md` 和上游资源 | 需要项目落地细节：文档路径、验证命令、技术栈约定 |

adapter 的目录形态：

```
.agents/skills/build-it/
├── SKILL.md                     项目薄壳：读 common → 读项目经验 → 冲突时以就近 AGENTS.md 为准
└── references/
    ├── common.md                Gro Skills 原文（生成，带 blob 追溯，勿改）
    └── <repo>-delivery.md       项目经验（手写，同步时永不覆盖）
```

接入规则：

1. 用 `scripts/sync.py` 生成，不要手工复制，也不要再建软链。
2. 默认生成到 `.agents/skills`，脚本会顺带建 `.claude/skills -> ../.agents/skills` 相对软链，Claude Code 和 Codex 同时可用。
3. 没有项目特定经验时全部用 `mirror`；等真积累出经验，再把对应 skill 改成 `adapter` 并手写薄壳。
4. adapter 的 `SKILL.md` 必须人写，脚本拒绝代为生成。
5. 如果当前工具不支持可执行 skill，再把工作流写进 `AGENTS.md` / `CLAUDE.md`，作为降级方案。
6. 接入后要验证当前 AI 是否能识别或触发这些 skills。

不要把 `docs/references` 或本地草稿资料接入项目；也不要把项目私有规则写回 Gro Skills，项目规则应留在使用方仓库。

### 1. Clone

```bash
mkdir -p ~/Documents/GitHub/gro
git clone https://github.com/ThinkerJack/gro-skills ~/Documents/GitHub/gro/gro-skills
```

如果你想维护自己的版本，再先 fork；只是使用的话不需要 fork。

### 2. 接入项目

在项目根写一份 `.gro-skills.json`：

```json
{
  "destination": ".agents/skills",
  "claudeLink": true,
  "mirror": ["find-proof", "fix-bug", "interviewing", "sharpen-it"],
  "adapter": ["build-it", "make-sketch", "prove-it", "write-spec"]
}
```

然后从 Gro Skills 仓库运行：

```bash
python3 scripts/sync.py /absolute/path/to/project           # 同步
python3 scripts/sync.py /absolute/path/to/project --check    # 只检查，有漂移则非零退出
```

脚本会拒绝在 Gro Skills 有未提交 skill 改动时同步——否则 manifest 记录的 `sourceBlob`（工作区）和 `sourceRevision`（HEAD）会自相矛盾，把半成品散播到所有下游。确需如此时加 `--allow-dirty`。

同步产物包含 `.gro-skills-sync.json`，记录上游 revision 和每个 skill 的 blob，用于精确定位漂移。

项目自有 skill（例如 Gro Research 的 `research`）不写进名单即可，脚本不会碰它。

### 3. 防漂移

生成式的代价是更新不自动。装上 hook，并定期全量检查：

```bash
./scripts/install-hooks.sh      # gro-skills 改动 skills/ 后提醒同步下游
./scripts/check-all.sh          # 扫描所有下游仓库，报告漂移
./scripts/check-all.sh --sync   # 直接修复
```

这一步不要省：改用生成式之前，曾有仓库静默漂移两周（`poke-holes` 停在旧版），原因就是没有任何东西会主动跑 `--check`。

### 4. 验证

接入后，让你的 AI 做一次检查：

```text
请检查当前项目是否能看到 Gro Skills，并列出可用 skill。
```

也可以直接测试一个 skill：

```text
请用 make-sketch 帮我理一下：我要给项目加一个新功能。
```

如果 AI 能给出「问题 / 改动面 / 2-3 个方案加推荐 / 非目标 / 未知」的一屏草图，说明接入可用。

### 5. 更新

```bash
cd ~/Documents/GitHub/gro/gro-skills
git pull
./scripts/check-all.sh --sync      # 一次性把所有下游仓库带到最新
```

`git pull` 只更新 Gro Skills 本身，下游是生成产物、不会自动跟随——这正是要装 hook 和跑 `check-all.sh` 的原因。

adapter 的项目经验文件（`references/` 下非 `common.md` 的部分）在任何情况下都不会被覆盖。

### 6. 降级方案

如果当前 AI 工具不支持可执行 skill，可以把 Gro Skills 的工作路径写进项目的 `AGENTS.md` / `CLAUDE.md` / AI 使用说明里。

这是降级方案：它能提供流程提醒，但不如可触发 skill 稳定。

## 给 AI 的接入提示词

把下面这段发给 AI，让它帮忙接入当前项目：

```text
请帮我接入 Gro Skills 这套 AI coding skill 体系。

仓库地址：
https://github.com/ThinkerJack/gro-skills

请先 clone 或打开这个仓库，阅读 README.md，并按 README 的推荐方式把 Gro Skills 接入当前项目。

由你执行接入，不要求我手动操作：

1. 在我的项目根写 `.gro-skills.json`。没有项目特定经验时全部列进 `mirror`。
2. 从 Gro Skills 仓库运行 `python3 scripts/sync.py /当前项目绝对路径`。
3. 用 `--check` 复验，确认输出 `in sync`。
4. 告诉我生成了哪些文件、要不要提交进项目仓库、以后怎么更新。

不要手工复制文件，不要建软链，不要覆盖项目自有的同名 skill。
```
