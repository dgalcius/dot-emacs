(setq package-enable-at-startup nil) (package-initialize)

;; start emacs server
(server-start)

;; C-h is backspace
;;(keyboard-translate ?\C-h ?\C-?)
;;(set-frame-size (selected-frame) 238 70)
(set-frame-size (selected-frame) 238 64)

;; auto time-stamp 
(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-pattern nil)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   (quote
    (((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "PDF Tools")
     (output-html "xdg-open"))))
 '(auto-revert-interval 1)
 '(custom-enabled-themes (quote (darktooth)))
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "d09467d742f713443c7699a546c0300db1a75fed347e09e3f178ab2f3aa2c617" "40664277ccd962bc373bff67affb4efa7c9bf3dabd81787e6e08fe080ba9645f" "6a7686db843029a1ca8beec8aadbf094dac5ae592198bd124262fdfeac851d2a" default)))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("marmalade" . "https://marmalade-repo.org/packages/")
     ("melpa" . "http://melpa.org/packages/")
     ("SC" . "http://joseito.republika.pl/sunrise-commander/"))))
 '(whitespace-style
   (quote
    (lines-tail newline space-mark tab-mark newline-mark face))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 
(pdf-tools-install)

;(defvar tv/prefer-pdf-tools (fboundp 'pdf-view-mode))
;(defun tv/start-pdf-tools-if-pdf ()
;  (when (and tv/prefer-pdf-tools
;             (eq doc-view-doc-type 'pdf))
;    (pdf-view-mode)))
;
;(add-hook 'doc-view-mode-hook 'tv/start-pdf-tools-if-pdf)


;; AucTeX
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)


;; AutoRevertMode
(global-auto-revert-mode 1)


;; Mail
;; The setting to use SEMI
(require 'mime-setup)
;; autoload configuration
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
;; SMTP server for mail posting. Default: nil
(setq wl-smtp-posting-server "smtp.vtex.vmt")
;; NNTP server for news posting. Default: nil
(setq wl-nntp-posting-server "news.vtex.vmt")
;;
(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))
(setq wl-from "deimi@vtex.lt")




;; auto log
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

;;scrolling
(setq scroll-margin 5
      scroll-preserve-screen-position 1)

;; keep buffer title
(setq-default frame-title-format '((:eval (if (buffer-file-name)
                                              (abbreviate-file-name (buffer-file-name)) "%f"))))

;; Store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; Always use two spaces to indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default c-basic-offset 2)
(setq css-indent-offset 2)
(setq js-indent-level 2)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-css-indent-offset 2)


;;

;; Ruby
(require 'enh-ruby-mode)
(require 'inf-ruby)
(add-hook 'ruby-mode-hook 'robe-mode)
;(add-hook 'ruby-mode-hook 'robe-mode)


;; Power line
(require 'powerline)
;;(powerline-default-theme)


;; whitespace
(require 'whitespace)
(setq whitespace-line-column 90) ;; limit line length
;(setq whitespace-style '(spaces tabs newline space-mark tab-mark newline-mark lines-tail face))
(setq whitespace-style '(lines-tail newline space-mark tab-mark newline-mark))
(setq whitespace-display-mappings
;      ;; all numbers are Unicode codepoint in decimal. e.g. (insert-char 182 1)
      '(
        (space-mark 183) ; 32 SPACE, 183 MIDDLE DOT; nil
        (newline-mark 10 [172 10]) ; 10 LINE FEED
        (tab-mark 9 [183 9] [92 9]) ; 9 TAB, MIDDLE DOT
        ))
(setq whitespace-global-modes '(not org-mode web-mode "Web" emacs-lisp-mode nxml-mode))
(global-whitespace-mode)


;; smartparens
(require 'smartparens)
(show-smartparens-global-mode +1)



;; Org-mode fix
(eval-after-load "org"
  '(require 'ox-md nil t))


;; nXML mode scheme location
(eval-after-load 'rng-loc
  '(add-to-list 'rng-schema-locating-files "~/.schema/schemas.xml"))

;; magit
(global-set-key (kbd "C-x g") 'magit-status)


;; yasnippet
;;(add-to-list 'load-path
;;              "~/.emacs.d/plugins/yasnippet")
;;(require 'yasnippet)
;;(yas-global-mode 1)
;;g(setq yas-snippet-dirs '("~/.emacs.d/snippets"))

; default font
;(set-default-font "Source Code Pro" nil t)
;(set-face-attribute 'default nil :height 100)

                                        ; mode line
(display-time-mode)
(require 'smart-mode-line)
(setq powerline-arrow-shape 'curve)
(setq powerline-default-separator-dir '(right . left))
(setq sml/theme 'powerline)
(setq sml/mode-width 0)
(setq sml/name-width 20)
(rich-minority-mode 1)
(setf rm-blacklist "")
(sml/setup)

; ido-mode
(require 'ido)
(ido-mode t)

; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
