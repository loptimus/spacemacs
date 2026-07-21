;;; personal-writing.el --- Documentation and note-taking -*- lexical-binding: t -*-

;; ---------------------------------------------------------------------------
;; Markdown
;; ---------------------------------------------------------------------------
(setq markdown-command
      "pandoc -f markdown -t html -s --mathjax --highlight-style pygments")

;; ---------------------------------------------------------------------------
;; PlantUML: derive jar path from Spacemacs directory (not hard-coded)
;; ---------------------------------------------------------------------------
(let ((jar (expand-file-name "local/plantuml.jar" dotspacemacs-directory)))
  (setq plantuml-jar-path jar)
  (setq org-plantuml-jar-path jar))

;; ---------------------------------------------------------------------------
;; Org
;; ---------------------------------------------------------------------------
(defvar personal-org-agenda-files nil
  "Machine-local Org agenda files loaded from local/user-settings.el.")

(with-eval-after-load 'org
  (add-to-list 'org-export-backends 'md)
  (when personal-org-agenda-files
    (setq org-agenda-files personal-org-agenda-files)))

;; org-babel languages
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((plantuml . t))))

;; ---------------------------------------------------------------------------
;; ox-latex: Chinese ctexart class + xelatex
;; ---------------------------------------------------------------------------
(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("ctexart" "\\documentclass[11pt]{ctexart}"
                 ("\\section{%s}"       . "\\section*{%s}")
                 ("\\subsection{%s}"    . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}"     . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}"  . "\\subparagraph*{%s}")))
  (setq org-latex-default-class "ctexart")
  (setq org-latex-compiler "xelatex"))

(provide 'personal-writing)
;;; personal-writing.el ends here
