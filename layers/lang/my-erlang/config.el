
;; Erlang Path
(setq erlang-root-path "/usr/local/Cellar/erlang/17.5")
(setq erlang-root-dir erlang-root-path)
(setq exec-path (cons (concat erlang-root-path "/bin") exec-path))
(setq erlang-man-root-dir (concat erlang-root-path "/man"))

;; Distel
(setq erlang-distel-path "~/.spacemacs.d/layers/lang/my-erlang/local/distel-4.03/elisp")

;; Erlang Cookie
(setq derl-cookie "k35bz75vc881x")
;; (setq derl-cookie "k35bz75vc881x")

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

(defun my-erlang-include-dirs-function ()
  ""
  (list
   "inc" "../inc" "../../inc" "../../../inc" "../../../../inc"
   "include" "../include" "../../include" "../../../include"))
(defun my-erlang-code-dirs-function () "" (list "../ebin" "../../ebin" "../../../ebin"))
;; (setq erlang-flymake-get-include-dirs-function 'my-erlang-include-dirs-function)
;; (setq erlang-flymake-get-code-path-dirs-function 'my-erlang-code-dirs-function)
;; (eval-when-compile (require 'flycheck))

(setq erlang-skel-mail-address user-mail-address)
(setq erlang-indent-guard 4)
(setq erlang-argument-indent 4)
