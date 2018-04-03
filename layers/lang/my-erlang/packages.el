;;; packages.el --- my-erlang layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author:  <Administrator@SKY-20141222GED>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `my-erlang-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `my-erlang/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `my-erlang/pre-init-PACKAGE' and/or
;;   `my-erlang/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst my-erlang-packages
  '(
    company
    erlang
    flycheck
    )
  "The list of Lisp packages required by the my-erlang layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun my-erlang/init-erlang ()
  (use-package erlang
    :defer t
    :init
    (progn
      ;; explicitly run prog-mode hooks since erlang mode does is not
      ;; derived from prog-mode major-mode
      ;; (add-hook 'erlang-mode-hook (lambda () (run-hooks 'prog-mode-hook)))
      (add-hook 'erlang-mode-hook 'spacemacs/run-prog-mode-hooks)
      (setq erlang-compile-extra-opts '(debug_info)))
    :config
    (require 'erlang-start)))

(defun my-erlang/post-init-erlang ()
  "Init Distel"
  (set-distel)
  )

(defun my-erlang/post-init-company ()
  (add-hook 'erlang-mode-hook 'company-mode))

(defun my-erlang/post-init-flycheck () ""
  (spacemacs/add-flycheck-hook 'erlang-mode)
  ;; (spacemacs|diminish flycheck-mode " fc" " fc")
  ;; (spacemacs|diminish auto-complete-mode " ac" " ac")
  (setq flycheck-erlang-include-path
      (append flycheck-erlang-include-path
              '("inc" "../inc" "../../inc" "../../../inc"
                "include" "../include" "../../include" "../../../include")))
  (setq flycheck-erlang-library-path
      (append flycheck-erlang-library-path
              '("../ebin" "../../ebin" "../../../ebin")))
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  )

(defun erlang/post-init-ggtags ()
  (add-hook 'erlang-mode-local-vars-hook #'spacemacs/ggtags-mode-enable))

(defun erlang/post-init-helm-gtags ()
  (spacemacs/helm-gtags-define-keys-for-mode 'erlang-mode))

;;; packages.el ends here
