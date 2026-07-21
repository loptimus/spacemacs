;;; personal-lsp.el --- LSP / projectile / language tooling tuning -*- lexical-binding: t -*-

;; ---------------------------------------------------------------------------
;; Global runtime tuning (safe to set unconditionally)
;; ---------------------------------------------------------------------------
(setq gc-cons-threshold          100000000)  ; 100 MB
(setq read-process-output-max    (* 1024 1024))  ; 1 MB

;; lsp-mode's JSON parser mode (hash-table vs plist) is chosen at load
;; time via the LSP_USE_PLISTS env var, and its .elc must be byte-compiled
;; under the same setting.  Ensure the env is set BEFORE lsp-mode loads,
;; regardless of whether the shell exported it.
(setenv "LSP_USE_PLISTS" "true")

;; ---------------------------------------------------------------------------
;; lsp-mode base
;; ---------------------------------------------------------------------------
(with-eval-after-load 'lsp-mode
  (setq lsp-idle-delay 0.5)
  (setq lsp-log-io nil)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-modeline-code-actions-enable nil)
  (setq lsp-modeline-diagnostics-enable nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-eldoc-enable-hover nil)
  (setq lsp-enable-file-watchers nil)
  (setq lsp-completion-provider :capf)
  (setq lsp-auto-guess-root nil)
  (setq lsp-prefer-flymake :none)

  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t t)
     ("gopls.staticcheck" t t))))

;; company-lsp legacy tuning (kept for parity with prior config)
(with-eval-after-load 'company-lsp
  (setq company-lsp-cache-candidates t)
  (setq company-lsp-async t))

;; ---------------------------------------------------------------------------
;; lsp-ui
;; ---------------------------------------------------------------------------
(with-eval-after-load 'lsp-ui
  (setq lsp-ui-imenu-enable t)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-position 'bottom)
  (setq lsp-ui-doc-delay 1)
  (setq lsp-ui-doc-include-signature nil)
  (setq lsp-ui-peek-enable t)
  (setq lsp-ui-flycheck-enable t))

;; ---------------------------------------------------------------------------
;; gopls
;; ---------------------------------------------------------------------------
(with-eval-after-load 'lsp-go
  (setq lsp-go-use-gopls t)
  (setq lsp-gopls-staticcheck t)
  (setq lsp-gopls-complete-unimported t)
  (setq lsp-gopls-use-placeholders t)
  (setq lsp-gopls-gofumpt t)
  (setq lsp-gopls-directory-filters
        '("-bazel-bin"
          "-bazel-out"
          "-bazel-testlogs"
          "-bazel-mizos"
          "-node_modules"
          "-vendor"
          "-.git"
          "-dist"
          "-tmp"
          "-build"))
  (setq lsp-gopls-analyses
        '((fieldalignment . nil)
          (nilness        . t)
          (unusedparams   . t)
          (unusedwrite    . t)
          (useany         . t))))

;; ---------------------------------------------------------------------------
;; projectile
;; ---------------------------------------------------------------------------
(with-eval-after-load 'projectile
  (setq projectile-enable-caching t)
  (setq projectile-indexing-method 'alien)
  (setq projectile-globally-ignored-directories
        '(".git" "node_modules" "vendor" ".idea" ".vscode" "dist" "build")))

;; ---------------------------------------------------------------------------
;; protobuf: use a small local style and register flycheck import paths
;; ---------------------------------------------------------------------------
(defconst personal-protobuf-style
  '((c-basic-offset . 2))
  "Local protobuf style used by protobuf-mode buffers.")

(add-hook 'protobuf-mode-hook
          (lambda ()
            (setq flycheck-protoc-import-path '("." ".." "../pb"))
            (c-add-style "personal-protobuf" personal-protobuf-style t)))

(provide 'personal-lsp)
;;; personal-lsp.el ends here
