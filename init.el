(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp"))

;; ----- Install packages ----- ;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(defun install-packages (packages)
  (let ((refreshed nil))
    (dolist (pack packages)
      (unless (package-installed-p pack)
        (unless refreshed
          (package-refresh-contents)
          (setq refreshed t))
        (package-install pack)))))

(install-packages '(magit
                    markdown-mode
                    smex
                    use-package))

;; ----- keybind ----- ;;

(mapc '(lambda (pair)
         (global-set-key (kbd (car pair)) (cdr pair)))
      '(("M-g"  . goto-line)
        ("C-h"  . delete-backward-char)
        ("C-z"  . nil)
        ("C-_"  . undo)
        ("C-\\" . undo)
        ("C-o"  . nil)
        ("M-*"  . pop-tag-mark)
        ("C-x ;" . comment-region)
        ("C-x :" . uncomment-region)
        ("C-x C-i"   . indent-region)))

;; ----- Environment ----- ;;

(setq scroll-conservatively 1)
(set-face-foreground 'font-lock-comment-face "#ee0909")
(show-paren-mode t)

(use-package ido
  :config
  (ido-mode t)
  (ido-everywhere t)
  (setq ido-enable-flex-matching t))

(use-package smex
  :bind
  (("M-x" . smex)
   ("M-X" . smex-major-mode-commands)))

;; -- -- ;;

;; mode-line
(setq frame-title-format (format "emacs@%s : %%f" (system-name)))
(which-function-mode 1)

;; backup
(setq delete-auto-save-files t)
(setq backup-inhibited t)

;; use space instead of tab
(setq-default indent-tabs-mode nil)

;; dired
(defvar my-dired-before-buffer nil)
(defadvice dired-up-directory
    (before kill-up-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))

(defadvice dired-up-directory
    (after kill-up-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))

(setq dired-listing-switches "-lXa")

;; ----- Other libraries ----- ;;

;; display the directory name of the file when files that have a same name are opened
(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

;; ----- Clojure ----- ;;

(install-packages '(paredit
                    clojure-mode
                    clj-refactor
                    cider
                    company))

(use-package paredit
  :config
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'clojure-mode-hook 'enable-paredit-mode)
  (add-hook 'cider-repl-mode-hook 'enable-paredit-mode)
  :bind
  (("C-c f" . paredit-forward-slurp-sexp)
   ("C-c b" . paredit-forward-barf-sexp)
   ("C-h" . paredit-backward-delete)
   ("C-c p" . paredit-backward)
   ("C-c n" . paredit-forward)
   ("C-c m p" . paredit-mode)))

(use-package company
  :config
  (global-company-mode)
  (setq company-minimum-prefix-length 2
        company-selection-wrap-around t)

  (bind-keys :map company-mode-map
             ("C-c C-i" . company-complete)))

(use-package clj-refactor
  :config
  (add-hook 'clojure-mode-hook
            (lambda ()
              (clj-refactor-mode 1)
              (yas-minor-mode 1)
              (cljr-add-keybindings-with-prefix "C-c j"))))

;; warning for long line
(add-hook 'clojure-mode
          (lambda ()
            (font-lock-add-keywords
             nil '(("^[^\n]\\{100\\}\\(.*\\)$" 1 font-lock-warning-face t)))))

;; --------------------- ;;
;; --- auto settings --- ;;
;; --------------------- ;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-merge-arguments (quote ("--no-ff")))
 '(package-selected-packages (quote (wgrep smex w3m paredit markdown-mode magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
