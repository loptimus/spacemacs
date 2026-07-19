;;; config.el --- liwl layer configuration entry point -*- lexical-binding: t -*-
;;
;; Aggregates topic modules from ./modules/.  Add or disable a topic by
;; editing the require list below.
;;
;; Load order matters:
;;   mac      -- shell PATH must be inherited before LSP servers spawn
;;   lsp      -- LSP/projectile tuning before language layers wake up
;;   ui       -- mode-line / fonts / editing UX
;;   writing  -- markdown / org / plantuml
;;   ai       -- agent-shell (last; optional, must not block startup)

(let* ((base (cond
              ((and (boundp 'dotspacemacs-filepath) dotspacemacs-filepath
                    (file-exists-p dotspacemacs-filepath))
               (file-name-directory dotspacemacs-filepath))
              ((and load-file-name)
               ;; config.el sits at <base>/layers/liwl/config.el
               (file-name-directory
                (directory-file-name
                 (file-name-directory
                  (directory-file-name
                   (file-name-directory load-file-name))))))
              ((and (boundp 'dotspacemacs-directory) dotspacemacs-directory)
               dotspacemacs-directory)
              (t user-emacs-directory)))
       (modules-dir (expand-file-name "layers/liwl/modules" base)))
  (message "[liwl] loading modules from %s" modules-dir)
  (add-to-list 'load-path modules-dir))

(require 'liwl-mac)
(require 'liwl-lsp)
(require 'liwl-ui)
(require 'liwl-writing)
(require 'liwl-ai)

;;; config.el ends here
