;;; emacs24.el --- Emacs 24 conf for vanilla Prelude

;;; Commentary:
;;; Code:

;;color-theme
(require 'prelude-packages)
(prelude-require-package 'color-theme-sanityinc-tomorrow)
(color-theme-sanityinc-tomorrow-night)

;;Font
(set-frame-font "Source Code Pro 24")
(set-fontset-font "fontset-default" 'han '("STHeiti"))
(set-face-attribute 'mode-line nil :font "DejaVu Sans Mono-16")
(set-face-attribute 'mode-line-inactive nil :font "DejaVu Sans Mono-16")

(global-set-key "\C-x\C-r" 'revert-buffer) ;; reload buffer
(global-set-key "\C-x\C-m" 'comment-region) ;; comment-region

;; Smooth Scrolling for Mouse Wheel
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; Helm, without using helm everywhere.
(setq helm-split-window-default-side "below")
(setq helm-split-window-in-side-p nil)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

;; Projectile
(setq projectile-completion-system 'grizzl)

;; Projectile ag-search
(setq ag-arguments (list "--after=5" "--before=3" "--line-number" "--smart-case" "--nogroup" "--column" "--stats" "--"))

;; The Silver Searcher
(prelude-require-package 'ag)

;; mode-line
(setq size-indication-mode nil)

;; workgroups
(prelude-require-package 'workgroups2)
(setq wg-prefix-key (kbd "C-z"))
(setq wg-morph-on nil)
(setq wg-session-file "~/.emacs.d/.emacs_workgroups")
(setq wg-emacs-exit-save-behavior           'save)
(setq wg-workgroups-mode-exit-save-behavior 'save)
(workgroups-mode 1)

;; save states
(setq desktop-restore-frames nil)
(setq desktop-dirname             "~/.emacs.d/"
      desktop-base-file-name      ".emacs.desktop"
      desktop-base-lock-name      "lock"
      desktop-path                (list desktop-dirname)
      desktop-save                t
      desktop-files-not-to-save   "^$" ;reload tramp paths
      desktop-load-locked-desktop nil)
(desktop-save-mode 1)

;; rect-mark
(prelude-require-package 'phi-rectangle)

;; Disable which-func mode due to performance issue
(which-function-mode -1)

;; turn off bell
(setq ring-bell-function 'ignore)

;; i-do Mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-create-new-buffer 'always)

;; Selection with Shift+Arrows
(global-unset-key (vector (list 'shift 'left)))
(global-unset-key (vector (list 'shift 'right)))
(global-unset-key (vector (list 'shift 'up)))
(global-unset-key (vector (list 'shift 'down)))
(setq shift-selection-mode t)

;; Disable guru-mode
(setq prelude-guru nil)

;; ES6
(prelude-require-package 'flycheck)
(prelude-require-package 'web-mode)

;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.js\\`" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\`" . web-mode))

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers '(javascript-jshint))

;; use eslint with web-mode for jsx files
(require 'flycheck)
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'javascript-mode)

;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)

;; adjust indents for js-mode to 2 spaces
(setq js-indent-level 2)

(provide 'prelude-personal-emacs24)

;;; prelude-personal-emacs24.el ends here
