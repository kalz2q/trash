;;;; Emacs text editor (since 1976) initialization file.
;;;; M-r (move-to-window-line)

(add-hook 'python-mode-hook
          '(lambda ()
             (setq python-indent 2)))

(setq lexical-binding t) ; Enables lexical binding for this buffer. Not used.

(when (display-graphic-p)               ; X Window Sysmtem mode
  ;; C-x C-0/C-x C-+/C-x C--: text-scale-adjust/text-scale-increase/text-scale-decrease.
  (message "(= (display-grahpic-p) t)")
  (tool-bar-mode -1)     ; Hides toolbar buttons.
  (scroll-bar-mode -1)   ; Hides scrollbar. It's broken in Ubuntu.
  (progn                 ; Same binding with gnome-terminal's default.
    (global-set-key (kbd "C-+") #'text-scale-increase)  ; or C-x C-+
    (global-set-key (kbd "C--") #'text-scale-decrease)) ; or C-x C--
  (progn                                                ; Sets fonts.
    (set-frame-font "Courier 10 Pitch" nil t)
    (set-fontset-font t
                      'japanese-jisx0208 ; JIS X 0208
                      "TakaoPGothic"))
  (defun my/alpha (alpha)
    "Sets transparency to ALPHA."
    (interactive "nalpha: ")
    (set-frame-parameter nil 'alpha alpha))
  (my/alpha 90)
  (defun my/line-spacing ()
    "Toggles line-spacing."
    (interactive)
    (setq-default line-spacing
                  (if line-spacing nil 0.5)))
  (defun my/toggle-fullscreen ()
    "Toggles fullscreen mode."
    (interactive)
    (set-frame-parameter nil 'fullscreen
                         (if (frame-parameter nil 'fullscreen)
                             nil 'fullboth)))
  (global-set-key (kbd "<f11>") #'my/toggle-fullscreen)
  (my/toggle-fullscreen)
  (add-hook 'emacs-startup-hook
            (lambda ()
              ;; (menu-bar-mode 1)         ; Shows menubar.
              (setq linum-format "%d"))))

;;; Startup messages.
(progn (message "========== Executing init.el ==========") ; Prints to *Messages* buffer.
       (message "(= emacs-version %s)"  ; Prints version number.
                emacs-version)
       (defun my/emacs-init-time ()
         "(emacs-init-time) with argumented precision."
         (interactive)
         (let ((s (format "%.3f seconds"
                          (float-time (time-subtract after-init-time
                                                     before-init-time)))))
           (if (called-interactively-p 'interactive)
               (message "%s"
                        s)              ; Prints
             s)))                       ; Returns a string.
       (add-hook 'emacs-startup-hook    ; Prints start-up message.
                 (lambda ()
                   "Prints greeting."
                   (message "Howdy. (= emacs-init-time \"%s\")"
                            (my/emacs-init-time))))
       (progn (when nil                 ; disabled
                (setq recenter-positions
                      (cons 0.75    ; Position for recentering by C-l.
                            (cdr recenter-positions)))
                (add-hook 'emacs-startup-hook
                          (lambda ()
                            "Goes to end-of-buffer."
                            (end-of-buffer)
                            (setq recenter-positions ; Configures temporary
                                  (cons 0.75
                                        recenter-positions))
                            (recenter-top-bottom)
                            (setq recenter-positions ; Restores the previous setting.
                                  (cdr recenter-positions))))))
       (setq inhibit-startup-message
             t)               ; Suppresses "Welcome to GNU Emacs ...".
       (setq initial-scratch-message ; Suppresses "This buffer is for ...".
             (current-time-string)))

;;; Files.
(progn (setq custom-file ; Let Emacs edit custom.el instead of this file.
             (expand-file-name "custom.el"
                               user-emacs-directory))
       (when (file-exists-p custom-file)
         (load custom-file))
       (setq make-backup-files
             nil)          ; Does not make backup files like example~.
       (setq auto-save-default
             nil)      ; Does not make auto-save files like #example#.
       (setq create-lockfiles
             nil))          ; Does not make lock files like .#example.

;;; Basic settings.
(progn (setq-default indent-tabs-mode
                     nil)               ; Uses spaces; not tabs.
       (setq-default tab-width
                     2)
       (global-linum-mode t)            ; Shows line numbers.
       (setq linum-format
             "%5d ")                    ; Sets the line number format.
       (column-number-mode t)           ; Shows column numbers
       ;; (setq-default word-wrap t)
       ;; (global-visual-line-mode t)
       (add-to-list 'global-mode-string ; Number of characters in mode-line.
                    '(" %i"))
       (setq show-paren-delay
             0)            ; Highlights immediately.
       (set-face-background 'show-paren-match nil)
       (set-face-attribute 'show-paren-match nil :underline t)
       (show-paren-mode t) ; Highlights matching pairs of parentheses.
       (menu-bar-mode -1)  ; Hides menu bar.
       (progn (global-set-key (kbd "M-P")        #'scroll-down-line)
              (global-set-key (kbd "M-S-<up>")   #'scroll-down-line)
              (global-set-key (kbd "M-N")        #'scroll-up-line)
              (global-set-key (kbd "M-S-<down>") #'scroll-up-line))
       (setq scroll-preserve-screen-position
             t)       ; Points same location of screen when scrolling.
       (setq scroll-error-top-bottom    ; Point can reach top/bottom.
             t))

;;; Basic hooks.
(progn
  (add-hook 'before-save-hook           ; Removes spaces at EOL/EOF.
            'delete-trailing-whitespace)
  (add-hook 'html-mode-hook
            (lambda ()
              (electric-indent-mode 0)))
  ;; Indents Common Lisp if-forms differently from emacs-lisp-mode.
  (add-hook 'lisp-mode-hook
            (lambda ()
              (set (make-local-variable 'lisp-indent-function)
                   'common-lisp-indent-function))))

;;; Beep settings.
(progn (defun my/flash-mode-line ()
         "Colors mode-line brightly for a moment."
         (let ((original-color (face-background 'mode-line))
               (temporal-color "#ffff00"))
           (set-face-background 'mode-line
                                temporal-color)
           (run-with-idle-timer 0.5
                                nil
                                (lambda (x)
                                  "Restores the original color."
                                  (set-face-background 'mode-line
                                                       x))
                                original-color)))
       (setq ring-bell-function
             #'my/flash-mode-line)
       (add-hook 'after-save-hook
                 #'my/flash-mode-line))

;; Theme.
(progn (load-theme 'manoj-dark)
       (defun my/random-theme ()
         "Loads a random theme."
         (interactive)
         (let* ((themes '(adwaita deeper-blue dichromacy light-blue manoj-dark
                                  misterioso tango tango-dark tsdh-dark
                                  tsdh-light wheatgrass whiteboard wombat))
                (length (length themes))
                (n (random length))     ; random number
                (theme (nth n           ; random theme
                            themes)))
           (message (symbol-name theme))
           (load-theme theme)))
       (progn (defun on-after-init ()
                "Disables the theme backgound color in terminal."
                (unless (display-graphic-p (selected-frame))
                  (set-face-background 'default
                                       "unspecified-bg"
                                       (selected-frame))))
              (add-hook 'window-setup-hook
                        #'on-after-init)))

;;; Sphinx documentation generator.
(progn (defun my/sphinx-make-html ()
         "Issues 'make html' on the system to build Sphinx files."
         (interactive)
         (let ((default-directory (locate-dominating-file default-directory "Makefile")))
           (if (not default-directory)
               (message "Makefile not found.")
             (save-buffer)
             (message "make html  at  %s" default-directory)
             (message "%s" (shell-command-to-string "make html")))))
       (global-set-key (kbd "C-q") nil)
       (global-set-key (kbd "C-q C-h") #'my/sphinx-make-html))

;;; Installs use-package.el.
(progn (require 'package)               ; package.el is built-in.
       (setq package-enable-at-startup
             nil)
       (add-to-list 'package-archives
                    '("melpa-stable" . "https://stable.melpa.org/packages/"))
       ;; (add-to-list 'package-archives
       ;;              '("melpa" . "https://melpa.org/packages/"))
       (setq use-package-always-pin
             "melpa-stable")
       (package-initialize)
       (unless package-archive-contents
         (package-refresh-contents))
       (unless (package-installed-p 'use-package)
         (package-install 'use-package))
       (progn
         (setq use-package-verbose
               t)
         (setq use-package-minimum-reported-time
               0.0001)))

(use-package cider
  :ensure t
  :defer t
  :commands cider
  :init
  (message "\tinit cider")
  :config
  (message "\tconf cider")
  (setq cider-auto-select-error-buffer t)
  (setq cider-save-file-on-load t) ; when C-c C-k (cider-load-buffer).
  (setq cider-show-error-buffer t))

(use-package clojure-mode
  :ensure t
  :defer t
  :init
  (message "\tinit clojure-mode")
  :config
  (message "\tconf clojure-mode"))

(use-package company
  :ensure t
  :commands (cider-mode python-mode)
  :init
  (message "\tinit company")
  (add-hook 'cider-mode-hook      #'company-mode)
  (add-hook 'clojure-mode-hook    #'company-mode)
  (add-hook 'emacs-lisp-mode-hook #'company-mode)
  (add-hook 'python-mode-hook     #'company-mode)
  :config
  (message "\tconf company")
  (progn          ; Disables enter key, and use tab instead.
    ;; RET is for company-complete-selection at default;
    (define-key company-active-map (kbd "RET") nil)
    (define-key company-active-map (kbd "<return>") nil) ; for display-graphic-p
    ;; TAB was company-complete-common, which completes just common part.
    (define-key company-active-map (kbd "TAB") #'company-complete-selection)
    (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
    (define-key company-active-map (kbd "<up>") nil)
    (define-key company-active-map (kbd "<down>") nil)
    (define-key company-active-map (kbd "M-n") #'company-select-next)
    (define-key company-active-map (kbd "M-p") #'company-select-previous))
  (progn
    (set-face-attribute 'company-tooltip nil
                        :foreground "#777777" :background "#333333")
    (set-face-attribute 'company-tooltip-common nil
                        :foreground "#777777")
    (set-face-attribute 'company-tooltip-selection nil
                        :foreground "#999999" :background "#444444")
    (set-face-attribute 'company-tooltip-common-selection nil
                        :foreground "#999999")))

(use-package dired                      ; DIRectory EDitor since 1974.
  :init
  (message "\tinit dired")
  :config
  (message "\tconf dired")
  (put 'dired-find-alternate-file 'disabled nil) ; Suppresses warning.
  (defun my/nautilus ()
    (interactive)
    (call-process "nautilus" nil nil nil
                  (expand-file-name default-directory))) ; Expands tilde.
  (define-key dired-mode-map "N" #'my/nautilus))

(use-package google-translate
  :ensure t
  :bind (("C-q C-q" . google-translate-at-point))
  :commands google-translate-at-point
  :init
  (message "\tinit google-translate")
  (setq google-translate-default-source-language "en")
  (setq google-translate-default-target-language "ja")
  :config
  (message "\tconf google-translate"))

;; (use-package golden-ratio
;;   :ensure t
;;   :init
;;   (message "\tinit golden-ratio")
;;   (golden-ratio-mode 1)
;;   :config
;;   (message "\tconf golden-ratio"))

(use-package haskell-mode
  :ensure t
  :mode (("\\.hs\\'" . haskell-mode))
  :init
  (message "\tinit haskell-mode")
  :config
  (message "\tconf haskell-mode"))

(use-package idle-highlight-mode ; Highlights same identifiers in source code.
  :disabled
  :ensure t
  :init
  (message "\tinit idle-highlight-mode")
  (add-hook 'clojure-mode-hook #'idle-highlight-mode)
  :config
  (message "\tconf idle-highlight-mode"))

;; (use-package monokai-theme              ; very slow
;;   :ensure t)

(use-package paredit
  :ensure t
  :commands (lisp-mode)
  :init
  (message "\tinit paredit")
  (add-hook 'cider-repl-mode-hook                  #'enable-paredit-mode)
  (add-hook 'clojure-mode-hook                     #'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook                  #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook                        #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook                        #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook            #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook                      #'enable-paredit-mode)
  :config
  (message "\tconf paredit")
  (define-key paredit-mode-map(kbd "C-q )") ; = C-)
    #'paredit-forward-slurp-sexp)
  (define-key paredit-mode-map (kbd "C-q }") ; = C-}
    #'paredit-forward-barf-sexp)
  (define-key paredit-mode-map (kbd "C-q (") ; = C-(
    #'paredit-backward-slurp-sexp)
  (define-key paredit-mode-map (kbd "C-q {") ; = C-{
    #'paredit-backward-barf-sexp)
  (define-key paredit-mode-map (kbd "C-q M-n") ; = <M-up>
    #'paredit-splice-sexp-killing-forward)
  (define-key paredit-mode-map (kbd "C-q M-p") ; = <M-down>
    #'paredit-splice-sexp-killing-backward))

(use-package rainbow-delimiters
  :ensure t
  :defer t
  :init
  (message "\tinit rainbow-delimiters")
  (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'clojure-mode-hook    #'rainbow-delimiters-mode)
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'lisp-mode-hook       #'rainbow-delimiters-mode)
  (add-hook 'scheme-mode-hook     #'rainbow-delimiters-mode)
  :config
  (message "\tconf rainbow-delimiters")
  (progn
    (setq rainbow-delimiters-max-face-count 6)
    (set-face-foreground 'rainbow-delimiters-depth-1-face "#ff6666")   ; red
    (set-face-foreground 'rainbow-delimiters-depth-2-face "#66ff66")   ; green
    (set-face-foreground 'rainbow-delimiters-depth-3-face "#6666ff")   ; blue
    (set-face-foreground 'rainbow-delimiters-depth-4-face "#ffff66")   ; yellow
    (set-face-foreground 'rainbow-delimiters-depth-5-face "#66ffff")   ; cyan
    (set-face-foreground 'rainbow-delimiters-depth-6-face "#ff66ff"))) ; magenta

(use-package rst                        ; reStructuredText
  :ensure t
  :defer t
  :commands rst-mode
  :init
  (message "\tinit rst")
  :config
  (message "\tconf rst")
  (setq frame-background-mode 'dark) ; Uses the color palette for dark background.
  (define-key rst-mode-map (kbd "<M-RET>") #'rst-insert-list)) ; Appends a list item.

(use-package saveplace      ; Remembers cursor position for each file.
  :config
  (save-place-mode 1)
  (setq save-place-file
        (concat user-emacs-directory
                "saveplace")))

;; C-x C-e: scheme-send-last-sexp in cmuscheme.el (under run-scheme).
(use-package scheme
  :ensure t
  :commands (scheme-mode run-scheme)
  :init
  (message "\tinit scheme")
  :config
  (message "\tconf scheme")
  (setq process-coding-system-alist
        (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
  (setq scheme-program-name "gosh -i")
  (defun scheme-other-window ()
    "Run Gauche on other window"
    (interactive)
    (let ((buf-name (buffer-name (current-buffer))))
      (scheme-mode)
      (switch-to-buffer-other-window
       (get-buffer-create "*scheme*"))
      (run-scheme scheme-program-name)
      (switch-to-buffer-other-window
       (get-buffer-create buf-name))))
  (define-key scheme-mode-map (kbd "C-c s") 'scheme-other-window))

(use-package slime
  :ensure t
  :defer t
  :commands slime
  :init
  (message "\tinit slime")
  :config
  (message "\tconf slime")
  (use-package slime-company
    :ensure t
    :commands slime-company)
  (setq inferior-lisp-program (executable-find "sbcl"))
  (slime-setup '(slime-company)))

;;(use-package smart-mode-line)           ; too slow

(use-package total-lines            ; Provides a variable total-lines.
  :ensure t
  :init
  (message "\tinit total-lines")
  :config
  (message "\tconf total-lines")
  (global-total-lines-mode)        ; Now total-lines is available.
  (setq-default mode-line-position ; Not sophisticated but simple solution.
                (append mode-line-position
                        '((:eval (format "/%d"
                                         total-lines)))))) ; only usage

(use-package xclip
  :ensure t
  :if (executable-find "xclip")
  :init
  (message "\tinit xclip")
  :config
  (message "\tconf xclip")
  (xclip-mode 1))

;; (use-package zenburn-theme
;;   :ensure t)




;;; not for emacs
(defun my/string-from-file (path)
  "Reads a file PATH and returns the data as a string."
  (with-temp-buffer
    (insert-file-contents path)
    (buffer-string)))
(defun my/append-to-file (path string)
  "Appends STRING to a file PATH."
  (append-to-file string nil path))
(defun my/write-to-file (path string)
  "Writes STRING to a file PATH."
    (with-temp-file path
    (insert string)))
(defun my/initialize-system ()
  "Initializes user configuration files."
  (interactive)
  (message "my/init")
  (if (file-exists-p "~/.bashrc")       ; Appends if necessary.
      (let* ((s                         ; file data
              (my/string-from-file "~/.bashrc"))
             (contains                  ; if already configured
              (string-match-p (regexp-quote "bashrc_my")
                              s)))
        (if contains
            (message "The string already exists.")
          (progn
            (message "Appending the string.")
            (my/append-to-file "~/.bashrc"
                               "\n. ~/.bashrc_my\n"))))
    (message "~/.bashrc not exist."))
  (my/write-to-file "~/.bashrc_my" my/.bashrc_my) ; Inits file.
  (message "Done."))

;;; bashrc ...
(setq my/.bashrc_my "# This file is '~/.bashrc_my'
#
# Usage:
# echo '. ~/.bashrc_my' >> ~/.bashrc

# emacs --no-window-system
alias e='emacs -nw'

# syntax highlighting
alias c='pygmentize -O style=monokai -f console256 -g'

# Goes up multiple directory levels at once.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias .........='cd ../../../../../../../..'
alias ..........='cd ../../../../../../../../../'
")

(quote
 (my/apt
  sudo apt install clisp                ; # GNU Common Lisp programming language
  sudo apt install clojure              ; # Clojure programming language
  sudo apt install default-jdk          ; # Java Development Kit
  sudo apt install dvipng               ; # DVI to PNG translation tool
  sudo apt install emacs                ; # Emacs text editor
  ;; sudo apt install fonts-takao          ; # Takao family Japanese fonts
  sudo apt install gimp                 ; # GIMP graphics editor
  sudo apt install git                  ; # Git version-control system
  sudo apt install gitk                 ; # Git GUI tool
  sudo apt install gnome-tweaks         ; # configuration utility
  sudo apt install haskell-platform     ; # Haskell programming language
  sudo apt install ibus-mozc            ; # Japanese input method by Google
  sudo apt install leiningen            ; # Clojure bulid tool
  sudo apt install libgtk-3-dev         ; # development files for the GTK+ library
  sudo apt install mongodb              ; # MongoDB NoSQL database
  sudo apt install ncdu                 ; # disk usage utility using ncurses CUI
  sudo apt install open-cobol           ; # a.k.a. GnuCOBOL; a COBOL implementation
  sudo apt install pdfmod               ; # GUI PDF editor
  sudo apt install python-pygments      ; # syntax coloring tool
  sudo apt install python3-sphinx       ; # Sphinx documentation tool
  sudo apt install ruby                 ; # Ruby programming language
  sudo apt install sagemath             ; # SageMath algebra system
  sudo apt install sbcl                 ; # Steel Bank Common Lisp programming language
  sudo apt install trash-cli            ; # trash command
  sudo apt install tree                 ; # lists directories
  sudo apt install xclip                ; # CUI-clipboard interaction
  ))

(quote
 (setq
  (Firefox
   (browser.urlbar.autocomplete.enabled) nil)
  (LibreOffice
   (Language Settings
             (Languages
              (Asian) Japanese)))
  (Ubuntu
   (gnome-terminal
    (Show menubar by default in new terminals) nil
    (Text
     (Terminal bell) nil))
   (gnome-tweaks
    (Desktop
     (Trash) nil)
    (Keyboard and Mouse
              (Additional Layout Options
                          (Ctrl position
                                (Caps Lock as Ctrl) t))
              ;; (Emacs Input) t ; annoying
              )
    (Top Bar
         (Date) t
         (Seconds) t))
   (Nautilus
    (Preference
     (Behavior
      (Executable Text Files
                  (Ask what to do) t)))))))
