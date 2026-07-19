;;; keybindings.el --- Global key bindings for liwl layer -*- lexical-binding: t -*-

;; Help / info
(global-set-key (kbd "<f1>")   'manual-entry)
(global-set-key (kbd "S-<f1>") 'info)

;; Search
(global-set-key (kbd "C-6")   'grep-find)
(global-set-key (kbd "C-S-f") 'counsel-rg)
(global-set-key (kbd "<f5>")  'projectile-find-file)

;; Mark
(global-set-key (kbd "M-SPC") 'set-mark-command)

;; Read-only toggle
(global-set-key (kbd "<f3>") 'read-only-mode)

;; Line copy
(global-set-key (kbd "C-c w") 'copy-lines)

;; File path copy
(global-set-key (kbd "C-c p") 'copy-file-path-with-line)
(global-set-key (kbd "C-c P") 'copy-relative-file-path-with-line)

;; Bookmarks
(global-set-key (kbd "M-8")     'list-bookmarks)
(global-set-key (kbd "<f2>")    'bookmark-set)
(global-set-key (kbd "S-<f2>")  'bookmark-jump)
(global-set-key (kbd "M-<f2>")  'bookmark-delete)

;; GDB
(global-set-key (kbd "C-4") 'gdb)

;; Window movement
(global-set-key [M-left]  'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up]    'windmove-up)
(global-set-key [M-down]  'windmove-down)

;; Tool-bar toggle for debugging
(global-set-key (kbd "C-9") 'tool-bar-mode)

;; Undo-tree helper (invoked from modules if desired)
(defun undo-tree-keymap ()
  "Bind undo-tree keys."
  (global-set-key (kbd "C-z")   'undo-tree-undo)
  (global-set-key (kbd "C-M-z") 'undo-tree-redo))

;; ace-jump: register lazy-loaded bindings
(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back" t)
(with-eval-after-load 'ace-jump-mode
  (ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
(define-key global-map (kbd "C-;")     'ace-jump-mode)

;; AI agent leader (SPC a *) — registered when agent-shell is available.
(with-eval-after-load 'agent-shell
  (spacemacs/declare-prefix "a" "ai")
  (spacemacs/set-leader-keys
    "aa" 'agent-shell
    "ac" 'agent-shell-anthropic-start-claude-code
    "ax" 'agent-shell-openai-start-codex
    "ag" 'agent-shell-google-start-gemini))

;;; keybindings.el ends here
