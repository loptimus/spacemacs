# 快捷键

`dotspacemacs-editing-style` 设为 `emacs`，所有键位都是 Emacs 原生风格，不启用 evil。

## 全局

### 帮助 / 信息

| 键位 | 命令 |
|-----|-----|
| `<f1>` | `manual-entry` |
| `S-<f1>` | `info` |

### 搜索

| 键位 | 命令 | 说明 |
|-----|-----|-----|
| `C-6` | `grep-find` | |
| `C-S-f` | `counsel-rg` | 项目全局 ripgrep |
| `<f5>` | `projectile-find-file` | |

### 编辑

| 键位 | 命令 |
|-----|-----|
| `M-SPC` | `set-mark-command` |
| `<f3>` | `read-only-mode` |
| `C-c w` | `copy-lines`（复制当前行到 kill ring）|
| `C-c p` | `copy-file-path-with-line`（绝对路径 + 行号）|
| `C-c P` | `copy-relative-file-path-with-line`（项目相对路径 + 行号）|

### 书签

| 键位 | 命令 |
|-----|-----|
| `M-8` | `list-bookmarks` |
| `<f2>` | `bookmark-set` |
| `S-<f2>` | `bookmark-jump` |
| `M-<f2>` | `bookmark-delete` |

### 调试

| 键位 | 命令 |
|-----|-----|
| `C-4` | `gdb` |
| `C-9` | `tool-bar-mode`（切换 toolbar）|

### 窗口移动

| 键位 | 命令 |
|-----|-----|
| `M-<left>` | `windmove-left` |
| `M-<right>` | `windmove-right` |
| `M-<up>` | `windmove-up` |
| `M-<down>` | `windmove-down` |

### 跳转（ace-jump）

| 键位 | 命令 |
|-----|-----|
| `C-;` | `ace-jump-mode` |
| `C-x SPC` | `ace-jump-mode-pop-mark`（跳回）|

### Undo Tree

| 键位 | 命令 |
|-----|-----|
| `C-z` | `undo-tree-undo`（通过 `undo-tree-keymap` 函数注册后生效）|
| `C-M-z` | `undo-tree-redo` |

## AI Agent（`SPC a *`）

| 键位 | 命令 | 说明 |
|-----|-----|-----|
| `SPC a a` | `agent-shell` | 通用启动器，可输入任意 agent 命令 |
| `SPC a c` | `agent-shell-anthropic-start-claude-code` | Claude Code |
| `SPC a x` | `agent-shell-openai-start-codex` | Codex |
| `SPC a g` | `agent-shell-google-start-gemini` | Gemini |

## LSP（`SPC m *` / 常用 M- 键）

沿用 Spacemacs `lsp` 层默认键位，未额外覆盖。常用：

| 键位 | 命令 |
|-----|-----|
| `M-.` | `xref-find-definitions`（走 lsp）|
| `M-,` | `xref-pop-marker-stack`（跳回）|
| `M-?` | `xref-find-references` |
| `SPC m g g` | `lsp-find-definition` |
| `SPC m g r` | `lsp-find-references` |
| `SPC m r r` | `lsp-rename` |
| `SPC m a a` | `lsp-execute-code-action` |

## 添加新键位

在 `layers/liwl/keybindings.el` 里加。全局键用 `global-set-key`；带 leader 前缀的用 Spacemacs 的 `spacemacs/set-leader-keys`。

例如给 leader `SPC o t` 绑一个自定义命令：

```elisp
(spacemacs/declare-prefix "o" "own")
(spacemacs/set-leader-keys "ot" 'my-command)
```
