;;; config.el --- personal layer configuration entry point -*- lexical-binding: t -*-
;;
;; Aggregates topic modules from ./modules/.  Add or disable a topic by
;; editing the require list below.
;;
;; Load order matters:
;;   mac      -- shell PATH must be inherited before LSP servers spawn
;;   lsp      -- LSP/projectile tuning before language layers wake up
;;   ui       -- mode-line / fonts / editing UX
;;   writing  -- markdown / org / plantuml
;;   ai       -- agent-shell (optional, must not block startup)
;;   erlang   -- ELP client registration after general LSP tuning

(let ((modules-dir
       (expand-file-name "modules" (file-name-directory load-file-name))))
  (message "[personal] loading modules from %s" modules-dir)
  (add-to-list 'load-path modules-dir))

(require 'personal-mac)
(require 'personal-lsp)
(require 'personal-ui)
(require 'personal-writing)
(require 'personal-ai)
(require 'personal-erlang)

;;; config.el ends here
