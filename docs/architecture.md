# 架构

## 分层原则

- `init.el` **只放 Spacemacs 官方骨架**：`dotspacemacs/init`（进程级设置）、`dotspacemacs-configuration-layers`、`dotspacemacs-additional-packages`、`dotspacemacs/user-init`、`dotspacemacs/user-config` 等固定入口
- `dotspacemacs/user-config` 函数体几乎为空 —— 所有逻辑迁到 `layers/personal/`
- `layers/personal/` 是 Spacemacs 私有层，被 `dotspacemacs-configuration-layers` 引用
- `layers/personal/config.el` 是**聚合器**，按顺序 `require` `modules/` 下的主题模块，不写业务逻辑
- 每个主题模块只管一件事，文件名带 `personal-` 前缀避免命名冲突（Emacs `require` 要求文件名与 `provide` 特性名一致）

## 加载顺序

```
init.el
  └─ layers/personal/config.el
       ├─ (require 'personal-mac)      ← 最先：让 shell PATH 就位，LSP server 才能被找到
       ├─ (require 'personal-lsp)      ← 语言层唤醒前调好 LSP / GC / projectile
       ├─ (require 'personal-ui)       ← doom-modeline 依赖 LSP 状态显示
       ├─ (require 'personal-writing)  ← markdown / org / plantuml
       ├─ (require 'personal-ai)       ← agent-shell 加载失败也不阻塞启动
       └─ (require 'personal-erlang)   ← 注册 ELP client，优先于 erlang_ls
```

## 模块职责

| 模块 | 职责 |
|-----|-----|
| `personal-mac.el` | macOS `exec-path-from-shell` 初始化、TRAMP 优化、direnv/envrc 注册到 `prog-mode-hook` |
| `personal-lsp.el` | `LSP_USE_PLISTS` env、GC 阈值、`read-process-output-max`、`lsp-mode` / `lsp-ui` / `gopls` / `projectile` 调参 |
| `personal-ui.el` | `display-time`、`mouse-avoidance-mode`、`indent-tabs-mode`、`prog-mode-hook` 的 `fill-column`、dired、yasnippet 目录、doom-modeline |
| `personal-writing.el` | markdown pandoc、org 导出、org-babel、`ox-latex` ctexart 中文导出、`plantuml-jar-path` |
| `personal-ai.el` | `agent-shell` 延迟加载、defensive 包裹避免阻塞启动 |
| `personal-erlang.el` | 注册 ELP client，使用 lsp-mode 提供 Erlang IDE 能力 |

## 加新模块

1. 在 `layers/personal/modules/` 建 `personal-<topic>.el`，结尾 `(provide 'personal-<topic>)`
2. `layers/personal/config.el` 里追加一行 `(require 'personal-<topic>)`，位置按依赖关系放
3. 重启 Emacs，不需要动 `init.el`

## 关键设计决策

**为什么不用 Doom Emacs？**
Spacemacs 的 layer 生态和自定义空间已经稳定十年，切换 Doom 意味着重学配置模型。收益不足以覆盖迁移成本。

**为什么关掉 spaceline 换 doom-modeline？**
spaceline 依赖 powerline，图形化分隔符渲染不稳；doom-modeline 用 nerd-icons，性能更好、外观更现代。

**为什么用 direnv + envrc 而不是 dir-locals？**
dir-locals 只在 Emacs 内生效，终端里 `go build` 拿不到相同环境；`.envrc` 是唯一真相，Emacs（通过 envrc）和终端（通过 direnv）都读同一份文件。

**为什么 agent-shell 而不是 gptel / copilot.el？**
需要多 agent（Claude Code / Codex / Gemini）统一入口；agent-shell 基于 ACP 协议，天然支持所有 ACP 兼容 CLI。

**为什么 LSP_USE_PLISTS？**
lsp-mode 的 plists 反序列化比 hash-table 快 20% 左右。代价：所有 lsp-* 包必须在同一 env 下字节编译才不会出 `wrong-type-argument hash-table-p` 错误。

## OpenSpec

配置层面的重构走 [OpenSpec](https://github.com/xenodium/openspec)（不是这个 xenodium，是通用规格工具）流程：

```
openspec/
├── specs/          # 主规格（每个 capability 一份）
└── changes/
    └── archive/    # 已完成的变更（proposal + design + tasks + delta specs）
```

新变更用 `/opsx:propose` 或 `/opsx:ff` 创建，`/opsx:apply` 实施，`/opsx:archive` 归档。
