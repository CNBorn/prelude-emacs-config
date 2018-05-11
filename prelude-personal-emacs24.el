;;; emacs24.el --- Emacs 24 conf for vanilla Prelude

;;; Commentary:
;;; Code:

(package-initialize)

;;color-theme
(require 'prelude-packages)
(prelude-require-package 'color-theme-sanityinc-tomorrow)
(color-theme-sanityinc-tomorrow-night)

;;Font
(set-frame-font "Source Code Pro 20")
(set-fontset-font "fontset-default" 'han '("STHeiti"))
(set-face-attribute 'mode-line nil :font "DejaVu Sans Mono for Powerline-14")
(set-face-attribute 'mode-line-inactive nil :font "DejaVu Sans Mono for Powerline-14")

(global-set-key "\C-x\C-r" 'revert-buffer) ;; reload buffer
(global-set-key "\C-x\C-m" 'comment-region) ;; comment-region

;; Smooth Scrolling for Mouse Wheel
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; Projectile
(setq projectile-completion-system 'helm)
(define-key projectile-command-map (kbd "s g") 'helm-imenu-anywhere)
(define-key projectile-command-map (kbd "s l") 'helm-imenu)
(define-key projectile-command-map (kbd "s s") 'helm-ag-project-root)

;; Helm-ag (uses rg)
(custom-set-variables
 '(helm-follow-mode-persistent t))
(setq helm-ag-insert-at-point 'symbol)
(setq helm-ag-base-command "rg --vimgrep --no-heading")

;; Helm
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

(setq helm-full-frame 1)
(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(setq helm-mode-fuzzy-match t)
(setq helm-completion-in-region-fuzzy-match t)

;; powerline
(prelude-require-package 'powerline)
(powerline-default-theme)
(setq powerline-display-buffer-size nil)

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

;; limit line length
(setq whitespace-line-column 120)

;; perspective
(prelude-require-package 'persp-mode)
(persp-mode 1)
(setq persp-mode-prefix-key (kbd "C-z"))

;; Pyenv
(prelude-require-package 'pyenv-mode)

(add-hook 'ruby-mode-hook 'robe-mode)

(eval-after-load 'company
  '(push 'company-robe company-backends))

;; Flycheck
(prelude-require-package 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(provide 'prelude-personal-emacs24)

;;; prelude-personal-emacs24.el ends here
