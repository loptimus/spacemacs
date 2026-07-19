# 常见问题排查

## 启动阶段

### `Cannot open load file: liwl-mac`（或其他 liwl 模块）

**原因**：`layers/liwl/modules/` 不在 `load-path`，或文件名与 `provide` 特性名不一致。

**排查**：
1. 确认文件名是 `liwl-mac.el`，不是 `mac.el`（Emacs `require 'liwl-mac` 会查找 `liwl-mac.el`）
2. 看 `*Messages*` 顶部有没有 `[liwl] loading modules from …` 这一行，路径对不对
3. `M-: load-path RET` 检查 `modules/` 是否在里面

### GUI 里 `M-: (getenv "PATH")` 缺 brew/gvm 路径

Finder/Dock 启的 GUI Emacs 只继承 launchd 的极简环境。修复：
- 确认 `exec-path-from-shell` 装了：`M-: (fboundp 'exec-path-from-shell-initialize)` → `t`
- `.zshrc`（不是 `.zshenv`）里有对应版本管理器的 init 语句
- 重启 Emacs（首次 `exec-path-from-shell-initialize` 才生效）

### `M-x emacs-init-time` > 3s

- 检查 `*Messages*` 里是否有反复的网络请求（quelpa 拉 git 仓库）
- 关掉暂时不用的 layer
- 检查 `gc-cons-threshold` 是不是被覆盖回默认 800KB

## LSP

### `wrong-type-argument hash-table-p` 报错

**原因**：`LSP_USE_PLISTS` 的 env 值与 lsp-mode 的 `.elc` 字节编译时状态不一致。

**修复**：确保 env 处处一致，然后重编译所有 lsp 包：

```bash
export LSP_USE_PLISTS=true
EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs
for pkg in lsp-mode lsp-ui lsp-ivy lsp-origami lsp-treemacs; do
  dir=$(ls -d ~/.emacs.d/elpa/*/develop/${pkg}-* 2>/dev/null | head -1)
  [ -z "$dir" ] && continue
  "$EMACS" --batch \
    --eval "(setenv \"LSP_USE_PLISTS\" \"true\")" \
    --eval "(setq package-user-dir \"$HOME/.emacs.d/elpa/30.2/develop\")" \
    --eval "(require 'package)" --eval "(package-initialize)" \
    -f batch-byte-compile "$dir"/*.el
done
```

### `invalid GOSUMDB: malformed verifier id`

**原因**：`GOSUMDB` 只接受 `off` / `sum.golang.org` / `<name>+<hash>[+url]` 三种值。写成 domain 通配（那个是 `GOPRIVATE` 的语法）会报这个错。

**修复**：`.envrc` 或 dir-locals 里改成 `export GOSUMDB=off`（私有 module 场景推荐）。

### `verifying module: checksum database disabled by GOSUMDB=off`

**原因**：`go.mod` 里 `go 1.24`，本机 go 是 1.21 → Go 自动下载 toolchain → toolchain 下载要求非 off 的 GOSUMDB。

**修复**：装匹配版本的 Go（`gvm install go1.24.13`）并在 `.envrc` 里把 PATH 指过去，不再触发 toolchain 下载。

## direnv / envrc

### mode line 没有 `Envrc[+]`

1. `M-: (featurep 'envrc) RET` → `nil` 说明包没装或 hook 没挂
2. 检查 `liwl-mac.el` 里是 `(add-hook 'prog-mode-hook #'envrc-mode)`，**不要**包 `with-eval-after-load 'envrc`（envrc 是 lazy-load，包一层会永不触发）
3. `M-x envrc-mode` 手动开一次；若报错说 direnv 未装 → `brew install direnv`

### `command not found: go`（在 Emacs 起子进程时）

`.envrc` 没被 `direnv allow`。在终端里：

```bash
cd <project-dir>
direnv allow
```

然后在 Emacs 里 `M-x revert-buffer` 或重开文件。

### `.envrc` 修改后没生效

- 终端里再跑一次 `direnv allow`
- Emacs 里 `M-x envrc-reload-all`

## doom-modeline

### mode line 显示豆腐块 / 乱码

字体没装。跑 `M-x nerd-icons-install-fonts`，然后**完全退出**再启动 Emacs（`restart-emacs` 不行，字体缓存要重建）。

之前误装的 all-the-icons 字体可以删掉：

```bash
rm ~/Library/Fonts/{all-the-icons,fontawesome,file-icons,material-design-icons,octicons,weathericons}.ttf
```

## agent-shell

### `M-x agent-shell` 弹出的是 "Start new agent" 输入框

那是通用启动器，正常行为。要直接起预配置的 agent：

- `SPC a c` → Claude Code
- `SPC a x` → Codex
- `SPC a g` → Gemini
- 或 `M-x agent-shell-anthropic-start-claude-code` 等

### `(length agent-shell-agent-configs)` 为 0

之前 `liwl-ai.el` 里的 filter 匹配错了。当前版本已删除过滤，保留 agent-shell 的默认配置。

### `SPC a c` 报找不到 CLI

装对应的 npm 包：

```bash
npm i -g @zed-industries/claude-code-acp
npm i -g @agentclientprotocol/codex-acp
```

## 其他

### `[yas] Check your yas-snippet-dirs: /Users/lwl/.spacemacs.d/snippets is not a directory`

建目录即可：

```bash
mkdir -p ~/.spacemacs.d/snippets
```

### 旧 gopls 进程一直不退

多个 Emacs session 会各起一个 gopls。清理：

```bash
pkill -f gopls
```
