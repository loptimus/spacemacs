;;; packages.el --- liwl layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: liwl <loptimus@Nic-MBPR.local>
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
;; added to `liwl-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `liwl/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `liwl/pre-init-PACKAGE' and/or
;;   `liwl/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst liwl-packages
  '(
    ;; tabbar
    ;; powerline
    ;; indent-guide
    )
  "The list of Lisp packages required by the liwl layer.

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

(defun liwl/init-tabbar ()
    ; (require 'tabbar)
    (tabbar-mode t)
    (set-tarbar)
    (tabbar-keymap)
    )

(defun liwl/init-indent-guide ()
  (use-package indent-guide
    :defer t
    :init
    (progn
      (setq indent-guide-delay 0.3)
      (spacemacs|add-toggle indent-guide
        :mode indent-guide-mode
        :documentation
        "Highlight indentation level at point. (alternative to highlight-indentation)."
        :evil-leader "ti")
      (spacemacs|add-toggle indent-guide-globally
        :mode indent-guide-global-mode
        :documentation
        "Highlight indentation level at point globally. (alternative to highlight-indentation)."
        :evil-leader "t TAB")))
  )

(defun liwl/init-powerline ()
  (setq powerline-display-hud nil)
  (setq powerline-default-separator nil)
  (powerline-default-theme)
  )

;;; packages.el ends here
