;; melpa setup
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0e8bac1e87493f6954faf5a62e1356ec9365bd5c33398af3e83cfdf662ad955f" "ec5f697561eaf87b1d3b087dd28e61a2fc9860e4c862ea8e6b0b77bd4967d0ba" default)))
 '(package-selected-packages
   (quote
    (protobuf-mode 0blayout linum-relative vdiff magit spacemacs-theme snazzy-theme ace-window fill-column-indicator sr-speedbar exec-path-from-shell ggtags cuda-mode scala-mode rust-mode utop tuareg elpygen elpy go-mode irony zenburn-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;(load-theme 'zenburn t)
(load-theme 'snazzy t)
;(load-theme 'spacemacs t)

(setq c-defualt-style "linux"
      c-basic-offset 8)

;; irony mode
;;(add-hook 'c++-mode-hook 'irony-mode)
;;(add-hook 'c-mode-hook 'irony-mode)
;;(add-hook 'objc-mode-hook 'irony-mode)
;;(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; elpy mode
(elpy-enable)
(setq python-shell-interpreter "python"
      python-shell-interpreter-args "-i")
;; (setq python-shell-interpreter "jupyter"
;;       python-shell-interpreter-args "console --simple-prompt"
;;       python-shell-prompt-detect-failure-warning nil)
;; (add-to-list 'python-shell-completion-native-disabled-interpreters
;;              "jupyter")
(setq python-indent-offset 4)
(define-key python-mode-map (kbd "C-c i") 'elpygen-implement)

;; column marker mode
(require 'column-marker "~/.emacs.d/column-marker.el")
(add-hook 'prog-mode-hook (lambda () (interactive) (column-marker-1 80)))
(column-number-mode 1)

;; misc customizations
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(tool-bar-mode -1)
(electric-pair-mode 1)
;(linum-mode t)

(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line

(setq exec-path (cons "/usr/local/bin" exec-path))

(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

(exec-path-from-shell-initialize)

(setq-local imenu-create-index-function #'ggtags-build-imenu-index)

;;(sr-speedbar-toggle)

(global-set-key (kbd "M-o") 'ace-window)

(require 'linum-relative)
;;(linum-on)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'linum-relative-on)
;;(linum-relative-on)
;;(linum-mode)
;;(setq linum-relative-backend 'display-line-numbers-mode)

;;(linum-mode t)
(message "init completed")
