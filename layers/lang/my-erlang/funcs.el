
;; Erlang节点名
(defun erl-set-nodename (name)
  "设置Erlang节点名"
  (interactive "s请输入节点名：")
  (setq inferior-erlang-machine-options (list "-sname" name))
)

(defun set-distel ()
  ""
  (let ((distel-dir erlang-distel-path))
    (unless (member distel-dir load-path)
      (setq load-path (append load-path (list distel-dir)))))
  (require 'distel)
  (distel-setup)
  )

;; ===================Erlang customizations=========================================

;; prevent annoying hang-on-compile
;(defvar inferior-erlang-prompt-timeout t)

(add-hook 'erlang-shell-mode-hook
   (lambda ()
     ;; add some Distel bindings to the Erlang shell
     (dolist (spec distel-shell-keys)
       (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

;;========================= FlymakeErlang语法检查 =========================

;; Flymake http://www.emacswiki.org/emacs/FlymakeErlang
;(require 'flymake)
;(defun flymake-erlang-init ()
;  (let* ((temp-file (flymake-init-create-temp-buffer-copy
;		     'flymake-create-temp-inplace))
;	 (local-file (file-relative-name temp-file
;		(file-name-directory buffer-file-name))))
;    (list "~/.emacs.d/erlIDE/eflymake/eflymake_linux" (list local-file))))
;(add-to-list 'flymake-allowed-file-name-masks '("\\.erl\\'" flymake-erlang-init))

;; =====================================esense 配置=================================================
(defun erl-esense ()
  ""
  (add-to-list 'load-path esensePath)
  (require 'esense-start)
  (setq esense-indexer-program (concat esensePath "/esense.bat"))
)

;; =====================================refactorerl ============================
(defun erl-refactor ()
  "Erlang Refactorerl"
  (add-to-list 'load-path (concat refactorerlPath "/lib/referl_ui/emacs"))
  (custom-set-variables '(refactorerl-base-path refactorerlPath))
  (require 'refactorerl)
  )

;; ====================================== wrangler ============================
(defun erl-wrangler ()
  "Erlang Wrangler"
  (add-to-list 'load-path (concat wranglerPath "/elisp"))
  (setq exec-path (cons (concat wranglerPath "/bin") exec-path))
  (require 'wrangler)
)

;; Erlang
