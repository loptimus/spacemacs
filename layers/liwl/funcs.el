;;; funcs.el --- liwl layer utility functions -*- lexical-binding: t -*-

(defun make-some-files-read-only ()
  "Open non-elisp / non-org files in read-only mode by default."
  (when (not (memq major-mode '(emacs-lisp-mode org-mode)))
    (read-only-mode 1)))

(defun copy-lines (&optional arg)
  "Copy ARG lines starting from the current line to the kill ring."
  (interactive "p")
  (save-excursion
    (beginning-of-line)
    (set-mark (point))
    (when arg
      (next-line (- arg 1)))
    (end-of-line)
    (kill-ring-save (mark) (point))))

(defun copy-file-path-with-line ()
  "Copy the absolute file path with line number at point."
  (interactive)
  (let* ((filename (buffer-file-name))
         (line-number (line-number-at-pos)))
    (kill-new (format "%s:%d" filename line-number))
    (message "Copied: %s:%d" filename line-number)))

(defun copy-relative-file-path-with-line ()
  "Copy the project-relative file path with line number at point."
  (interactive)
  (let* ((filename (buffer-file-name))
         (project-root (projectile-project-root))
         (relative-path (file-relative-name filename project-root))
         (line-number (line-number-at-pos)))
    (kill-new (format "%s:%d" relative-path line-number))
    (message "Copied: %s:%d" relative-path line-number)))

;;; funcs.el ends here
