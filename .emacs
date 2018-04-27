(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; mostly going to be writing in c++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; fix auctex path
(setenv "PATH" "/usr/local/bin:/Library/TeX/Root/bin/x86_64-darwin:$PATH" t)
(setq exec-path (append exec-path '("/Library/TeX/Root/bin/x86_64-darwin")))

;; add jsx support
;; (autoload 'jsx-mode "jsx-mode" "JSX mode" t)

;; add web-mode support
(autoload 'web-mode "web-mode" "Web mode" t)


;; auto emacs template
;; (let ((el (assoc 'latex-mode auto-insert-alist)))
;;   (if el
;;       (setcdr el "/Users/sgron/School/2015-2016/Fall 2015/14.384/lecture_notes/1.tex")
(define-auto-insert "\\.tex$" "/Users/sgron/School/2016-2017/notes_template.tex")

;; org-journal
(require 'org-journal)

;; tetris high scores!!
(setq tetris-score-file "~/.emacs.d/tetris-scores")

;; ESS
(add-to-list 'load-path "~/.emacs.d/site-lisp/ess-13.05/lisp/")
(require 'ess-site)

;; get preview-latex (breaks)
;; (load "preview-latex.el" nil t t)

;; add path to latex binaries
(setenv "PATH"
	(concat
	 "/usr/texbin" ":"
	 (getenv "PATH")))

;; add package manager
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(package-initialize)
;; to install:
;; M-x package-refresh-contents <THEN> M-x package-install [RET] <PACKAGE>

;; add cmuscheme
;; (autoload 'run-scheme "cmuscheme" nil t)
;; (setq auto-mode-alist 
;;       (cons '("\\.scm$" . scheme-mode)  
;;             auto-mode-alist))

;; Define C-c C-t to run my favorite command in inferior scheme mode:
;; (setq cmuscheme-load-hook
;;       '((lambda () (define-key inferior-scheme-mode-map "\C-c\C-t"
;; 		     'favorite-cmd))))


;; add auctex
;; (add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
;; (require 'tex-site)

;; AucTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq LaTeX-electric-left-right-brace nil)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'electric-pair-mode)
(add-hook 'LaTeX-mode-hook
          '(lambda ()
	     (define-key LaTeX-mode-map (kbd "$") 'self-insert-command)))
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

;; Use Skim as viewer, enable source <-> PDF sync
;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))
 
;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background  
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))

;; include gs directory (for auctex)
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; scroll wheel in xterm
(if (fboundp 'xterm-mouse-mode)
    (xterm-mouse-mode 1))

;; haskell 
(add-to-list 'auto-mode-alist '("\\.hs\\'" . haskell-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-electric-sub-and-superscript t)
 '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(coffee-tab-width 2)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(electric-pair-mode nil)
 '(haskell-mode-hook (quote (turn-on-haskell-indent)))
 '(org-agenda-files (quote ("~/Projects/july_camp/hubweek/time.org")))
 '(python-shell-interpreter "python3"))


;; make window bigger
(tool-bar-mode 0)

;; winner mode
(when (fboundp 'winner-mode)
  (winner-mode 1))
;; C-c <left> to go back to prev window config
;; C-c <right> to go back forward

;; windmove
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
;; S-<arrow key> to move to neighboring window

;; js mode
(autoload 'js2-mode "js2" nil t)
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; for now, use normal javascript-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))

;; coffee script mode
(autoload 'coffee-mode "coffee-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))



;; go mode
(autoload 'go-mode "go" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; set buffer menu instead of list buffers -- open in same window
(global-set-key "\C-x\C-b" 'buffer-menu)

;; ido mode
(require 'ido)
(ido-mode t)

;;; Backups
(make-directory "~/.emacs.d/saves" t)
(setq
 backup-by-copying t
 backup-directory-alist '((".*" . "~/.emacs.d/saves"))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)

(show-paren-mode 1)
(column-number-mode 1)
(setq-default indicate-empty-lines t)
(size-indication-mode t)

(defun refresh-file ()
  "Interactive command to reload the buffer, asking for permission if the buffer is modified."
  (interactive)
  (revert-buffer t (not (buffer-modified-p)) t))
(global-set-key [f5] 'refresh-file)



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)

;; align equals
(global-set-key (kbd "C-c C-=") 'align-regexp)


;; set up ggtags
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))
(defun gtags-update-single(filename)  
  "Update Gtags database for changes in a single file"
  (interactive)
  (start-process "update-gtags" "update-gtags" "bash" "-c" (concat "cd " (gtags-root-dir) " ; gtags --single-update " filename )))
(defun gtags-update-current-file()
  (interactive)
  (defvar filename)
  (setq filename (replace-regexp-in-string (gtags-root-dir) "." (buffer-file-name (current-buffer))))
  (gtags-update-single filename)
  (message "Gtags updated for %s" filename))
(defun gtags-update-hook()
  "Update GTAGS file incrementally upon saving a file"
  (when gtags-mode
    (when (gtags-root-dir)
      (gtags-update-current-file))))
(add-hook 'after-save-hook 'gtags-update-hook)
