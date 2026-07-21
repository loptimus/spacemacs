;;; personal-ui.el --- UI, mode-line, editing UX -*- lexical-binding: t -*-

;; ---------------------------------------------------------------------------
;; Time display in mode-line / echo
;; ---------------------------------------------------------------------------
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-format "%a(%V) %m.%d/%H:%M")
(display-time-mode t)

;; ---------------------------------------------------------------------------
;; Cursor / mouse comfort
;; ---------------------------------------------------------------------------
(mouse-avoidance-mode 'animate)

;; ---------------------------------------------------------------------------
;; Indentation defaults (spaces, width 4)
;; ---------------------------------------------------------------------------
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; ---------------------------------------------------------------------------
;; Fill column indicator for prog-mode
;; ---------------------------------------------------------------------------
(add-hook 'prog-mode-hook
          (lambda ()
            (setq fill-column 118)
            (display-fill-column-indicator-mode)))

;; ---------------------------------------------------------------------------
;; ANSI colors in comint
;; ---------------------------------------------------------------------------
(ansi-color-for-comint-mode-on)

;; ---------------------------------------------------------------------------
;; Read-only-by-default for source files (toggle with F3)
;; ---------------------------------------------------------------------------
(add-hook 'find-file-hooks 'make-some-files-read-only)

;; ---------------------------------------------------------------------------
;; Dired
;; ---------------------------------------------------------------------------
(with-eval-after-load 'dired
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)
  (put 'dired-find-alternate-file 'disabled nil)
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;; ---------------------------------------------------------------------------
;; Snippets: derive path from Spacemacs directory (not hard-coded)
;; ---------------------------------------------------------------------------
(setq yas-snippet-dirs
      (list (expand-file-name "snippets" dotspacemacs-directory)))

;; ---------------------------------------------------------------------------
;; Quiet trailing-whitespace highlighting in documentation / dired buffers.
;; prog-mode derivatives keep the global default (t) so code stays noisy on
;; purpose.
;; ---------------------------------------------------------------------------
(dolist (hook '(org-mode-hook markdown-mode-hook dired-mode-hook))
  (add-hook hook (lambda () (setq-local show-trailing-whitespace nil))))

;; ---------------------------------------------------------------------------
;; doom-modeline: replaces spaceline.  Enable defensively in case Spacemacs
;; theme selection did not activate it.
;; ---------------------------------------------------------------------------
(with-eval-after-load 'doom-modeline
  (unless (bound-and-true-p doom-modeline-mode)
    (doom-modeline-mode 1)))

(provide 'personal-ui)
;;; personal-ui.el ends here
