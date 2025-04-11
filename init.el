;; only garbage collect at idle

(setq gc-cons-threshold (eval-when-compile (* 1024 1024 1024)))
(run-with-idle-timer 2 t (lambda () (garbage-collect)))
(setq garbage-collection-messages t)
(setq url-user-agent "Lynx/2.9.2 libwww-FM/2.14 SSL-MM/1.4.1 OpenSSL/3.4.0")
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

;; backup settings
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.backups/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; autosave settings
(setq auto-save-file-name-transforms
	  `((".*" "~/.autosaves/" t)))


(setq tramp-backup-directory-alist backup-directory-alist) ;; use same settings for tramp


(use-package cyberpunk-theme
  :ensure t)

(load-theme 'cyberpunk t)

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

(use-package compile
  :config
  (setq compilation-scroll-output t))

;; cool font stuff
(use-package ligature
  :ensure
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia and Fira Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode
                        '(;; == === ==== => =| =>>=>=|=>==>> ==< =/=//=// =~
                          ;; =:= =!=
                          ("=" (rx (+ (or ">" "<" "|" "/" "~" ":" "!" "="))))
                          ;; ;; ;;;
                          (";" (rx (+ ";")))
                          ;; && &&&
                          ("&" (rx (+ "&")))
                          ;; !! !!! !. !: !!. != !== !~
                          ("!" (rx (+ (or "=" "!" "\." ":" "~"))))
                          ;; ?? ??? ?:  ?=  ?.
                          ("?" (rx (or ":" "=" "\." (+ "?"))))
                          ;; %% %%%
                          ("%" (rx (+ "%")))
                          ;; |> ||> |||> ||||> |] |} || ||| |-> ||-||
                          ;; |->>-||-<<-| |- |== ||=||
                          ;; |==>>==<<==<=>==//==/=!==:===>
                          ("|" (rx (+ (or ">" "<" "|" "/" ":" "!" "}" "\]"
                                          "-" "=" ))))
                          ;; \\ \\\ \/
                          ("\\" (rx (or "/" (+ "\\"))))
                          ;; ++ +++ ++++ +>
                          ("+" (rx (or ">" (+ "+"))))
                          ;; :: ::: :::: :> :< := :// ::=
                          (":" (rx (or ">" "<" "=" "//" ":=" (+ ":"))))
                          ;; // /// //// /\ /* /> /===:===!=//===>>==>==/
                          ("/" (rx (+ (or ">"  "<" "|" "/" "\\" "\*" ":" "!"
                                          "="))))
                          ;; .. ... .... .= .- .? ..= ..<
                          ("\." (rx (or "=" "-" "\?" "\.=" "\.<" (+ "\."))))
                          ;; -- --- ---- -~ -> ->> -| -|->-->>->--<<-|
                          ("-" (rx (+ (or ">" "<" "|" "~" "-"))))
                          ;; *> */ *)  ** *** ****
                          ("*" (rx (or ">" "/" ")" (+ "*"))))
                          ;; www wwww
                          ("w" (rx (+ "w")))
                          ;; <> <!-- <|> <: <~ <~> <~~ <+ <* <$ </  <+> <*>
                          ;; <$> </> <|  <||  <||| <|||| <- <-| <-<<-|-> <->>
                          ;; <<-> <= <=> <<==<<==>=|=>==/==//=!==:=>
                          ;; << <<< <<<<
                          ("<" (rx (+ (or "\+" "\*" "\$" "<" ">" ":" "~"  "!"
                                          "-"  "/" "|" "="))))
                          ;; >: >- >>- >--|-> >>-|-> >= >== >>== >=|=:=>>
                          ;; >> >>> >>>>
                          (">" (rx (+ (or ">" "<" "|" "/" ":" "=" "-"))))
                          ;; #: #= #! #( #? #[ #{ #_ #_( ## ### #####
                          ("#" (rx (or ":" "=" "!" "(" "\?" "\[" "{" "_(" "_"
                                       (+ "#"))))
                          ;; ~~ ~~~ ~=  ~-  ~@ ~> ~~>
                          ("~" (rx (or ">" "=" "-" "@" "~>" (+ "~"))))
                          ;; __ ___ ____ _|_ __|____|_
                          ("_" (rx (+ (or "_" "|"))))
                          ;; Fira code: 0xFF 0x12
                          ("0" (rx (and "x" (+ (in "A-F" "a-f" "0-9")))))
                          ;; Fira code:
                          "Fl"  "Tl"  "fi"  "fj"  "fl"  "ft"
                          ;; The few not covered by the regexps.
                          "{|"  "[|"  "]#"  "(*"  "}#"  "$>"  "^="))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

;; (use-package kakoun 
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

 (use-package all-the-icons-dired
   :ensure t
   :hook (dired-mode . all-the-icons-dired-mode))

;; file tree view
(use-package neotree
  :ensure t)

;; try packages without installing them
(use-package try
  :ensure t)

;; see command connected to keypress
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


;; runs a command in either current directory or project dir if it exists
(defun run-cmd (COMMAND)
  "Runs a command in the project root or current directory"
  ;;(interactive "Command" taken from the def of projectile)
  (interactive
   (list
    (read-shell-command (if shell-command-prompt-show-cwd
                            (format-message "Async shell command in `%s': "
                                            (abbreviate-file-name
                                             default-directory))
                          "Async shell command: ")
                        nil nil
			)))
  (if (projectile-project-p) ( projectile-run-async-shell-command-in-root COMMAND) 
	(async-shell-command COMMAND))
  )
(global-set-key (kbd "C-<tab>") 'run-cmd)

;; babel stuff
(org-babel-do-load-languages
 'org-babel-load-languages '((C . t) (python . t) ))

(setq dashboard-footer-messages '("The one true editor, Emacs!" "Who the hell uses VIM anyway? Go Evil!" "Free as free speech, free as free Beer" "Happy coding!" "Vi Vi Vi, the editor of the beast" "Welcome to the church of Emacs" "While any text editor can save your files, only Emacs can save your soul" "I showed you my source code, pls respond"))

(setq dashboard-footer-messages (append dashboard-footer-messages '("sneed" "GPLv3: Free as in Freedom" "Gynu+Lwynux" "I use emacs btw" "😁 v.s. 💀 ultimate showdown" )))

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

;; zig support
(use-package zig-mode
	:ensure t
 )

(use-package rust-mode
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

(use-package flycheck-inline
  :ensure t
  :config (add-hook 'flycheck-mode-hook #'flycheck-inline-mode)
)
;; ctrl c for copy and ctrl v for paste and ctrl x for cut and ctrl z for undo
(cua-mode)


;; same thing as org-latex-impatient
(use-package org-fragtog
  :ensure t
  :config
  (add-hook 'org-mode-hook 'org-fragtog-mode))

(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))



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


;; emacs appliaction framework





(use-package doom-modeline
  :ensure t
  :config
  (setq doom-modeline-height 25)
  (setq doom-modeline-time-icon t)
  (setq doom-modeline-time-live-icon t)
  (setq doom-modeline-time-analogue-clock t)
  (setq doom-modeline-time t)
  (setq doom-modeline-percent-position nil )
  )

(use-package gptel
  :ensure t
  )

(gptel-make-openai "OpenRouter"               ;Any name you want
  :host "openrouter.ai"
  :endpoint "/api/v1/chat/completions"
  :stream t
  :key "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"
  :models '(deepseek/deepseek-r1
            ))

(use-package eww
  :commands (eww)
  :bind (:map eww-mode-map
			  ("C-c e" . eww-browse-with-external-browser))
  )


(use-package latex-preview-pane
  :ensure t)

(use-package ultra-scroll
  :load-path "~/.emacs.d/ultra-scroll" ; if you git clone'd instead of using vc
  ;:ensure t
  ;:vc (:url "https://github.com/jdtsmith/ultra-scroll") ; For Emacs>=30
  :init
  (setq scroll-conservatively 101 ; important!
        scroll-margin 0) 
  :config
  (ultra-scroll-mode 1))


(doom-modeline-def-modeline 'my-doom-modeline
  '(eldoc bar workspace-name window-number modals matches follow buffer-info remote-host buffer-position word-count parrot selection-info )
  '( compilation objed-state misc-info persp-name battery grip irc mu4e gnus github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs check time ))

(defun setup-custom-doom-modeline()
  (doom-modeline-set-modeline 'my-doom-modeline 'default))

(add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline)


(doom-modeline-mode 1)
(setq display-time-default-load-average nil)
(display-time-mode 1)
(size-indication-mode 1)


;; install and load packages
(package-initialize)



;; calc rref

(require 'calc-mtx)

(defun calc-rref (arg)
  "Compute the reduce row echelon form of a matrix"
  (interactive "P")
  (calc-slow-wrapper
   (calc-unary-op "rref" 'calcFunc-rref arg)))

(defun calcFunc-rref (m)
  "Compute the reduce row echelon form of a matrix"
  (if (math-matrixp m)
      (math-with-extra-prec 2 (rref-raw m))
    (math-reject-arg m 'matrixp)))

;; Algorithm from http://rosettacode.org/wiki/Reduced_row_echelon_form
(defun rref-raw (orig-m)
  (let* ((m (math-copy-matrix orig-m))
         (rows (1- (length m)))
         (cols (1- (length (nth 1 m))))
         (lead 1)
         (r 1))
    (catch 'done
      (while (and (<= r rows) (<= lead cols))
        (let ((i r))
          (while (math-zerop (nth lead (nth i m)))
            (setq i (1+ i))
            (when (> i rows)
              (setq i r lead (1+ lead))
              (when (> lead cols) (throw 'done m))))
          (setq m (math-swap-rows m i r))
          (let ((pivot (nth lead (nth r m))) (i 1))
            (unless (math-zerop pivot)
              (let ((j lead))
                (while (<= j cols)
                  (setcar (nthcdr j (nth r m))
                          (math-div (nth j (nth r m)) pivot))
                  (setq j (1+ j)))))
            (while (<= i rows)
              (unless (= i r)
                (let ((j lead) (c (nth lead (nth i m))))
                  (while (<= j cols)
                    (setcar (nthcdr j (nth i m))
                            (math-sub (nth j (nth i m))
                                      (math-mul c (nth j (nth r m)))))
                    (setq j (1+ j)))))
              (setq i (1+ i)))))
        (setq r (1+ r) lead (1+ lead)))
      m)))

(define-key calc-mode-map (kbd "v !") #'calc-rref)


;; how long to wait before completing 
(setq company-idle-delay 0)

(exec-path-from-shell-initialize)

;; make function that returns hooks that format and organize on save
(defun lsp-go-install-save-hooks () (add-hook 'before-save-hook #'lsp-format-buffer t t) (add-hook 'before-save-hook #'lsp-organize-imports t t))
;; add hooks from function to only run in go mode
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; start lsp in go mode
;;(add-hook 'go-mode-hook #'lsp-deferred)


(setq-default c-basic-offset 4)

;; Line numbering
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t)
 '(display-line-numbers-type 'relative)
 '(display-time-mode t)
 '(global-display-line-numbers-mode t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(all-the-icons-completion all-the-icons-dired circe company
							  cyberpunk-theme dashboard disaster
							  doom-modeline evil-org
							  exec-path-from-shell flycheck-inline
							  go-mode gptel latex-preview-pane
							  ligature lsp-ui magit marginalia neotree
							  org-bullets org-fragtog
							  org-latex-impatient pdf-tools projectile
							  rust-mode scroll-restore try vertico
							  which-key writeroom-mode
							  yasnippet-snippets zig-mode))
 '(package-vc-selected-packages
   '((ultra-scroll :url "https://github.com/jdtsmith/ultra-scroll")))
 '(size-indication-mode t)
 '(tool-bar-mode nil))


;;(add-to-list 'default-frame-alist '(alpha-background . 60))
(add-to-list 'default-frame-alist '(cursor-color . "#ffffff"))


(setq-default tab-width 4)
(c-set-offset 'access-label '/)
(setq-default org-export-preserve-breaks t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(defun eww-reddit-redirect(url)
  "Redirect reddit.com to old.reddit.com automatically."
  (replace-regexp-in-string "https://www.reddit.com" "https://old.reddit.com" url))

(setq eww-use-external-browser-for-content-type
        "\\`\\(video/\\|audio\\)") ; On GNU/Linux check your mimeapps.list
(setq eww-url-transformers '(eww-remove-tracking eww-reddit-redirect))



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Cascadia Code NF" :foundry "SAJA" :slant normal :weight regular :height 98 :width normal)))))
