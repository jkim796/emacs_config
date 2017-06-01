(message "emacs starting up...")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 128 :width condensed :foundry "DAMA" :family "Ubuntu Mono")))))
(setq c-default-style "linux"
      c-basic-offset 8)

(show-paren-mode 1)
;; (add-to-list 'load-path "~/.elisp/tuareg-mode")
;; (autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
;; (autoload 'camldebug "camldebug" "Run the Caml debugger" t)
;; (autoload 'tuareg-imenu-set-imenu "tuareg-imenu"
;;   "Configuration of imenu for tuareg" t)
;; (add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
;; (setq auto-mode-alist
;;       (append '(("\\.ml[ily]?$" . tuareg-mode)
;; 		("\\.topml$" . tuareg-mode))
;; 	      auto-mode-alist))
(setq-default fill-column 80)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))
(load "~/.emacs.d/lisp/PG/PG/generic/proof-site")

;; C++ stuff
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))

(require 'company)
(require 'cc-mode)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-backends (delete 'company-semantic company-backends))

;; irony stuff
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

(setq company-idle-delay 0)
;;(define-key c-mode-map [(tab)] 'company-complete)
;;(define-key c++-mode-map [(tab)] 'company-complete)

(add-hook 'c++mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(require 'magit)

(menu-bar-mode -1)
(tool-bar-mode -1)
;; python stuff
;; (setq py-install-directory "~/.emacs.d/python-mode.el-6.2.2")
;; (add-to-list 'load-path py-install-directory)
;; (require 'python-mode)

;; (setq-default py-shell-name "ipython")
;; (setq-default py-which-bufname "IPython")
;; (setq py-python-command-args
;;       '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
;; (setq py-force-py-shell-name-p t)

;; (setq py-shell-switch-buffers-on-execute-p t)
;; (setq py-switch-buffers-on-execute-p t)
;; (setq py-split-windows-on-execute-p nil)
;; (setq py-smart-indentation t)
;; (provide 'python-settings)
(message "done loading .emacs file...")
