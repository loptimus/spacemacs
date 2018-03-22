
;; set tabbar
(defun set-tarbar ()
  (set-face-attribute 'tabbar-default nil
                      :family "DejaVu Sans Mono"
                      :background "gray80"
                      :foreground "gray30"
                      :height 1.0
                      )
  (set-face-attribute 'tabbar-button nil
                      :inherit 'tabbar-default
                      :box '(:line-width 1 :color "yellow")
					)
  (set-face-attribute
                      'tabbar-separator nil
                      :background "gray20"
                      :height 0.6)
  (set-face-attribute 'tabbar-selected nil
                      :inherit 'tabbar-default
                      :foreground "DarkGreen"
                      :background "LightGoldenrod"
                      :box '(:line-width 2 :color "Darkgoldenrod")
                      :overline "black"
                      :underline "black"
                      :weight 'bold)
  (set-face-attribute 'tabbar-unselected nil :inherit 'tabbar-default :box '(:line-width 2 :color "#00B2BF"))
)

(defun tabbar-keymap ()
	"tabbar keymap"
	(global-set-key (kbd "M-h") 'tabbar-backward)
	(global-set-key (kbd "M-l") 'tabbar-forward)
	; 分组选择
	(global-set-key (kbd "M-u") 'tabbar-backward-group)
	(global-set-key (kbd "M-i") 'tabbar-forward-group)
)

; undo-tree
(defun undo-tree-keymap () ""
	(global-set-key (kbd "C-z")  'undo-tree-undo)
	(global-set-key (kbd "C-M-z")  'undo-tree-redo)
)

;;; Default only Read （默认指定为只读模式）
(defun make-some-files-read-only ()
  "when file opened is of a certain mode, make it read only"
  (when (memq major-mode '(c-mode c++-mode erlang-mode php-mode python-mode lua-mode))
    (toggle-read-only 1)))

;;; 行复制
(defun copy-lines(&optional arg)
  (interactive "p")
  (save-excursion
    (beginning-of-line)
    (set-mark (point))
    (if arg
        (next-line (- arg 1)))
    (end-of-line)
    (kill-ring-save (mark) (point))
    )
  )
