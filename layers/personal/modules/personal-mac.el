;;; personal-mac.el --- macOS platform-specific settings -*- lexical-binding: t -*-
;;
;; Shell PATH inheritance for GUI Emacs and TRAMP tweaks.

(when (memq window-system '(mac ns))
  (with-eval-after-load 'exec-path-from-shell
    (dolist (var '("GOPATH" "GOROOT" "GOPROXY" "GOSUMDB"
                   "GO111MODULE" "GOPRIVATE" "LSP_USE_PLISTS"))
      (add-to-list 'exec-path-from-shell-variables var)))
  (when (fboundp 'exec-path-from-shell-initialize)
    (exec-path-from-shell-initialize)))

;; TRAMP: keep ssh ControlMaster off-disk so stale sockets do not accumulate.
(setq tramp-ssh-controlmaster-options
      "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")

;; direnv integration via envrc: per-buffer environment sourced from the
;; nearest `.envrc'.  Restricted to `prog-mode' so writing/reading docs
;; does not trigger direnv on every buffer switch.  No-op when the
;; `direnv' binary is missing so startup stays clean on fresh machines.
(when (executable-find "direnv")
  (add-hook 'prog-mode-hook #'envrc-mode))

(provide 'personal-mac)
;;; personal-mac.el ends here
