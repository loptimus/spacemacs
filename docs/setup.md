# 首次安装

按顺序完成。全部完成后 `M-x emacs-init-time` 应在 2s 内。

## 1. Spacemacs 本体

```bash
git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d
```

## 2. 配置目录

把本仓库放到 `~/.spacemacs.d`（Spacemacs 会自动加载 `~/.spacemacs.d/init.el`）：

```bash
# 方式 A：clone
git clone <this-repo> ~/.spacemacs.d

# 方式 B：软链（本仓库在别处）
ln -s ~/spacemacs ~/.spacemacs.d
```

## 3. 本机变量

需要个人目录或非标准工具路径时，创建 Git 忽略的本机设置文件：

```bash
cp local/user-settings.example.el local/user-settings.el
```

该文件在所有 layer 之前加载，目前支持 `personal-org-agenda-files`。工具能从
shell `PATH` 找到时不要设置安装路径；项目专属环境放在项目的 `.envrc`。

## 4. 系统依赖（macOS）

```bash
brew install direnv ripgrep coreutils go rust node python shellcheck shfmt
npm i -g pyright

curl -L -o /tmp/elp.tar.gz \
  https://github.com/WhatsApp/erlang-language-platform/releases/latest/download/elp-macos-aarch64-apple-darwin-otp-28.tar.gz
tar -xzf /tmp/elp.tar.gz -C /tmp
sudo mv /tmp/elp /opt/homebrew/bin/elp

elp version
pyright --version
shellcheck --version
shfmt --version

# 可选：多版本管理器（推荐）
brew install gvm nvm pyenv
```

`direnv` 是必需，`envrc` 靠它注入项目环境。`ripgrep` 是 `C-S-f` 的项目搜索后端。
ELP 的 release 需与本机架构和 OTP 主版本匹配；上例适用于 Apple Silicon + OTP 28。

Erlang 活节点交互不再使用 distel。本地交互可运行 `M-x erlang-shell`；连接远端节点
使用终端 `erl -remsh <node>`。

## 5. Shell 环境

`~/.zshenv`（不是 `.zshrc`）里 export 你希望 GUI Emacs 也能看到的变量：

```sh
export LSP_USE_PLISTS=true
export EMACS_PATH="/Applications/Emacs.app/Contents/MacOS"
```

其他 `PATH` 相关（gvm / nvm / pyenv 的 init）留在 `.zshrc` 即可，Emacs 里的 `exec-path-from-shell` 会启动一个 `zsh -l -i` 抓走。

## 6. 首次启动

启动 Emacs，Spacemacs 会自动装 `dotspacemacs-additional-packages` 里声明的包（含 `doom-modeline` / `envrc` / `agent-shell` / `acp` / `shell-maker` 等）。

## 7. 字体（一次性）

`doom-modeline` 依赖 nerd-icons：

```
M-x nerd-icons-install-fonts
```

装完**完全退出** Emacs 再启动（不是 `restart-emacs`，字体缓存要重建），mode line 图标就正常了。

## 8. AI Agent CLI（一次性）

```bash
npm i -g @zed-industries/claude-code-acp
npm i -g @agentclientprotocol/codex-acp
# gemini CLI 按 Google 文档装，确认支持 --experimental-acp
```

装完在 Emacs 里 `SPC a c` / `SPC a x` / `SPC a g` 分别启动 Claude Code / Codex / Gemini。

## 9. direnv 授权

对每个用 `.envrc` 的项目，第一次需要在**终端**里执行一次 `direnv allow` 才生效：

```bash
cd ~/workspace/projects/your-project
direnv allow
```

## 10. 验证清单

在 Finder / Dock 里启动 Emacs（不要从终端），跑：

```elisp
M-: (getenv "PATH") RET               ;; 应含 brew、gvm、nvm、pyenv
M-: (executable-find "go") RET        ;; 应指向 gvm 当前 default 的 go
M-x emacs-init-time                    ;; 应 < 2s
M-x nerd-icons-install-fonts           ;; 只需要跑一次
M-x agent-shell RET                    ;; 应弹出 agent 输入框
```

打开一个 `.envrc` 目录下的 `.go` 文件，mode line 应出现绿色的 `Envrc[+]`；`M-.` 应走 lsp 跳转。
