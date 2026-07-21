# spacemacs

个人 Spacemacs 配置：macOS 主力，原生 Emacs 键位（`dotspacemacs-editing-style 'emacs`），围绕 Go / Web / PHP / Python / Rust / Bash / C·C++ 的日常开发，加 Markdown / Org / PlantUML 的文档写作和 agent-shell 驱动的多 AI Agent 集成。

## 特点

- **模块化布局**：所有个人配置收敛在 `layers/personal/`，其中 `modules/` 按主题拆成 5 个小文件（mac / lsp / ui / writing / ai），加新功能只改一个文件
- **启动 ~1.3s**（M1 冷启动），关闭 spaceline 走 doom-modeline，GC 阈值调到 100 MB
- **direnv + envrc** 管每个项目的 Go/Node/Python 版本与环境变量，不再靠 `.dir-locals.el` 硬编码
- **agent-shell** 统一 UI 驱动 Claude Code / Codex / Gemini
- **OpenSpec** 管理配置的变更历史，见 `openspec/`

## 快速开始

```bash
# 1. clone 到 Spacemacs 私有目录
git clone <this-repo> ~/.spacemacs.d
# 或做软链
ln -s ~/spacemacs ~/.spacemacs.d

# 2. 装 Spacemacs 本体（develop 分支）
git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d

# 3. 系统依赖（macOS）
brew install direnv ripgrep coreutils
```

首次启动 Spacemacs 会自动装包，之后按 [docs/setup.md](docs/setup.md) 完成字体、CLI、Go/Node 等一次性配置。

## 文档

- [docs/setup.md](docs/setup.md) — 首次安装与依赖清单
- [docs/architecture.md](docs/architecture.md) — 分层与模块设计
- [docs/keybindings.md](docs/keybindings.md) — 快捷键速查
- [docs/troubleshooting.md](docs/troubleshooting.md) — 常见问题排查
- [layers/personal/README.org](layers/personal/README.org) — personal 私有层内部结构（Spacemacs 官方格式）
- [openspec/](openspec/) — 配置变更提案与规格

## 目录结构

```
.
├── init.el                       # dotspacemacs 主配置（Spacemacs 官方骨架）
├── layers/personal/                  # 个人私有层
│   ├── config.el                 # 聚合器，按序 require 五个模块
│   ├── keybindings.el            # 全局键位
│   ├── funcs.el                  # 复用函数
│   ├── packages.el / layers.el   # 声明包与官方层
│   └── modules/
│       ├── personal-mac.el           # macOS PATH / TRAMP / direnv
│       ├── personal-lsp.el           # lsp-mode / gopls / projectile
│       ├── personal-ui.el            # doom-modeline / 字体 / dired / yas
│       ├── personal-writing.el       # markdown / org / plantuml
│       └── personal-ai.el            # agent-shell
├── snippets/                     # yasnippet 用户片段
├── local/                        # tracked 资源及 ignored 用户设置
├── docs/                         # 本项目文档
└── openspec/                     # 变更管理
```

## License

配置代码遵循 GPLv3（与 Spacemacs 一致）。
