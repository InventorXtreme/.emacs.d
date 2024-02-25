(setq scheme-program-name "guile")
(load-theme 'wombat t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)


(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

;; Autosave settings
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(setq tramp-backup-directory-alist backup-directory-alist) ;; use same settings for tramp


(use-package visual-fill-column
  :ensure t)

;; adds cool distraction free mode
(use-package writeroom-mode
  :ensure t)

;;vim emu
(use-package evil
 :ensure t
 :init (evil-mode)
 )
(evil-set-undo-system 'undo-redo)
(setq evil-want-fine-undo t) 
(setq evil-respect-visual-line-mode t)
(define-key evil-insert-state-map (kbd "<up>") 'nope)
(define-key evil-insert-state-map (kbd "<down>") 'nope)
(define-key evil-insert-state-map (kbd "<left>") 'nope)
(define-key evil-insert-state-map (kbd "<right>") 'nope)


(use-package evil-org
 :ensure t
 :hook (org-mode . evil-org-mode)
 :init (setf evil-org-key-theme '(textobjects insert additional shift todo heading))
 )


;; (use-package kakoune
;;   :ensure t)
;; (global-set-key (kbd "<escape>") 'ryo-modal-mode)
;; (kakoune-setup-keybinds)
;; dont forget to pdf-tools install
(use-package pdf-tools
  :ensure t)

;; built in term
;;(use-package vterm
;;  :ensure t)

;; git manager
(use-package magit
  :ensure t)

;; completion thing
(use-package vertico
  :ensure t
  :init
  (vertico-mode))

;; icons 
(use-package all-the-icons
  :ensure t)

;; saves minibuff history
(use-package savehist
  :ensure t
  :init
  (savehist-mode))

;; adds extra info to most minibuffs (file sizes n stuff)
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

;; adds icons to completions
(use-package all-the-icons-completion
  :ensure t
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init (all-the-icons-completion-mode))

;; (use-package all-the-icons-dired
;;   :ensure t
;;   :hook (dired-mode . all-the-icons-dired-mode))

(use-package neotree
  :ensure t)

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; project support
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))

(org-babel-do-load-languages
 'org-babel-load-languages '((C . t) (python . t) ))

(setq dashboard-footer-messages '("The one true editor, Emacs!" "Who the hell uses VIM anyway? Go Evil!" "Free as free speech, free as free Beer" "Happy coding!" "Vi Vi Vi, the editor of the beast" "Welcome to the church of Emacs" "While any text editor can save your files, only Emacs can save your soul" "I showed you my source code, pls respond"))

(setq dashboard-footer-messages (append dashboard-footer-messages '("sneed" "GPLv3: Free as in Freedom" "Gynu+Lwynux" "I use emacs btw")))

(use-package dashboard
  :ensure t
  :config (dashboard-setup-startup-hook)
)

;; provides autocomplete and built in errors
(use-package lsp-mode
  ;;:defer t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (XXX-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :ensure t
  )


;;base ui elements for lsp
(use-package lsp-ui :commands lsp-ui-mode
  :ensure t
  )

 
;; text completion base
(use-package company
  :ensure t
 ) 

;; go support 
(use-package go-mode
  :ensure t
  )
;;syncs emacs and system path
(use-package exec-path-from-shell
  :ensure t
  )

;; autopreview latex expressions for math and other things (currently not used because its weird or smth idk)
(use-package org-latex-impatient
  :defer t
  :ensure t
  ;;:hook (org-mode . org-latex-impatient-mode)
  :init
  (setq org-latex-impatient-tex2svg-bin
        ;; location of tex2svg executable
        "~/node_modules/mathjax-node-cli/bin/tex2svg"))
;; org mode bullet characters instead of *s 
(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode)
  )


;; ctrl c for copy and ctrl v for paste and ctrl x for cut and ctrl z for undo
(cua-mode)


;; same thing as org-latex-impatient
(use-package org-fragtog
  :ensure t
  :config
  (add-hook 'org-mode-hook 'org-fragtog-mode))

(setq org-startup-indented t)

(use-package yasnippet
  :ensure t)
(yas-global-mode 1)

(use-package yasnippet-snippets
  :ensure t)



(use-package scroll-restore
  :ensure t)
(scroll-restore-mode 1)
;; Allow scroll-restore to modify the cursor face
(setq scroll-restore-handle-cursor t)
;; Make the cursor invisible while POINT is off-screen
(setq scroll-restore-cursor-type nil)
;; Jump back to the original cursor position after scrolling
(setq scroll-restore-jump-back t)
;; Toggle scroll-restore-mode with the Scroll Lock key


;; install and load packages
(package-initialize)


;; how long to wait before completing 
(setq company-idle-delay 0)

(exec-path-from-shell-initialize)

;; make function that returns hooks that format and organize on save
(defun lsp-go-install-save-hooks () (add-hook 'before-save-hook #'lsp-format-buffer t t) (add-hook 'before-save-hook #'lsp-organize-imports t t))
;; add hooks from function to only run in go mode
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; start lsp in go mode
(add-hook 'go-mode-hook #'lsp-deferred)


(setq-default c-basic-offset 4)

;; Line numbering
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))
 '(dashboard-startup-banner 'official)
 '(lsp-enable-symbol-highlighting t)
 '(org-agenda-files nil)
 '(package-selected-packages '(which-key use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(set-frame-parameter nil 'alpha-background 60)
(add-to-list 'default-frame-alist '(alpha-background . 60))
(add-to-list 'default-frame-alist '(cursor-color . "#ffffff"))

(setq-default tab-width 4)
(menu-bar-mode -1)
(tool-bar-mode -1)
