
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
  (when (not (memq major-mode '(emacs-lisp-mode org-mode)))
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

;; GOLANG
;; GOPATH相关配置
(setq default-gopath (getenv "GOPATH"))
(setq current-gopath "")

;; (defun set-gopath (relative-path)
;;   (interactive
;;    (list (read-string "relative path: " "." nil nil nil)))
;;   (setq current-gopath (file-truename relative-path))
;;   (setenv "GOPATH" (concat current-gopath  ":" (getenv "GOPATH")))
;;   (exec-path-from-shell-copy-env "GOPATH")
;;   )

(defun set-current-gopath (project)
  (interactive
   (list (read-string "relative path: " "mizhua" nil nil nil)))
  (cond
   ((equal project "mizhua") (setq project-path "/Users/lwl/workspace/go/src/mizhua/server:/Users/lwl/workspace/go/src/mizhua/server/vendor"))
   ((equal project "plugin") (setq project-path "/Users/lwl/workspace/go/src/mizhua/plugin_srv:/User/lwl/workspace/go/src/mizhua/plugin_srv/vendor"))
   ((equal project "club") (setq project-path "/Users/lwl/workspace/go/src/mizhua/club_sys:/User/lwl/workspace/go/src/mizhua/club_sys/vendor"))
   ((equal project "xhx") (setq project-path "/Users/lwl/workspace/go/src/xhx/server:/User/lwl/workspace/go/src/xhx/server/vendor"))
   (t (setq project-path ""))
   )
  (setenv "GOPATH" (concat (getenv "GOPATH") ":" project-path))
  ;; (exec-path-from-shell-copy-env "GOPATH")
  )

(defun get-gopath ()
  (interactive)
  (message (getenv "GOPATH")))

(defun reset-gopath ()
  (interactive)
  (setenv "GOPATH" default-gopath)
  (setq current-gopath ""))

;; 编译配置
; (setq default-go-package "")

; (defun go-install (&optional pkg)
;  (interactive
;   (list (read-string (format "Package Name[%s]: " default-go-package) nil nil "")))

;  (if (not (string= pkg ""))
;      (setq default-go-package pkg))

;  (projectile-with-default-dir current-gopath
;    (projectile-run-compilation (concat "export GOPATH=" current-gopath " && " "go install" " " default-go-package))))

; (spacemacs/set-leader-keys-for-major-mode 'go-mode
;  "gi" 'go-install)
