;;; personal-ai.el --- AI agent integrations -*- lexical-binding: t -*-
;;
;; agent-shell (ACP client) drives multiple agent CLIs via a shared UI:
;;   - Claude Code   (npm i -g @zed-industries/claude-code-acp)
;;   - Codex         (npm i -g @agentclientprotocol/codex-acp)
;;   - Gemini CLI    (--experimental-acp flag)
;;
;; agent-shell / acp / shell-maker are declared in
;; `dotspacemacs-additional-packages' and pulled from MELPA.
;;
;; Keybindings are declared in keybindings.el under `SPC a *`.
;; Loading is deferred and defensive: if the package or the CLIs are
;; missing, Emacs startup must not be blocked.
;;
;; NOTE: agent-shell's default `agent-shell-agent-configs' already covers
;; Claude / Codex / Gemini plus a few extras (Goose, Grok, ...).  We keep
;; them all — the leader keys still target the three we care about.

(condition-case err
    (with-eval-after-load 'agent-shell
      ;; No filter for now; add per-machine tweaks here if needed.
      nil)
  (error
   (message "[personal-ai] agent-shell setup skipped: %S" err)))

(provide 'personal-ai)
;;; personal-ai.el ends here
