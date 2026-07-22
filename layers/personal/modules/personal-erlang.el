;;; personal-erlang.el --- Erlang LSP integration -*- lexical-binding: t -*-

(with-eval-after-load 'lsp-mode
  (condition-case err
      (lsp-register-client
       (make-lsp-client
        :new-connection (lsp-stdio-connection '("elp" "server"))
        :major-modes '(erlang-mode)
        :priority 1
        :server-id 'erlang-language-platform))
    (error
     (message "[personal-erlang] ELP setup skipped: %S" err))))

(provide 'personal-erlang)
;;; personal-erlang.el ends here
