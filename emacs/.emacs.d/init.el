;;; init.el --- Entry point: load literate config  -*- lexical-binding: t; -*-

;;; Commentary:

;; 该文件只做一件事：加载 config.org（org-babel-load-file）
;; 所有配置都在 config.org 中以文学编程方式管理

;;; Code:

(org-babel-load-file
 (expand-file-name "config.org" user-emacs-directory))

;;; init.el ends here
