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
   ;; 通用基础
   git
   ivy
   auto-completion
   syntax-checking
   lsp
   multiple-cursors
   (shell :variables
          shell-default-height 30
          shell-default-position 'bottom)

   ;; 数据 / 文档 / 配置
   sql
   yaml
   markdown
   plantuml
   protobuf

   ;; Emacs Lisp
   emacs-lisp

   ;; Python: lsp-mode + pyright (取代 anaconda-mode)
   (python :variables
           python-backend 'lsp
           python-lsp-server 'pyright
           python-formatter 'black
           python-format-on-save nil)

   ;; Go
   (go :variables
       go-tab-width 4)

   ;; Web 前端
   ;; html layer also provides css-mode and emmet-mode.
   html
   (vue :variables vue-backend 'lsp)
   (node :variables node-add-modules-path t)
   (javascript :variables
               javascript-import-tool 'import-js
               javascript-backend 'lsp
               javascript-fmt-tool 'web-beautify)
   typescript

   ;; PHP: 仅浏览, 无 LSP 后端
   php

   ;; Shell 脚本 (bash / sh / zsh) + shellcheck / shfmt
   shell-scripts

   ;; Erlang: 走 lsp-mode + ELP (registration in personal-erlang.el)
   (erlang :variables erlang-backend 'lsp)
   )
 )
