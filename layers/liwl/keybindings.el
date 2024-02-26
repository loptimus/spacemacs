
(global-set-key (kbd "<f1>") 'manual-entry)

; 显示Emacs info
(global-set-key (kbd "S-<f1>") 'info)

; f3为查找字符串
(global-set-key (kbd "C-6") 'grep-find)

; Mark set
(global-set-key (kbd "M-SPC")  'set-mark-command)

; 只读开关
(global-set-key (kbd "<f3>")  'read-only-mode)
;; (global-set-key (kbd "<f4>")  'helm-do-ag-project-root)
(global-set-key (kbd "<f4>")  'counsel-ag)
(global-set-key (kbd "<f5>")  'projectile-find-file)

;; 行复制
(global-set-key (kbd "C-c w") 'copy-lines)
; (global-set-key (kbd "C-c w") 'evil-copy)

; Etags jump back
(global-set-key (kbd "M-[") 'find-tag)
(global-set-key (kbd "M-]") 'pop-tag-mark)

; 书签列表
(global-set-key (kbd "M-8") 'list-bookmarks)
(global-set-key (kbd "<f2>") 'bookmark-set)
(global-set-key (kbd "S-<f2>") 'bookmark-jump)
(global-set-key (kbd "M-<f2>") 'bookmark-delete)

; gdb调试
(global-set-key (kbd "C-4") 'gdb)

; Switch windows
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)

;;显示/隐藏工具栏，方便调试
(global-set-key (kbd "C-9") 'tool-bar-mode)

;; undo-tree
(defun undo-tree-keymap ()
  ""
  (global-set-key (kbd "C-z")  'undo-tree-undo)
  (global-set-key (kbd "C-M-z")  'undo-tree-redo)
  )

(eval-after-load 'go-mode
  '(define-key go-mode-map (kbd "M-.") 'lsp-find-definition)
  ;; '(define-key go-mode-map (kbd "M-.") #'godef-jump)
  )
;; (define-key m (kbd "C-c C-j") #'godef-jump)


;(defun tabbar-keymap ()
;	"tabbar keymap"
;	(global-set-key (kbd "M-h") 'tabbar-backward)
;	(global-set-key (kbd "M-l") 'tabbar-forward)
;	; 分组选择
;	(global-set-key (kbd "M-u") 'tabbar-backward-group)
;	(global-set-key (kbd "M-i") 'tabbar-forward-group)
;)
;

