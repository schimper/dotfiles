(setq user-full-name "Thomas Schimper")
(setq user-email-address "thomasschimper94@gmail.com")
;; straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
;; integration with use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(straight-use-package 'org)
;; QoL from Witchmacs
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)
(show-paren-mode 1)
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(delete-selection-mode 1)
(global-unset-key (kbd "C-z"))
(make-directory "~/.emacs_backups/" t)
(make-directory "~/.emacs_autosave/" t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs_autosave/" t))
	  backup-directory-alist '(("." . "~/.emacs_backups/"))
	  x-select-enable-clipboard t
	  auto-save-default nil
	  scroll-conservatively 100
	  ring-bell-function 'ignore
	  sentence-end-double-space nil
	  require-final-newline t
	  frame-inhibit-implied-resize t
	  pixel-scroll-precision-mode t
	  show-trailing-whitespace t
	  auto-window-vscroll nil
	  custom-file "~/.emacs.d/custom")
(setq-default tab-width 4)
(setq-default standard-indent 4)
(setq c-basic-offset tab-width)
(setq-default electric-indent-inhibit t)
(setq-default indent-tabs-mode t)
(setq backward-delete-char-untabify-method 'nil)
;; native comp
(setq comp-async-report-warnings-errors nil
      native-comp-async-report-warnings-errors nil)

(global-prettify-symbols-mode t)
(setq electric-pair-pairs '(
                            (?\{ . ?\})
                            (?\( . ?\))
                            (?\[ . ?\])
                            (?\" . ?\")
                            ))
(electric-pair-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq vc-follow-symlinks t)
(global-hl-line-mode t)
(setq use-package-always-defer t)
;; autoupdate
(use-package auto-package-update
  :defer nil
  :straight t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))
;; ef-themes
(use-package ef-themes
  :straight t
  :init
  (if (daemonp)
      (add-hook 'after-make-frame-functions
                (lambda (frame)
                  (select-frame frame)
                  (load-theme 'ef-reverie :no-confirm)))
    (load-theme 'ef-reverie :no-confirm)))
;; dashboard
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (agenda . 5))
        dashboard-icon-type 'kind-icon
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-set-navigator t
        dashboard-center-content t
        dashboard-startup-banner "~/.emacs.d/logo/gnuc.svg"
        dashboard-banner-logo-title "I want to be a stronger, kinder person"
		initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name))))
;; fonts
(add-to-list 'default-frame-alist
             '(font . "Iosevka-15"))
;; guru
(use-package guru-mode
  :straight t
  :diminish guru-mode
  :init
  (guru-global-mode +1))
;; golden-ratio
(use-package golden-ratio
  :diminish golden-ratio-mode
  :init (golden-ratio-mode))
;; padding
(use-package spacious-padding
  :init (spacious-padding-mode))
;; modeline
(use-package doom-modeline
  :straight t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 40
        doom-modeline-enable-word-count nil))
;; meow modal editing
(use-package meow
  :straight t
  :init
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
     '("'" . meow-reverse)

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
	 
	 '("]" . meow-undo)
	 '("}" . meow-undo-in-selection)
	 
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
  (meow-global-mode))
;; ob-mermaid
(use-package ob-mermaid
  :straight t
  :config
  (setq ob-mermaid-cli-path "/home/thomas/.local/bin/mmdc"))

;; pdf-tools
(use-package pdf-tools
  :straight t
  :init
  (pdf-tools-install :no-query)
  (add-hook 'pdf-view-mode-hook (lambda ()
                                  (progn
                                    (pdf-view-themed-minor-mode)
                                    (pdf-view-fit-page-to-window))))
  :config
  ;; open pdfs scaled to fit page
  (setq-default pdf-view-display-size 'fit-page)
  ;; automatically annotate highlights
  (setq pdf-annot-activate-created-annotations t)
  ;; use normal isearch
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward))
;; htmlize
(use-package htmlize
  :straight t)
;; diminish
(use-package diminish
  :straight t)
;; which-key
(use-package which-key
  :straight t
  :diminish which-key-mode
  :init
  (which-key-mode))
;; swiper search
(use-package swiper
  :straight t
  :bind ("C-s" . 'swiper))
;; beacon
(use-package beacon
  :straight t
  :diminish beacon-mode
  :init
  (beacon-mode 1))
;; avy
(use-package avy
  :straight t
  :bind
  ("M-s" . avy-goto-char))
;; marginalia
(use-package marginalia
  :straight t
  :init
  (marginalia-mode))
;; vertico
(use-package vertico
  :straight t
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Grow and shrink the Vertico minibuffer
  (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(savehist-mode +1)
;; Configure directory extension.
(use-package vertico-directory
  :after vertico
  :straight nil
  :straight nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))
;;orderless
(use-package orderless
  :straight t
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))
;; set completion style
(setq completion-styles '(substring orderless basic)
	  read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)
;; async
(use-package async
  :straight t
  :init
  (dired-async-mode 1))
;; magit
(use-package magit
  :bind (("C-c m" . magit-status))
  :straight t)
;; code
(use-package company
  :straight t
  :diminish (meghanada-mode company-mode irony-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "SPC") #'company-abort)
  :hook
  ((java-mode c-mode c++-mode) . company-mode))
;; snippets
(use-package yasnippet
  :straight t
  :diminish yas-minor-mode
  :hook
  ((c-mode c++-mode) . yas-minor-mode)
  :config
  (yas-reload-all))
(use-package yasnippet-snippets
  :straight t)
;; lsp integration
(use-package lsp-bridge ;;pip3 install epc orjson sexpdata six setuptools paramiko rapidfuzz
  :straight '(lsp-bridge :type git :host github :repo "manateelazycat/lsp-bridge"
						 :files (:defaults "*.el" "*.py" "acm" "core" "langserver" "multiserver" "resources")
						 :build (:not compile))
  :init
  (global-lsp-bridge-mode))
;; projectile
(use-package projectile
  :diminish projectile-mode
  :straight t
  :init
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-project-search-path '("~/Documents/studium" "~/.dotfiles")))
;; rainbow delim
(use-package rainbow-delimiters
  :straight t
  :hook
  (prog-mode . rainbow-delimiters-mode))
;; aggressive indent
(use-package aggressive-indent
  :hook ((c-mode . aggressive-indent-mode)
         (c++-mode . aggressive-indent-mode)
         (java-mode . aggressive-indent-mode)
		 (elisp-mode . aggressive-indent-mode))
  :config
  (add-to-list 'aggressive-indent-excluded-modes 'python-mode))
(use-package edit-indirect
  :straight t)
;; racket
(use-package racket-mode
  :straight t)
(use-package ob-racket
  :ensure t
  :straight (:type git :host github :repo "hasu/emacs-ob-racket"))

;; Org-Mode
(use-package org
  :straight nil
  :bind (([f3] . (lambda () (interactive) (org-latex-export-to-pdf t))))
  :config
  (define-key global-map "\C-cc" 'org-capture)
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" (lambda
                                   ()
                                   (interactive)
                                   (org-agenda-list 1)))
  (add-hook 'emacs-startup-hook
            (lambda ()
              (org-agenda-list)))
  (setq org-default-notes-file (concat org-directory "/notes.org")
        org-highlight-latex-and-related '(native script)
        org-use-speed-commands t
        org-export-in-background nil
        tex-fontify-script nil
        org-capture-templates '(("j"
                                 "Journal Entry"
                                 entry
                                 (file+olp+datetree
                                  "~/Org/journal.org")
                                 "* %?"
                                 :empty-lines 1)
                                ("t"
                                 "Tagesplanung"
                                 entry
                                 (file+olp+datetree "~/Org/gtd.org" "Aufgaben")
                                 "* TODO %?\n SCHEDULED: %(org-insert-time-stamp
                                     (org-read-date nil t)) \n  %i\n"))
        org-format-latex-options (plist-put org-format-latex-options :scale 1.7)
        org-ellipsis "..."
        org-log-done 'time
        org-agenda-start-with-log-mode t
        org-agenda-files '("~/Org")
        org-confirm-babel-evaluate nil
        org-clock-out-remove-zero-time-clocks t
        org-clock-clocked-in-display 'both
        org-ditaa-jar-path "/usr/share/ditaa/lib/ditaa.jar"
        org-todo-keywords
        '((sequence "TODO(t)" "HOLD(h)" "ACTIVE(a)" "|" "DONE(d)"))
        org-agenda-custom-commands
        '(("d" "Sorted TODO list"
           ((agenda "" ((org-agenda-overriding-header "Today's Schedule")))
            (tags-todo "+TODO=\"DOING\""
                       ((org-agenda-overriding-header "ACTIVE")
                        (org-agenda-sorting-strategy '(priority-up))))
            (tags-todo "+TODO=\"TODO\""
                       ((org-agenda-overriding-header "TODOs")
                        (org-agenda-sorting-strategy '(priority-up))))
            (tags-todo "+TODO=\"DOING\""
                       ((org-agenda-overriding-header "HOLD")
                        (org-agenda-sorting-strategy '(priority-up))))
            (tags-todo "+TODO=\"DONE\""
                       ((org-agenda-overriding-header "COMPLETED")
                        (org-agenda-sorting-strategy '(priority-down)))))))))
(setf org-blank-before-new-entry
      '((heading . nil) (plain-list-item . qnil)))
;; Custom NoStarch
(org-babel-do-load-languages
 'org-babel-load-languages
 '((org . t)
   (ditaa . t)
   (latex . t)
   (dot . t)
   (emacs-lisp . t)
   (gnuplot . t)
   (screen . nil)
   (shell . t)
   (sql . nil)
   (sqlite . t)
   (mermaid . t)
   (racket . t)))
(setq
 org-latex-logfiles-extensions (quote ("lof"
                                       "lot"
                                       "tex~"
                                       "aux"
                                       "idx"
                                       "log"
                                       "out"
                                       "toc"
                                       "nav"
                                       "snm"
                                       "vrb"
                                       "dvi"
                                       "fdb_latexmk"
                                       "blg"
                                       "brf"
                                       "fls"
                                       "entoc"
                                       "ps"
                                       "spl"
                                       "bbl")))
(require 'org-tempo)
;; make available "org-bullet-face" such that I can control the font size individually
(tempo-define-template "marginfigure" ; Marginfigure for Tufte-Handout
                       '("#caption:" p " label:" n
                         "#+begin_marginfigure" n
                         "#+attr_latex: :scale 1" n
                         r n
                         "#+end_marginfigure")
                       "<mf"
                       "Inserts a Marginfigure"
                       'org-tempo-tags)
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

(use-package org-ref
  :after org
  :straight t
  :init
  (require 'org-ref)
  (add-hook 'org-mode-hook
			(lambda ()
              (local-set-key (kbd "M-]") 'org-ref-insert-link))
			(setq bibtex-completion-bibliography
				  '("~/Documents/studium/MA/pyspark_rdf_fca/text/bibliography.bib"))))
(use-package cdlatex
  :after org
  :init
  (setq
   cdlatex-paired-parens "$[{"
   cdlatex-math-symbol-alist '(
							   (?% ("\\widehat{?}" "\\hat{?}"))
							   (?' ("^{\\prime}" "\\prime"))
							   (?* ("\\times" "\\otimes" "\\star"))
							   (?+ ("+" "\\oplus"))
							   (?- ("\\vdash" "\\setminus" "\\triangle"))
							   (?. ("\\sq" "\\circ" "\\cdot"))
							   (?0 ("\\emptyset" "\\circ"))
							   (?\; ("\\col"))
							   (?< ("\\leftarrow" "\\leftharpoonup" "\\xleftarrow"))
							   (?> ("\\rightarrow" "\\rightharpoonup" "\\xrightarrow"))
							   (?B ("\\bullet"))
							   (?C ("\\widecheck{?}" "\\check{?}"))
							   (?F ("\\Phi" "\\Varphi"))
							   (?q ("?_{1},?_{2},\\dots,?_{n}"))
							   (?M ("\\begin{bsmallmatrix}?\\end{bsmallmatrix}"))
							   (?P ("\\Prod{?}" "\\Pi" "\\partial"))
							   (?S ("\\Sigma_{?}" "\\Sum" "\\arcsin"))
							   (?\"("^{\\prime\\prime}" "\\prime\\prime"))
							   (?a ("\\alpha" "\\cap" "\\sqcap"))
							   (?c ("\\cat{?}" "\\catn{?}"))
							   (?e ("\\varepsilon" "\\epsilon" "\\exp{?}"))
							   (?i ("\\iota" "\\in"))
							   (?j ("{\\id^{h}}_{?}" "{\\id^{v}}_{?}"))
							   (?r ("\\rho" "\\varrho" "\\restrict{?}"))
							   (?u ("\\upsilon" "\\cup" "\\sqcup"))
							   (?{ ("\\subseteq" "\\subsetneq"))
							   (?} ("\\supseteq" "\\supsetneq"))
							   (?p ("\\prec")))
   cdlatex-math-modify-alist '(
							   (46 "\\dot" nil t t nil)
							   (58 "\\ddot" nil t t nil)
							   (126 "\\tilde" nil t t nil)
							   (78 "\\widetilde" nil t t nil)
							   (94 "\\hat" nil t t nil)
							   (72 "\\widehat" nil t t nil)
							   (45 "\\bar" nil t t nil)
							   (84 "\\overline" nil t nqil nil)
							   (95 "\\underline" nil t nil nil)
							   (123 "\\overbrace" nil t nil nil)
							   (125 "\\underbrace" nil t nil nil)
							   (62 "\\vec" nil t t nil)
							   (47 "\\grave" nil t t nil)
							   (92 "\\acute" nil t t nil)
							   (118 "\\check" nil t t nil)
							   (117 "\\breve" nil t t nil)
							   (109 "\\mbox" nil t nil nil)
							   (99 "\\mathcal" nil t nil nil)
							   (114 "\\mathrm" "\\textrm" t nil nil)
							   (105 "\\mathit" "\\textit" t nil nil)
							   (108 nil "\\textsl" t nil nil)
							   (98 "\\mathbb" "\\textbb" t nil nil)
							   (101 "\\mathem" "\\emph" t nil nil)
							   (121 "\\mathtt" "\\texttt" t nil nil)
							   (102 "\\mathsf" "\\textsf" t nil nil)
							   (48 "\\textstyle" nil nil nil nil)
							   (49 "\\displaystyle" nil nil nil nil)
							   (50 "\\scriptstyle" nil nil nil nil)
							   (51 "\\scriptscriptstyle" nil nil nil nil))))
(use-package auctex
  :after org
  :straight t)
;; latex specific
(add-to-list 'org-latex-packages-alist '("" "minted"))
(add-to-list 'org-latex-packages-alist '("dvipsnames" "xcolor"))
(add-to-list 'org-latex-packages-alist '("" "booktabs"))
(setq org-latex-listings 'minted
      org-latex-minted-options '(("fontsize" "\\footnotesize")
								 ("frame" "lines")
                                 ("bgcolor=white")
								 ("framesep=2mm")
								 ("baselinestretch=1.2")
								 ("style=xcode")
								 ("linenos"))
      org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))
(require 'ox-latex)
(add-to-list 'org-latex-classes
             '("cnostarch"
               "\\documentclass{cnostarch}"
               ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
(add-to-list 'org-latex-classes
             '("tuftebook"
               "\\documentclass{tufte-book}\n
                           \\usepackage{xcolor}
                           \\usepackage{amssymb}
                           \\usepackage{gensymb}
                           \\usepackage{nicefrac}
                           \\usepackage{units}
                           \\definecolor{bg}{RGB}{22,43,58}"
               ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

(add-to-list 'org-latex-classes
             '("tuftehandout"
               "\\documentclass[nofonts,justified]{tufte-handout}\n"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))
(add-to-list 'org-latex-classes
             '("memoir"
               "\\documentclass{memoir}\n
                \\usepackage[top=1in,bottom=1in]{geometry}
                \\usepackage[ngerman]{babel}
                \\usepackage{blindtext}
                \\usepackage{graphicx}
                \\usepackage[lf]{Baskervaldx}
                \\let\\Bbbk\\relax
                \\usepackage[cal=boondoxo]{mathalfa}
                \\chapterstyle{veelo}
                \\usepackage[dvipsnames]{xcolor}
                \\usepackage[defaultlines=2,all]{nowidow}
                \\renewcommand*{\\chapnamefont}{\\scshape\\LARGE\\flushright}
                \\renewcommand*{\\chaptitlefont}{\\LARGE\\scshape}
                \\renewcommand\\thechapter{\\Roman{chapter}}
                \\renewcommand*{\\chapnumfont}{\\Large\\scshape}
                \\renewcommand*{\\printchapternum}{%
                \\makebox[2pt][l]{\\hspace{.15em}%
                \\resizebox{!}{0.7\\beforechapskip}{\\chapnumfont \\thechapter}%
                \\hspace{.2em}%
                \\rule{5\\beforechapskip}{1.3\\beforechapskip}%
                }}%
             \\usepackage[babel=true,protrusion=true,expansion=true,spacing=true,tracking=smallcaps,kerning=true]{microtype}
             \\usepackage{fancyhdr}
             \\usepackage{lettrine}
             \\usepackage{GoudyIn}
             \\renewcommand{\\LettrineFontHook}{\\GoudyInfamily{}}
             \\def\\drop #1#2 {% note the space before {
               \\lettrine[lines=4]{\\color{Maroon}{#1}}{#2} % a trailing space
             }
             \\usepackage[
                 babel=true,
                 protrusion=true,
                 expansion=true,
                 spacing=true,
                 tracking=smallcaps,
                 kerning=true
             ]{microtype}
             \\fancyhf{}
             \\renewcommand{\\headrulewidth}{0pt}
             \\fancyhead[EC]{\\rightmark}
             \\fancyhead[OC]{\\leftmark}
             \\fancyfoot[C]{\\thepage}
             \\newcommand{\\shorttoc}{\\setcounter{tocdepth}{0}\\renewcommand{\\contentsname}{Overview}\\tableofcontents\\thispagestyle{empty}}
             \\newcommand{\\longtoc}{\\setcounter{tocdepth}{2}\\renewcommand{\\contentsname}{Detailed
             Overview}\\tableofcontents\\thispagestyle{empty}}
             \\aliaspagestyle{chapter}{empty}
             \\renewcommand{\\partnumberlinebox}[2]{#2 }
             \\renewcommand{\\chapternumberlinebox}[2]{#2 }
             \\usepackage{svg}
             \\usepackage{inconsolata}
             \\usepackage[ruled,vlined,linesnumbered, algochapter]{algorithm2e}
             \\def\\algorithmautorefname{Algorithm}
             \\def\\listingautorefname{Listing}
             \\usepackage[style=alphabetic]{biblatex}

             "
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;; Report
(add-to-list 'org-latex-classes
             '("report"                          ;class-name
               "\\documentclass[10pt]{article}
      \\RequirePackage[utf8]{inputenc}
      \\RequirePackage[T1]{fontenc}
      \\RequirePackage{setspace}              %%pour le titre
      \\RequirePackage{graphicx}          %% gestion des images
      \\RequirePackage[dvipsnames,table]{xcolor}	%% gestion des couleurs
      \\RequirePackage{array}		%% gestion améliorée des tableaux
      \\RequirePackage{calc}              %% syntaxe naturelle pour les calculs
      \\RequirePackage{enumitem}          %% pour les listes numérotées
      \\RequirePackage[footnote]{snotez}	%% placer les notes de pied de page sur le coté
      \\RequirePackage{microtype,textcase}
      \\RequirePackage{titlesec}
      \\RequirePackage{booktabs}
      \\RequirePackage{amsmath,
              amssymb,
              amsthm}             %% For including math equations, theorems, symbols, etc
      \\RequirePackage[toc]{multitoc}
      \\RequirePackage[a4paper,left=15mm,
      top=15mm,headsep=2\\baselineskip,
      textwidth=132mm,marginparsep=8mm,
      marginparwidth=40mm,textheight=58\\baselineskip,
      headheight=\\baselineskip]{geometry}
      \\microtypesetup{protrusion=true,final}
      %%----------------------------------------------------------------------------------------
      %%	HEADERS
      %%----------------------------------------------------------------------------------------
      \\makeatletter
      \\newenvironment{fullpage}
          {\\noindent\\begin{minipage}
          {\\textwidth+\\marginparwidth+\\marginparsep}\\smallskip}
          {\\end{minipage}
      %%\\vspace{2mm}
      }
      %% COLOR %<--------------------------------------------------------->%
      \\RequirePackage{xcolor}
      %% Contrast colours
      \\definecolor{mdgreen}{HTML}{A4C21F}
      %% Additional colours
      \\definecolor{mdgrey}{HTML}{A19589}
      \\colorlet{mdgray}{mdgrey}
      \\definecolor{mdlightgrey}{HTML}{D8D0C7}
      \\colorlet{mdlightgray}{mdlightgrey}
      %% DOC %<----------------------------------------------------------->%
      \\ProcessOptions\\relax
      %% Command to provide alternative translations
      \\newcommand{\\UseLanguage}[3]{
         \\iflanguage{french}{#1}{}
         \\iflanguage{english}{#2}{}
         \\iflanguage{german}{#3}{}
      }
      %% This} separating line is used across several documents,
      \\newcommand{\\@separator}{%%
       %% To make sure we have spacing on both sides, make an invisible rule, 2X tall
        \\rule{0ex}{2ex}%%
         %% Place the dashed rule 1X high
        \\textcolor{mdgray}{\\rule[1ex]{\\textwidth}{0.25pt}}%%
      }
      %% LABEL %<-------------------------------------------------------->%
      %% Standard style for labels, small and bold
      \\newcommand{\\@labeltext}{\\large\\scshape}
      \\newcommand*{\\@approvedlabel}{\\UseLanguage{APPROUVE PAR}{APPROVED BY}{FREIGEGEBEN VON}}
      \\newcommand*{\\@approved}{Set with \\texttt{\textbackslash approved\\{\\}}}
      \\newcommand*{\\approved}{\\renewcommand*{\\@approved}}
      \\newcommand*{\\@authorlabel}{\\UseLanguage{Auteur(s)}{Author(s)}{Author(en)}}
      \\newcommand*{\\@Authorlabel}{\\UseLanguage{AUTEUR(S)}{AUTHOR(S)}{AUTHOR(EN)}}
      \\newcommand*{\\@checkedlabel}{\\UseLanguage{VERIFIE PAR}{CHECKED BY}{VERIFIZIERT DURCH}}
      \\newcommand*{\\@checked}{Set with \\texttt{\textbackslash checked\\{\\}}}
      \\newcommand*{\\checked}{\\renewcommand*{\\@checked}}
      \\newcommand*{\\@datelabel}{\\UseLanguage{DATE}{DATE}{DATUM}}
      \\newcommand*{\\@absentlabel}{\\UseLanguage{ABSENT}{ABSENT}{ABWESEND}}
      \\newcommand*{\\@excusedlabel}{\\UseLanguage{EXCUSE}{EXCUSED}{ENTSCHULDIGT}}
      \\newcommand*{\\@durationlabel}{\\UseLanguage{DUREE}{DURATION}{DAUER}}
      \\newcommand*{\\@duration}{Set with \\texttt{\\textbackslash duration\\{\\}}}
      \\newcommand*{\\duration}{\\renewcommand*{\\@duration}}
      \\newcommand*{\\@initiatorlabel}{\\UseLanguage{INITIATEUR}{INITIATED BY}{INITIATOR}}
      \\newcommand*{\\@initiator}{Set with \\texttt{\\textbackslash initiator\\{\\}}}
      \\newcommand*{\\initiator}{\\renewcommand*{\\@initiator}}
      \\newcommand*{\\@participantlabel}{\\UseLanguage{PARTICIPANT}{PARTICIPANT}{TEILNEHMER}}
      \\newcommand*{\\@participantslabel}{\\UseLanguage{PARTICIPANTS}{PARTICIPANTS}{TEILNEHMER}}
      \\newcommand*{\\@preparedlabel}{\\UseLanguage{PREPARE PAR}{PREPARED BY}{VORBEREITET VON}}
      \\newcommand*{\\@prepared}{Set with \\texttt{\\textbackslash prepared\\{\\}}}
      \\newcommand*{\\prepared}{\\renewcommand*{\\@prepared}}
      \\newcommand*{\\@presentlabel}{\\UseLanguage{PRESENT}{PRESENT}{ANWESEND}}
      \\newcommand*{\\@projectlabel}{\\UseLanguage{PROJET}{PROJECT}{PROJEKT}}
      \\newcommand*{\\@project}{Set with \\texttt{\\textbackslash project\\{\\}}}
      \\newcommand*{\\project}{\\renewcommand*{\\@project}}
      \\newcommand*{\\@referencelabel}{\\UseLanguage{REFERENCE}{REFERENCE}{REFERENCE}}
      \\newcommand*{\\@reportlabel}{\\UseLanguage{Rapport}{Report}{Bericht}}
      \\newcommand*{\\@reportnumberlabel}{\\UseLanguage{RAPPORT N°}{REPORT NUMBER}{BERICHT NUMMER}}
      \\newcommand*{\\@reportnumber}{Set with \\texttt{\\textbackslash reportnumber\\{\\}}}
      \\newcommand*{\\reportnumber}{\\renewcommand*{\\@reportnumber}}
      \\newcommand*{\\@wheremeeting}{Set with \\texttt{\\textbackslash wheremeeting\\{\\}}}
      \\newcommand*{\\wheremeeting}{\\renewcommand*{\\@wheremeeting}}
      \\newcommand*{\\@whenmeeting}{Set with \\texttt{\\textbackslash whenmeeting\\{\\}}}
      \\newcommand*{\\whenmeeting}{\\renewcommand*{\\@whenmeeting}}
      %% TASKS
      \\newcommand*{\\@tasklistlabel}{\\UseLanguage{Liste de tâches}{Task List}{Aufgaben}}
      \\newcommand*{\\@tasknumberlabel}{\\#}
      \\newcommand*{\\@tasklabel}{\\UseLanguage{TACHE}{TASK}{Aufgabe}}
      \\newcommand*{\\@duelabel}{\\UseLanguage{DATE D'ECHEANCE}{DUE DATE}{ERLEDIGUNGSDATUM}}
      \\newcommand*{\\@responsiblelabel}{\\UseLanguage{RESPONSABLE}{RESPONSIBLE}{VERANTWORTLICH}}
      %% MINUTES %<------------------------------------------------------->%
      \\ProcessOptions\\relax
      \\PassOptionsToPackage{table}{xcolor}
      \\renewcommand*{\\@authorlabel}{\\UseLanguage{ECRIT PAR}{WRITTEN BY}{GESCHRIEBEN VON}}
      %% Setting up header and footer
      \\RequirePackage{fancyhdr,lastpage}
      \\pagestyle{fancy}
      %% Header
      \\renewcommand{\\headrulewidth}{0pt}
      %% Footer
      \\renewcommand{\\footrulewidth}{0pt}
      \\fancyfoot[c]{%%
        \\sffamily%%
        \\color{mdgray}
        \\@separator\\newline
        ~~%%
        \\begin{minipage}[c]{0.5\\textwidth}
          \\hspace*{3pt}\\small{\\textbf{\\@projectlabel}}\\newline
          \\hspace*{\\tabcolsep}\\@project
        \\end{minipage}%%
        \\hfill
        \\thepage\\ \\UseLanguage{de}{of}{von} \\pageref{LastPage}
        ~~\\newline
        \\@separator
      }
      %% The logo box.
      \\newcommand{\\@rlogo}{
        \\noindent
        \\scriptsize
        \\raggedleft
        \\setlength{\\parskip}{1ex}
        \\includegraphics[height=70px,width=70px,keepaspectratio]{\\@mainlogo}
      %%\\includegraphics[width=\\textwidth]{\\@mainlogo}
      }
      \\RequirePackage{xparse}
      \\newcommand{\\@participantstable}{}
      \\NewDocumentCommand \\participant { O{present} m }{
          \\g@addto@macro \\@participantstable {
              \\multicolumn{2}{l}{#2}
                & \\ifstrequal{#1}{present}    {$\\bullet$}{}
                & \\ifstrequal{#1}{absent}     {$\\bullet$}{}
                & \\ifstrequal{#1}{excused}    {$\\bullet$}{}\\\\
          }
      }
      \\RequirePackage{tabularx,ltxtable}
      \\newcommand{\\@tasktable}{}
      \\newcommand{\\tasklist}{%%
        \\section*{\\@tasklistlabel}
        \\vspace{-\\baselineskip}
        \\begin{longtable}{rp{0.55\\textwidth}p{0.2\\textwidth}l}
          \\multicolumn{4}{@{}c@{}}{\\@separator}\\\\*
          \\@labeltext \\@tasknumberlabel & \\@labeltext \\@tasklabel &
          \\@labeltext \\@responsiblelabel & \\@labeltext \\@duelabel\\\\*
          \\multicolumn{4}{@{}c@{}}{\\@separator}
          \\@tasktable\\\\*
        \\end{longtable}
      }
      \\newcounter{sinteftask}
      \\newcommand{\\task}[3]{%%
          \\g@addto@macro \\@tasktable {%%
            \\\\
            \\refstepcounter{sinteftask}\\thesinteftask & #1 & #2 & #3 \\\\*
            \\multicolumn{4}{@{}c@{}}{\\@separator}%%
          }%%
      }
      %% Recipient address and information colophon
      \\RequirePackage{colortbl,tabularx,setspace,rotating}
      \\newcommand{\\frontmatter}{%%
        \\sffamily%%
        \\noindent%%
        \\begin{minipage}[b]{0.7\\textwidth}
          \\setlength{\\parskip}{2ex}%%
          \\huge\\textbf\\@title
          %% ~ ensures \\ does not crash when \@wheremeeting is empty
          \\Large \\@wheremeeting~\\\\\\@whenmeeting
        \\end{minipage}
        \\hfill
        \\begin{minipage}[b]{0.20\\textwidth}
          %% Bring the colophon and address back up a bit
          \\vspace*{-25pt}
         \\@rlogo
        \\end{minipage}
        \\vspace{1ex}%%
        \\noindent%%
        \\@separator\\\\
        \\rowcolors{4}{}{mdlightgray}
        \\begin{tabularx}{\\textwidth}{XXccc}
          \\rowcolor{white}
            \\parbox{\\linewidth}{{\\@labeltext \\@initiatorlabel}\\\\\\@initiator}
            & \\parbox{\\linewidth}{{\\@labeltext \\@authorlabel}\\\\\\@author}
            & \\raisebox{-1cm}{\\begin{sideways}\\parbox{2cm}{\\raggedright\\@labeltext\\@presentlabel}\\end{sideways}}
            & \\raisebox{-1cm}{\\begin{sideways}\\parbox{2cm}{\\raggedright\\@labeltext\\@absentlabel}\\end{sideways}}
            & \\raisebox{-1cm}{\\begin{sideways}\\parbox{2cm}{\\raggedright\\@labeltext\\@excusedlabel}\\end{sideways}}\\\\
          \\rowcolor{white} \\multicolumn{5}{@{}c@{}}{\\@separator}\\\\
          \\rowcolor{white} \\@labeltext \\@participantslabel\\\\
          \\@participantstable
        \\end{tabularx}
        \\rowcolors{1}{}{} %% Back to normal
        \\@separator\\\\
        \\begin{minipage}{0.40\\textwidth}
          \\hspace*{3pt}{\\@labeltext\\@projectlabel}\\\\
          \\hspace*{\\tabcolsep}\\@project
        \\end{minipage}
        \\hfill
        \\begin{minipage}{0.3\\textwidth}
          {\\@labeltext \\@datelabel}\\\\
          \\@date
        \\end{minipage}
        \\begin{minipage}{0.2\\textwidth}
          {\\@labeltext \\@durationlabel}\\\\
          \\@duration
        \\end{minipage}\\\\
        \\@separator
        \\noindent
      }
      \\makeatother
      " ;;import de la feuille de syle dans texmf
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; Custom Titlepage
(setq org-latex-title-command (concat
                               "\\thispagestyle{empty}\n"
                               "{\\centering\n"
                               "{\\Huge\\scshape %t \\par }\n"
                               "\\vspace{30pt}\n"
							   "{\\LARGE\\scshape Masterthesis\\par}\n"
							   "\\vspace{10pt}\n"
							   "{\\large\\itshape  In order to obtain the academic degree\\par}\n"
							   "{\\large\\scshape Master of Science (M.Sc.)\\par}\n"
                               "{\\large\\itshape %s \\par}\n"
                               "\\vspace*{\\fill}\n"
							   "\\includesvg{img/siegel.svg}\\par\n"
							   "\\vspace*{\\fill}\n"
							   "{\\normalsize University of Trier\\par\n}"
							   "{\\normalsize FB IV - Computer Science\\par\n}"
							   "{\\normalsize Chair for Databases and Information Systems\\par\n}"
							   "\\vspace{10pt}\n"
							   "\\begin{center}\n"
							   "\\begin{table}[H]
\\centering
\\begin{tabular}{lllll}
Reviewer & \\textsc{Prof. Dr.-Ing. Ralf Schenkel}   &  &  &  \\\\
         & \\textsc{Prof. Dr.-Ing. Benjamin Weyers} &  &  &  \\\\
Advisor  & \\textsc{M. Sc. Tobias Zeimetz}          &  &  &  \\\\
         &                                &  &  &
\\end{tabular}
\\end{table}\n"
							   "\\end{center}"
                               "{\\normalsize Submitted on  %D\;  by: \\par}\n"
							   "\\vspace{20pt}\n"
							   "{\\normalsize \\scshape %a\\par}\n"
							   "{\\normalsize Hohenzollernstraße 32 \\par}\n"
							   "{\\normalsize 54290 Trier\\par}\n"
							   "{\\normalsize s4tsschi@uni-trier.de \\par}\n"
							   "{\\normalsize Matr.-Nr. 1184921\\par}\n"
                               "\\clearpage\n"
                               "}"))
(use-package org-pomodoro
  :straight t
  :bind ([f7] . org-pomodoro)
  :custom
  (org-pomodoro-length 25)
  (org-pomodoro-start-sound-p t)
  (org-pomodoro-ticking-sound-p nil)
  (org-pomodoro-ticking-sound-states '(:pomodoro))
  (org-pomodoro-ticking-frequency 1)
  (org-pomodoro-keep-killed-pomodoro-time t)
  (org-pomodoro-start-sound "~/.emacs.d/bell.wav")
  (org-pomodoro-finished-sound "~/.emacs.d/bell.wav")
  (org-pomodoro-short-break-length 5)
  :config
  (setq alert-default-style 'libnotify)
  (add-hook 'org-clock-out-hook (lambda () (org-save-all-org-buffers))))

