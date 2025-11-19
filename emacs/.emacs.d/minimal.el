;;; init.el --- Productive & IDE-like Emacs (built-in only) -*- lexical-binding: t; -*-

;; Cleanup

(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(setq ring-bell-function 'ignore)
(set-face-attribute 'default nil :height 110)
(setq-default line-spacing 2)

(global-display-line-numbers-mode t)
(column-number-mode t)
(global-hl-line-mode 1)

;; Basics

(fset 'yes-or-no-p 'y-or-n-p)
(setq backup-directory-alist `(("." . ,(expand-file-name "backups/" user-emacs-directory)))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
(global-auto-revert-mode t)
(save-place-mode 1)
(show-paren-mode 1)
(delete-selection-mode 1)
(electric-pair-mode 1)
(setq show-paren-delay 0)

;; Search

(fido-mode 1)
(fido-vertical-mode 1)

(with-eval-after-load 'icomplete
  (setq icomplete-compute-delay 0
        icomplete-delay-completions-threshold 0
        icomplete-max-delay-chars 0
        icomplete-show-matches-on-no-input t
        icomplete-in-buffer t))

(savehist-mode 1)
(setq isearch-lazy-highlight t
      isearch-wrap-pause t)

;; Files and Projects
(recentf-mode 1)
(setq recentf-max-menu-items 20
      recentf-max-saved-items 200)

(setq bookmark-save-flag 1)

;; Built-in project management
(setq project-switch-commands
      '((project-find-file "Find file")
        (project-find-dir "Find directory")
        (project-dired "Dired")
        (project-eshell "Eshell")))
(global-set-key (kbd "C-x p") 'project-switch-project)
(global-set-key (kbd "C-x f") 'project-find-file)
(global-set-key (kbd "C-x e") 'project-eshell)


(setq-default indent-tabs-mode nil
              tab-width 4
              fill-column 80)
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Highlight TODO/FIXME/NOTE in comments
(defun my/highlight-todo ()
  "Highlight TODO/FIXME/NOTE in comments."
  (font-lock-add-keywords
   nil '(("\\<\\(TODO\\|FIXME\\|NOTE\\):" 1 font-lock-warning-face t))))
(add-hook 'prog-mode-hook 'my/highlight-todo)

;; Coding aids
(add-hook 'prog-mode-hook 'flymake-mode)
(add-hook 'prog-mode-hook 'eldoc-mode)
(add-hook 'prog-mode-hook 'xref-etags-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'imenu-add-menubar-index)

;; Electric helpers
(electric-indent-mode 1)
(electric-pair-mode 1)
(show-paren-mode 1)

;; Function name in mode line
(which-function-mode 1)


(windmove-default-keybindings)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "C-x b") 'switch-to-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(global-set-key (kbd "C-c i") 'imenu)

;; Xref navigation
(global-set-key (kbd "M-.") 'xref-find-definitions)
(global-set-key (kbd "M-,") 'xref-pop-marker-stack)
(global-set-key (kbd "M-?") 'xref-find-references)

;; Org

(setq org-startup-indented t
      org-hide-leading-stars t
      org-return-follows-link t
      org-log-done 'time
      org-directory "~/org/"
      org-default-notes-file (expand-file-name "notes.org" org-directory)
      org-agenda-files (list (expand-file-name "tasks.org" org-directory)
                             (expand-file-name "notes.org" org-directory)))

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; Documentations

(global-set-key (kbd "C-h f") 'describe-function)
(global-set-key (kbd "C-h v") 'describe-variable)
(global-set-key (kbd "C-h k") 'describe-key)
(global-set-key (kbd "C-h .") 'eldoc-doc-buffer)

(setq eldoc-echo-area-use-multiline-p t)

;; QOL

(auto-save-visited-mode 1)
(display-time-mode 1)
(setq display-time-24hr-format 1)
(setq confirm-kill-processes nil
      create-lockfiles nil)


;; Use Iosevka if available, else fall back to default
(cond
 ((find-font (font-spec :name "Iosevka"))
  (set-face-attribute 'default nil
                      :font "Iosevka"
                      :height 180
                      :weight 'regular))
 (t
  (set-face-attribute 'default nil
                      :height 110
                      :weight 'regular)))

;; Use Iosevka for fixed-pitch and variable-pitch faces
(when (find-font (font-spec :name "Iosevka"))
  (set-face-attribute 'fixed-pitch nil :font "Iosevka")
  (set-face-attribute 'variable-pitch nil :font "Iosevka Aile"))

;; Enable Eglot for Emacs Lisp and other languages automatically
(require 'eglot)

;; Define which major modes should start Eglot
(add-hook 'emacs-lisp-mode-hook #'eglot-ensure)
(add-hook 'lisp-interaction-mode-hook #'eglot-ensure)

;; Use completion-at-point integration (built-in)
(setq completion-category-defaults nil)
(setq completion-cycle-threshold 1)

;; Optional: show documentation in echo area
(add-hook 'eglot-managed-mode-hook #'eldoc-mode)

;; Better completion feedback in minibuffer/Fido
(setq eglot-report-progress nil)  ;; disables noisy messages
;; Themes
(load-theme 'modus-vivendi-tritanopia t)
;; Meow
(add-to-list 'load-path (concat default-directory "meow"))
(load-library "meow")
(defun meow-setup ()
  (setq meow-cheatsheet-physical-layout meow-cheatsheet-physical-layout-iso)
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwertz)

  (meow-thing-register 'angle
                       '(pair (";") (":"))
                       '(pair (";") (":")))

  (setq meow-char-thing-table
        '((?f . round)
          (?d . square)
          (?s . curly)
          (?a . angle)
          (?r . string)
          (?v . paragraph)
          (?c . line)
          (?x . buffer)))

  (meow-leader-define-key
    ;; Use SPC (0-9) for digit arguments.
    '("1" . meow-digit-argument)
    '("2" . meow-digit-argument)
    '("3" . meow-digit-argument)
    '("4" . meow-digit-argument)
    '("5" . meow-digit-argument)
    '("6" . meow-digit-argument)
    '("7" . meow-digit-argument)
    '("8" . meow-digit-argument)
    '("9" . meow-digit-argument)
    '("0" . meow-digit-argument)
    '("-" . meow-keypad-describe-key)
    '("_" . meow-cheatsheet))

  (meow-normal-define-key
    ;; expansion
    '("0" . meow-expand-0)
    '("1" . meow-expand-1)
    '("2" . meow-expand-2)
    '("3" . meow-expand-3)
    '("4" . meow-expand-4)
    '("5" . meow-expand-5)
    '("6" . meow-expand-6)
    '("7" . meow-expand-7)
    '("8" . meow-expand-8)
    '("9" . meow-expand-9)
    '("ä" . meow-reverse)

    ;; movement
    '("i" . meow-prev)
    '("k" . meow-next)
    '("j" . meow-left)
    '("l" . meow-right)

    '("z" . meow-search)
    '("-" . meow-visit)

    ;; expansion
    '("I" . meow-prev-expand)
    '("K" . meow-next-expand)
    '("J" . meow-left-expand)
    '("L" . meow-right-expand)

    '("u" . meow-back-word)
    '("U" . meow-back-symbol)
    '("o" . meow-next-word)
    '("O" . meow-next-symbol)

    '("a" . meow-mark-word)
    '("A" . meow-mark-symbol)
    '("s" . meow-line)
    '("S" . meow-goto-line)
    '("w" . meow-block)
    '("q" . meow-join)
    '("g" . meow-grab)
    '("G" . meow-pop-grab)
    '("m" . meow-swap-grab)
    '("M" . meow-sync-grab)
    '("p" . meow-cancel-selection)
    '("P" . meow-pop-selection)

    '("x" . meow-till)
    '("y" . meow-find)

    '("," . meow-beginning-of-thing)
    '("." . meow-end-of-thing)
    '(";" . meow-inner-of-thing)
    '(":" . meow-bounds-of-thing)

    ;; editing
    '("d" . meow-kill)
    '("f" . meow-change)
    '("t" . meow-delete)
    '("c" . meow-save)
    '("v" . meow-yank)
    '("V" . meow-yank-pop)

    '("e" . meow-insert)
    '("E" . meow-open-above)
    '("r" . meow-append)
    '("R" . meow-open-below)

    '("h" . undo-only)
    '("H" . undo-redo)

    '("b" . open-line)
    '("B" . split-line)

    '("ü" . indent-rigidly-left-to-tab-stop)
    '("+" . indent-rigidly-right-to-tab-stop)

    ;; ignore escape
    '("<escape>" . ignore)))

(require 'meow)
(meow-setup)
(meow-global-mode 1)
(provide 'init)
;;; init.el ends here
