
;; Erlang Path
(spacemacs|define-jump-handlers erlang-mode)

(defvar flycheck-erlang-include-path nil
  "Erlang 头文件目录")

(defvar flycheck-erlang-library-path nil
  "Erlang依赖目录")

(setq erlang-root-path "~/workspace/opt/erlang/r19b03")
(setq erlang-root-dir erlang-root-path)
(setq exec-path (cons (concat erlang-root-path "/bin") exec-path))
(setq erlang-man-root-dir (concat erlang-root-path "/man"))

;; Distel
; (setq erlang-distel-path "~/.spacemacs.d/layers/lang/my-erlang/local/distel-4.03/elisp")
(setq erlang-distel-path "~/.spacemacs.d/layers/lang/my-erlang/local/distel/elisp")

;; Erlang Cookie
(setq derl-cookie "k35bz75vc881x")

(defvar inferior-erlang-machine (concat erlang-root-path "/bin/" "erl")
  "The name of the Erlang shell.")

;; (defvar inferior-erlang-display-buffer-any-frame nil
;;   "When nil, `inferior-erlang-display-buffer' use only selected frame.
;; When t, all frames are searched.  When 'raise, the frame is raised.")

;; (defvar inferior-erlang-shell-type 'newshell
;;   "The type of Erlang shell to use.

;; When this variable is set to the atom `oldshell', the old shell is used.
;; When set to `newshell' the new shell is used.  Should the variable be
;; nil, the default shell is used.

;; This variable influence the setting of other variables.")

;; (defvar inferior-erlang-machine-options '()
;;   "The options used when activating the Erlang shell.

;; This must be a list of strings.")

;; (defvar inferior-erlang-process-name "inferior-erlang"
;;   "The name of the inferior Erlang process.")

;; (defvar inferior-erlang-buffer-name erlang-shell-buffer-name
;;   "The name of the inferior Erlang buffer.")

;; (defvar inferior-erlang-prompt-timeout 60
;;   "Number of seconds before `inferior-erlang-wait-prompt' timeouts.

;; The time specified is waited after every output made by the inferior
;; Erlang shell.  When this variable is t, we assume that we always have
;; a prompt.  When nil, we will wait forever, or until \\[keyboard-quit].")

;; (defvar inferior-erlang-process nil
;;   "Process of last invoked inferior Erlang, or nil.")

;; (defvar inferior-erlang-buffer nil
;;   "Buffer of last invoked inferior Erlang, or nil.")

;; Esense
;; (defvar esensePath "~/.emacs.d/lisp/erlang/esense-1.12")

;; Refactorerl
;; (defvar refactorerlPath "~/.emacs.d/lisp/erlang/refactorerl")

;; Wrangler
;; (defvar wranglerPath "D:/Program Files/Wrangler")

;; tell distel to default to that node
(setq erl-nodename-cache
      (make-symbol
       (concat
        "emacs@"
        ;; Mac OS X uses "name.local" instead of "name", this should work
        ;; pretty much anywhere without having to muck with NetInfo
        ;; ... but I only tested it on Mac OS X.
        (car (split-string (shell-command-to-string "hostname"))))))

;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(("\C-\M-i"   erl-complete)
    ("\M-?"      erl-complete)
    ("\M-."      erl-find-source-under-point)
    ("\M-,"      erl-find-source-unwind)
    ("\M-*"      erl-find-source-unwind)
    )
  "Additional keys to bind when in Erlang shell.")

;; prevent annoying hang-on-compile
;(defvar inferior-erlang-prompt-timeout t)

;; (setq erlang-flymake-get-include-dirs-function 'my-erlang-include-dirs-function)
;; (setq erlang-flymake-get-code-path-dirs-function 'my-erlang-code-dirs-function)
;; (eval-when-compile (require 'flycheck))

(setq erlang-skel-mail-address user-mail-address)
(setq erlang-indent-guard 4)
(setq erlang-argument-indent 4)

; (message "======>" flycheck-erlang-include-path)

;(setq flycheck-erlang-include-path
;    (append flycheck-erlang-include-path
;            '("inc" "../inc" "../../inc" "../../../inc"
;              "include" "../include" "../../include" "../../../include")))
;(setq flycheck-erlang-library-path
;    (append flycheck-erlang-library-path
;            '("../ebin" "../../ebin" "../../../ebin")))
