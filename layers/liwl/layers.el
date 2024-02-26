;;; layers.el --- Spacemacs Layer layers File
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(configuration-layer/declare-layers
 '(
   ;; spacemacs-completion
   ;; spacemacs-editing
   git
   ivy
   ;; helm
   auto-completion
   syntax-checking
   ;; (syntax-checking
   ;;  :variables
   ;;  flycheck-disabled-checkers '(go-vet)
   ;;  )
   lsp
   markdown

   ;; 编程
   ;; ess                     ; R

   emacs-lisp

   (c-c++ :variables c-c++-backend 'lsp-clangd)

   (python :variables python-backend 'anaconda)
   ipython-notebook

   (go
    :variables
    go-tab-width 4
    gofmt-command "goimports"
    ;; go-use-gometalinter t
    ;; go-use-golangci-lint t
    ;; godoc-at-point-function 'godoc-gogetdoc
    ;; go-format-before-save t
    go-backend 'lsp
    go-use-test-args "-v -race -timeout 10s"
   )
   ;; my-python
   my-erlang
   protobuf

   html
   (vue :variables vue-backend 'lsp)
   (node :variables node-add-modules-path t)
   (javascript
    :variables
    javascript-import-tool 'import-js
    javascript-backend 'lsp
    javascript-fmt-tool 'web-beautify
    )

   plantuml
   )
 )
