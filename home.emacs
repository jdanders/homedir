;; -*-emacs-lisp-*-

;; Import setting from ~/.local.emacs if it exists
(condition-case nil (load "~/.local.emacs") (error nil))

(add-to-list 'load-path "~/homedir/emacs.d")

;; Key bindings
(global-set-key [f1] 'manual-entry)
(global-set-key [f2] 'info)
;(global-set-key [f3] 'vm)
(global-set-key [f3] 'goto-line)
(global-set-key "\M-g\M-g" 'goto-line)
(global-set-key [f4] 'kill-buffer)
(global-set-key [f5] 'revert-buffer)
(global-set-key [f6] 'comment-region)
(global-set-key [f7] 'vhdl-beautify-region)
(global-set-key [f8] 'insert-parentheses)      ;forward reference
(global-set-key [f9] 'ispell-buffer)
(global-set-key [f10] 'byte-compile-file) ;for .emacs, .gnus etc.
(global-set-key [f11] 'auto-fill-mode)
(global-set-key [f12] 'font-lock-mode)
;(global-unset-key "\M-g")
;(global-set-key "\M-g" 'goto-line)
;(global-unset-key "\M-n")
;(global-set-key "\M-n" 'make-frame-command) ; Mozilla's influence ;-)
;(global-set-key "\C-cl" 'region-length) ;forward reference
;(global-set-key "\C-cp" 'cperl-perldoc)
;(global-set-key "\C-cd" 'dos2unix)      ;forward reference

;Toggle between wrapping long lines and truncating them on the right
(global-set-key "\C-xt" 'toggle-truncate-lines)

;Do ediff on buffers
(global-set-key "\C-xe" 'ediff-buffers)

;Switch between buffers with ctrl+right and ctrl+left
(global-set-key [C-left] 'previous-buffer)
(global-set-key [C-right] 'next-buffer)

(global-set-key "\C-c\C-mg" 'verilog-mode)
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)

;;;;;;;;;;;;;; Set screen colors ;;;;;;;;;;;;;;;;;;;;;
(set-background-color "gray15")
(set-foreground-color "white")
(set-mouse-color "white")
(set-cursor-color "white")

; Set screen size
;(if (display-graphic-p)
(if (> (display-pixel-width)  1400)
    (add-to-list 'default-frame-alist '(width . 166))) ; character
(if (> (display-pixel-height)  800)
    (add-to-list 'default-frame-alist '(height . 64))) ; lines
;    (set-frame-width (selected-frame) 166)
;    (set-frame-height (selected-frame) 64)
(if (> (display-pixel-width)  1400)
    (split-window-right))


;(setq ps-landscape-mode t)
;(setq ps-number-of-columns 2)
;(setq ps-printer-name t)
;(setq ps-lpr-command "c:\\program files\\pdfcreator\\pdfcreator.bat")
;(setq ps-lpr-switches )

;; DEFAULTS

; Highlight marked region
(transient-mark-mode t)

; Auto fill in all major modes
;(setq-default auto-fill-function 'do-auto-fill)

; Automagically read compressed files
(auto-compression-mode 1)

; Automagically save bookmarks
(setq bookmark-save-flag 1)

; Make mouse yank at point
(setq mouse-yank-at-point t)

; Make searches case-insensitive
;(setq case-fold-search t)

; Man page pushiness
;(setq Man-notify-method 'pushy)

; Parenthesis matching
(show-paren-mode 1)

; always use spaces instead of tabs
(setq-default indent-tabs-mode        nil)

; Show line and column numbers in modeline
(line-number-mode t)
(column-number-mode t)

; Font lock in all major modes
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

; Scroll line by line
(setq scroll-step 1)

; Don't add newlines to end of buffer when scrolling
(setq next-line-add-newlines nil)

; Don't modify eol's
(setq inhibit-eol-conversion nil)
;USED TO BE t

; 'y' for 'yes', 'n' for 'no'
(fset 'yes-or-no-p 'y-or-n-p)

; Access system clipboard
;(setq x-select-enable-clipboard t)

; fix title of emacs windows
(setq frame-title-format
   '("%S "(buffer-name "%f"  (dired-directory dired-directory "%b"))
     "%S -> " (buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; CUSTOM FACES

; Region higlighting
(set-face-foreground 'region "white")
(set-face-background 'region "grey60")

; Paren matching
(set-face-background 'show-paren-mismatch "magenta")

; Font lock faces
(set-face-foreground 'font-lock-comment-face "palegreen")
(set-face-foreground 'font-lock-string-face "wheat")
(set-face-foreground 'font-lock-function-name-face "lightblue")
(set-face-foreground 'font-lock-keyword-face "coral")
(set-face-foreground 'font-lock-constant-face "cyan")
(set-face-foreground 'font-lock-type-face "green")
(set-face-foreground 'font-lock-variable-name-face "yellow")
(set-face-foreground 'font-lock-builtin-face "gold")

;;; Enhance the operation of incremental searching.
;;; -----------------------------------------------
;;; The following lines force emacs incremental searches to pop up a small
;;; window when doing incremental searches.  Under most circumstances this
;;; is desireable because it reduces the length of screen refreshes during
;;; incremental searches.
(setq search-slow-speed                 38400)   ; essentially always
(setq search-slow-window-lines          15)


;;; Load the auto-save.el package, which lets you put all of your autosave
;;; files in one place, instead of scattering them around the file system.
 (setq auto-save-hash-p t
       ange-ftp-auto-save t
       auto-save-file-format t
       ; ange-ftp-auto-save-remotely nil
       ;; now that we have auto-save-timeout, let's crank this up
       ;; for better interactive response.
       auto-save-interval 1000
       auto-save-timeout  420
       )
 ;(require 'auto-save)
 (setq auto-save-list-file-prefix "~/.autosave/")
  (defun make-backup-file-name (file)
    (concat auto-save-list-file-prefix "/" (file-name-nondirectory file) "~"))

;; No copyright message on startup.
(setq inhibit-startup-message t)
;; Down arrow won't extend buffer
(setq next-line-add-newlines nil)
; scroll without moving the cursor -- I love this
 (defun scroll-up-line ()
   "Scroll the contents of the window up one line"
   (interactive)
   (scroll-up 1)
 )
 (defun scroll-down-line ()
   "Scroll the contents of the window down one line"
   (interactive)
   (scroll-down 1)
)
;(global-set-key [(control up)] 'scroll-down-line)
;(global-set-key [(control down)] 'scroll-up-line)
;(global-set-key [(control shift tab)] 'previous-buffer)
;(global-set-key [(control tab)] 'next-buffer)

;(global-set-key [mouse-2] 'scroll-right)
;(global-set-key [mouse-3] 'scroll-left)

(defun pound-comment-start (beg end &optional arg)
  "Change comment to # at beginning of lines"
  (interactive "r\nP")
  (save-excursion
    (setq was-value comment-start)
    (setq comment-start "#")
    (goto-char (1- end))
    (end-of-line)
    (setq end (point-marker))
    (goto-char beg)
    (beginning-of-line)
    (setq beg (point))
    (if (looking-at comment-start)
	(comment-region beg end -1)
      (comment-region beg end)))
  (setq comment-start was-value))
(global-set-key "\C-c\C-p" 'pound-comment-start)
(global-set-key "\C-c\C-z" 'pound-comment-start)

; Define a variable for the new make system
(defvar vhdl-compile-new-make t
  "If non-nil, vhdl-compile-new-make overrides the VHDL compiler settings and does 'make [buffer_name]'")

; Override vhdl-compile to allow for direct making of files using
; vhdl-compile-new-make
(eval-after-load "vhdl-mode"
  '(defun vhdl-compile ()
  "Compile current buffer using the VHDL compiler specified in
`vhdl-compiler'."
  (interactive)
  (vhdl-compile-init)
  (let* ((project (aget vhdl-project-alist vhdl-project))
	 (compiler (or (aget vhdl-compiler-alist vhdl-compiler nil)
		       (error "ERROR:  No such compiler: \"%s\"" vhdl-compiler)))
	 (command (nth 0 compiler))
	 (default-directory (vhdl-compile-directory))
	 (file-name (if vhdl-compile-new-make (buffer-name)
                    (if vhdl-compile-absolute-path
			(buffer-file-name)
		      (file-relative-name (buffer-file-name)))))
	 (options (vhdl-get-compile-options project compiler file-name))
	 compilation-process-setup-function)
    (unless (file-directory-p default-directory)
      (error "ERROR:  Compile directory does not exist: \"%s\"" default-directory))
    ;; put file name into quotes if it contains spaces
    (when (string-match " " file-name)
      (setq file-name (concat "\"" file-name "\"")))
    ;; print out file name if compiler does not
    (setq vhdl-compile-file-name (if vhdl-compile-absolute-path
				     (buffer-file-name)
				   (file-relative-name (buffer-file-name))))
    (when (and (= 0 (nth 1 (nth 10 compiler)))
	       (= 0 (nth 1 (nth 11 compiler))))
      (setq compilation-process-setup-function 'vhdl-compile-print-file-name))
    ;; run compilation
    (if options
	(when command
	  (compile (concat (if vhdl-compile-new-make "make" command) " " options " " file-name
			   (unless (equal vhdl-compile-post-command "")
			     (concat " " vhdl-compile-post-command)))))
      (vhdl-warning "Your project settings tell me not to compile this file")))))

;; Set sequential process to reset active high
(setq vhdl-reset-kind  (quote sync))
(setq vhdl-reset-active-high t)
(setq vhdl-testbench-architecture-name '(".*" . "tb_arch"))
(setq vhdl-testbench-initialize-signals t)
(setq vhdl-testbench-create-files 'none)
(setq vhdl-conditions-in-parenthesis t)
(setq vhdl-underscore-is-part-of-word t)
;(setq vhdl-upper-case-keywords t)
(setq vhdl-array-index-record-field-in-sensitivity-list nil)
(setq vhdl-include-port-comments t)
(setq vhdl-testbench-entity-header "library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

")

(setq vhdl-testbench-statements "  i_clk <= not i_clk after 5 ns;

  process
  begin

    i_reset <= '1';

    wait until (i_clk'event) and (i_clk = '0');
    wait until (i_clk'event) and (i_clk = '0');
    wait until (i_clk'event) and (i_clk = '0');

    i_reset <= '0';

    wait;

  end process;"
      )

(defun vhdl-one ()
  "Insert a '1'"
  (interactive)
  (vhdl-insert-keyword "'1'"))
(defun vhdl-zero ()
  "Insert a '0'"
  (interactive)
  (vhdl-insert-keyword "'1'"))
(global-set-key "" 'vhdl-one)

(defun vhdl-electric-one (count) "'11' --> '1'"
  (interactive "p")
  (if (and vhdl-stutter-mode (= count 1))
      (cond ((= (preceding-char) last-input-char)
	     (progn (delete-char -1)
		    (when (not (eq (preceding-char) ? )) (insert " "))
`		    (insert "'1'")))
	    (t (insert-char ?\, 1)))
    (self-insert-command count)))

;(setq default-directory "c:\\data\\")

(defun testbench ()
  "Paste as a bare-bones test bench."
  (interactive)
  (if (not vhdl-port-list)
      (error "No port read")
    (message "Pasting port as test bench, no library...")
    (let ((case-fold-search t)
	  (ent-name (vhdl-replace-string vhdl-testbench-entity-name
					 (nth 0 vhdl-port-list)))
	  (source-buffer (current-buffer))
	  arch-name ent-file-name arch-file-name no-entity position)
      ;; open entity file
      (when (not (eq vhdl-testbench-create-files 'none))
	(string-match "\\.[^.]*\\'" (buffer-file-name (current-buffer)))
	(setq ent-file-name
	      (concat ent-name
		      (substring (buffer-file-name (current-buffer))
				 (match-beginning 0))))
	(when (file-exists-p ent-file-name)
	  (if (y-or-n-p
	       (concat "File `" ent-file-name "' exists; overwrite? "))
	      (progn (delete-file ent-file-name)
		     (when (get-file-buffer ent-file-name)
		       (set-buffer ent-file-name)
                       (set-buffer-modified-p nil)
                       (kill-buffer ent-file-name)))
	    (if (eq vhdl-testbench-create-files 'separate)
		(setq no-entity t)
	      (error "Pasting port as test bench no library...aborted"))))
	(unless no-entity
	  (set-buffer source-buffer)
	  (find-file ent-file-name)))
      (let ((margin 0))
	(unless (and (eq vhdl-testbench-create-files 'separate) no-entity)
	  ;; paste entity header
	  (unless (equal "" vhdl-testbench-entity-header)
	    (vhdl-insert-string-or-file vhdl-testbench-entity-header))
	  ;(vhdl-comment-display-line) (insert "\n\n") (indent-to margin)
	  ;; paste std_logic_1164 package
	  ;(vhdl-insert-keyword "LIBRARY ")
	  ;(insert "ieee;\n") (indent-to margin)
	  ;(vhdl-insert-keyword "USE ")
	  ;(insert "ieee.std_logic_1164.")
	  ;(vhdl-insert-keyword "ALL;")
	  ;(insert "\n\n") (indent-to margin) (vhdl-comment-display-line)
	  (insert "\n") (indent-to margin)
	  ;; paste entity declaration
	  (vhdl-insert-keyword "ENTITY ")
	  (insert ent-name)
	  (vhdl-insert-keyword " IS")
	  (when (memq vhdl-insert-empty-lines '(unit all)) (insert "\n"))
	  (insert "\n") (indent-to margin)
	  (vhdl-insert-keyword "END ")
	  (unless (vhdl-standard-p '87) (vhdl-insert-keyword "ENTITY "))
	  (insert ent-name ";")
	  ;(insert "\n\n") (indent-to margin)
	  ;(vhdl-comment-display-line)
	  (insert "\n"))
	;; get architecture name
	(setq arch-name
	      (if (equal (cdr vhdl-testbench-architecture-name) "")
		  (read-from-minibuffer "architecture name: "
					nil vhdl-minibuffer-local-map)
		(vhdl-replace-string vhdl-testbench-architecture-name
				     (nth 0 vhdl-port-list))))
	;; open architecture file
	(when (eq vhdl-testbench-create-files 'separate)
	  (save-buffer)
	  (string-match "\\.[^.]*\\'" (buffer-file-name (current-buffer)))
	  (setq arch-file-name
		(concat arch-name
			(substring (buffer-file-name (current-buffer))
				   (match-beginning 0))))
	  (when (file-exists-p arch-file-name)
	    (if (y-or-n-p
		 (concat "File `" ent-file-name "' exists; overwrite? "))
		(progn (delete-file arch-file-name)
		       (when (get-file-buffer arch-file-name)
			 (set-buffer (get-file-buffer arch-file-name))
			 (set-buffer-modified-p nil)
			 (kill-buffer arch-file-name)))
	      (error "Pasting port as test bench, no library...aborted")))
	  (set-buffer source-buffer)
	  (find-file arch-file-name)
	  ;; paste architecture header
	  (unless (equal "" vhdl-testbench-architecture-header)
	    (vhdl-insert-string-or-file vhdl-testbench-architecture-header))
	  (vhdl-comment-display-line)
	  (insert "\n"))
	(insert "\n") (indent-to margin)
	;; paste architecture body
	(vhdl-insert-keyword "ARCHITECTURE ")
	(insert arch-name)
	(vhdl-insert-keyword " OF ")
	(insert ent-name)
	(vhdl-insert-keyword " IS")
	(insert "\n\n") (indent-to margin)
	;; paste component declaration
	(when (vhdl-standard-p '87)
	  (vhdl-port-paste-component)
	  (insert "\n\n") (indent-to margin))
	;; paste constants
	(when (nth 1 vhdl-port-list)
	  (vhdl-port-paste-constants)
	  (insert "\n\n") (indent-to margin))
	;; paste internal signals
	(vhdl-port-paste-signals vhdl-testbench-initialize-signals)
	;; paste custom declarations
	(unless (equal "" vhdl-testbench-declarations)
	  (insert "\n\n")
	  (vhdl-insert-string-or-file vhdl-testbench-declarations)
	  (delete-indentation))
	(setq position (point))
	(insert "\n\n") (indent-to margin)
	(vhdl-comment-display-line) (insert "\n")
	(goto-char position)
	(vhdl-template-begin-end
	 (unless (vhdl-standard-p '87) "ARCHITECTURE")
	 arch-name margin t)
	;; paste instantiation
	(vhdl-port-paste-instance
	 (vhdl-replace-string vhdl-testbench-dut-name
			      (nth 0 vhdl-port-list)))
	(insert "\n")
	;; paste custom statements
	(unless (equal "" vhdl-testbench-statements)
	  (insert "\n")
	  (vhdl-insert-string-or-file vhdl-testbench-statements))
	(insert "\n")
	(indent-to (+ margin vhdl-basic-offset))
	(when (not (eq vhdl-testbench-create-files 'none))
	  (save-buffer))
	(message "Pasting port as test bench, no libaray...done")))))

;(defvar vhdl-mode-map t)

; (add-hook 'vhdl-mode-syntax-table-init
 ;        'lambda ()
	 ;(global-unset-key "\C-c-C-p-C-p")
	; (global-set-key "\C-c-C-p-C-p" 'vhdl-port-paste-testbench-no-library)
         ;(define-key vhdl-mode-map "\C-cp" 'vhdl-port-paste-testbench-no-library)
;)

;(add-hook 'vhdl-mode-hook
;	  'lambda () (global-set-key [(control up)] 'testbench))
	  ;(define-key vhdl-mode-map "\C-c-C-p-C-p" 'testbench))
;(defvar vhdl-mode-map ()
;  "Keymap for VHDL Mode.")
;
;(define-key vhdl-mode-map "\C-c\C-p\C-t" 'vhdl-port-paste-testbench)

(global-unset-key "\C-c-C-p-C-p")
;(global-set-key "\C-c-C-p-C-p" 'vhdl-port-paste-testbench-no-library)
(global-set-key "\C-c-C-p-C-p" 'testbench)

;; following didn't work so I added it to progmodes/compile.el
;; (add-hook 'vhdl-mode-hook
;;     (lambda ()
;;       (setq compilation-error-regexp-alist
;;             '((modelsim ".*?\\(Error\\|Warning\\)[^:]*: \\(.+\\)(\\([0-9]+\\)):" 2 3 0)
;;               ))
;;       ))


;; MODES

; CPerl mode
;  Make it the default perl editing mode.
; Modify the alist - back to Cperl section, breaks elsewhere
(defun modify-alist (alist-symbol key value &optional search-cdr)
  (let ((alist (symbol-value alist-symbol)))
    (while alist
      (if (eq (if search-cdr
                  (cdr (car alist))
                (car (car alist))) key)
          (setcdr (car alist) value)
        (setq alist (cdr alist))))))

(modify-alist 'interpreter-mode-alist 'perl-mode 'cperl-mode t)
(modify-alist 'auto-mode-alist        'perl-mode 'cperl-mode t)

(setq cperl-hairy t                     ;turn on everything
      cperl-indent-level 4
      cperl-auto-newline t
;      cperl-auto-newline-after-colon t
      cperl-continued-statement-offset 4
      cperl-brace-offset -4
      cperl-label-offset -4
      )


; Flash paren mode (didn't have to do this in XEmacs !)
;(load-library "flash-paren")
;(flash-paren-mode 1)

; C-mode

;(c-set-style "k&r")

;; HOOKS

; Makes more sense to make this global.
; (add-hook 'cperl-mode-hook
;         'lambda ()
;         (define-key cperl-mode-map "\C-cp" 'cperl-perldoc))

;; PACKAGES

; Gnus 5.8.4

; AuCTeX - now globally installed by Debian 2.2, doesn't need this any
; more.
;(require 'tex-site)

; BBDB
;(require 'bbdb)
;(bbdb-initialize 'gnus 'message 'sc)
;(bbdb-insinuate-sc)
;(setq bbdb-north-american-phone-numbers-p nil
;      bbdb/mail-auto-create-p nil
;      bbdb-quiet-about-name-mismatches t
;      bbdb-notice-auto-save-file t
;      bbdb-message-caching-enabled t
;      bbdb-offer-save t
;      )

; Mailcrypt
;(load-library "mailcrypt")
;(mc-setversion "gpg")                   ; use GPG as default
;(autoload 'mc-install-write-mode "mailcrypt" nil t)
;(autoload 'mc-install-read-mode "mailcrypt" nil t)
;(add-hook 'mail-mode-hook 'mc-install-write-mode)


;; FUNCTION DEFINITIONS


; Insert date into buffer
;(defun insert-date ()
;  "Insert date at point."
;  (interactive)
;  (insert (format-time-string "%A, %B %e, %Y %k:%M:%S %z")))

; Compute the length of the marked region
;(defun region-length ()
;  "length of a region"
;  (interactive)
;  (message (format "%d" (- (region-end) (region-beginning)))))

; dos2unix and unix2dos from Benjamin Rutt's .emacs

; Convert a buffer from dos ^M end of lines to unix end of lines
;(defun dos2unix ()
;  (interactive)
;  (goto-char (point-min))
;  (while (search-forward "\r" nil t) (replace-match "")))

;vice versa
;(defun unix2dos ()
;  (interactive)
;  (goto-char (point-min))
;  (while (search-forward "\n" nil t) (replace-match "\r\n")))
(defun prepend-path ( my-path )
(setq load-path (cons (expand-file-name my-path) load-path)))

(defun append-path ( my-path )
(setq load-path (append load-path (list (expand-file-name my-path)))))
;; Look first in the directory ~/elisp for elisp files
(prepend-path "~/elisp")
;; Load verilog mode only when needed
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
;; Any files that end in .v should be in verilog mode
(setq auto-mode-alist (cons '("\\.v\\'" . verilog-mode) auto-mode-alist))
;; Any files in verilog mode should have their keywords colorized
(add-hook 'verilog-mode-hook '(lambda () (font-lock-mode 1)))

;; These were set by "custom" now changed to just setq
(setq
 column-number-mode t
 comment-style (quote plain)
;ediff-split-window-function (quote split-window-horizontally)
;ediff-window-setup-function (quote ediff-setup-windows-plain)
 mouse-wheel-progressive-speed nil
 python-indent 4
 python-indent-offset 4
 read-buffer-completion-ignore-case t
 read-file-name-completion-ignore-case t
 save-abbrevs (quote silently)
 show-paren-style (quote expression)
 tab-width 2
 vhdl-clock-edge-condition (quote function)
 vhdl-compiler "ModelSim"
 vhdl-include-direction-comments t
 vhdl-include-group-comments (quote always)
 vhdl-project nil
 vhdl-project-alist (quote (("example 1" "Project with individual source files" "" ("~/example1/vhdl/system.vhd" "~/example1/vhdl/component_*.vhd") "" nil "./" "work" "work/" "Makefile" "-------------------------------------------------------------------------------
-- This is a multi-line project description
-- that can be used as a project dependent part of the file header.
") ("example 2" "Project where source files are located in two directories" "" ("$EXAMPLE2/vhdl/components/" "$EXAMPLE2/vhdl/system/") "" nil "./" "work" "work/" "Makefile" "") ("example 3" "Project where source files are located in some directory trees" "" ("-r ~/example3/*/vhdl/") "" nil "./" "work" "work/" "Makefile" "")))
 safe-local-variable-values (quote ((verilog-linter . "verilator --lint-only __FILE__"))))

(tool-bar-mode -1)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(show-paren-match ((t (:background "navy" :weight extra-bold)))))

;(autoload 'python-mode "python-mode" "Python Mode." t)
;(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;(add-to-list 'interpreter-mode-alist '("python" . python-mode))
;(add-hook 'python-mode-hook
;           (lambda ()
;             (set (make-variable-buffer-local 'beginning-of-defun-function)
;                  'py-beginning-of-def-or-class)
;             (setq outline-regexp "def\\|class ")))

(autoload 'ucf-mode "ucf-mode" "Ucf Mode." t)
(add-to-list 'auto-mode-alist '("\\.ucf\\'" . ucf-mode))
(add-to-list 'interpreter-mode-alist '("ucf" . ucf-mode))
(add-to-list 'auto-mode-alist '("\\.qsf\\'" . tcl-mode))
(add-to-list 'interpreter-mode-alist '("qsf" . tcl-mode))
(add-to-list 'auto-mode-alist '("\\.sdc\\'" . tcl-mode))
(add-to-list 'interpreter-mode-alist '("sdc" . tcl-mode))

(add-to-list 'auto-mode-alist '("\\.vho\\'" . vhdl-mode))
(add-to-list 'interpreter-mode-alist '("vho" . vhdl-mode))

(add-to-list 'magic-mode-alist '("element *" . sh-mode))

;(setq py-which-shell "c:\\python25\\python.exe")
(setq py-indent-offset 2)
;(setq python-command "c:\\python25\\python.exe")

(put 'scroll-left 'disabled nil)
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (when (member "Liberation Mono" (font-family-list))
    (add-to-list 'initial-frame-alist '(font . "Liberation Mono-9"))
    (add-to-list 'default-frame-alist '(font . "Liberation Mono-9"))
    )
  )
 ((string-equal system-type "gnu/linux") ; linux
  (when (member "Liberation Mono" (font-family-list))
    (add-to-list 'initial-frame-alist '(font . "Liberation Mono-9"))
    (add-to-list 'default-frame-alist '(font . "Liberation Mono-9")))
  )
 )

;(set-face-attribute 'default nil :font "Liberation Mono-9")
;(set-frame-font "Liberation Mono-9" nil t)
;(when (member "Liberation Mono-9" '(fontset-alias-alist))
;  (set-face-attribute 'default nil :font "Liberation Mono-9"))

;(set-default-font "-outline-Bitstream Vera Sans Mono-normal-r-normal-normal-13-*-96-96-c-*-iso8859-1")
;(set-default-font "-outline-Consolas-normal-r-normal-normal-13-*-96-96-c-*-iso8859-1")

; Enable middle mouse button dragging in the correct direction
;(require 'mouse-drag)
;(global-set-key [down-mouse-2] 'mouse-drag-throw)
;(setq mouse-throw-with-scroll-bar t)

; Revert .24 behavior, mouse drag copies to both primary and clipboard
(setq mouse-drag-copy-region t)

(put 'downcase-region 'disabled nil)
;(load "cc")

(defun kill-other-window ()
  "remove other window and kill the buffer"
  (interactive)
  (other-window 1)
  (kill-buffer-and-window)
  (other-window 1))

(global-set-key "\C-x9" 'kill-other-window)

(setq undo-limit 20000000)
(setq undo-outer-limit 3000000000)
(setq undo-strong-limit 30000000)

; Set nice ediff defaults
(setq-default ediff-ignore-case t)
(setq-default ediff-ignore-similar-regions t)
(setq ediff-split-window-function (quote split-window-horizontally))
(setq ediff-window-setup-function (quote ediff-setup-windows-plain))

; Prevent fat-finger closing of emacs
(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))

(when window-system
  (global-set-key (kbd "C-x C-c") 'ask-before-closing))

; Automatically save "desktop" (list of files opened)
;     (require 'desktop-recover)
;     ;; Highly recommended to keep emacs from bugging you about coding systems:
;     ;(prefer-coding-system 'utf-8)
;     ;; Optional settings:
;     ;;   if you'd like to specify where the desktop should be saved:
;       (setq desktop-recover-location
;          (desktop-recover-fixdir "/data/engtmp2/jdabin/.autosave/.autodesktop/"))
;       (setq desktop-recover-tmp-dir "/data/engtmp2/jdabin/.autosave/.autodesktop/desktop-recover-tmp")
;     ;;   increase this to save the desktop less often (e.g. if disk is slow):
;       (setq desktop-recover-save-period 3)
;     ;; brings up the interactive buffer restore menu
;     (desktop-recover-interactive)
; ;  (desktop-save-mode 1)

(require 'desktop)
(defun my-desktop-save ()
    (interactive)
    ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
    ;(if (eq (desktop-owner) (emacs-pid))
    ;    (desktop-save desktop-dirname)))
    ; Only autosave if the desktop save directory has been manually set
    (if desktop-dirname
      (desktop-save desktop-dirname)))
; Tie in desktop save to the autosave function
(add-hook 'auto-save-hook 'my-desktop-save)
; Save the undo list per buffer
(add-to-list 'desktop-locals-to-save 'buffer-undo-list)
; Only restore 6 buffers initially, do the rest when idle
(setq desktop-restore-eager 6)

;(setq desktop-path (quote ("." "~/.emacs.d/" "~")))
(add-to-list 'desktop-path default-directory)

(put 'upcase-region 'disabled nil)

(eval-after-load "vc-hooks"
         '(define-key vc-prefix-map "=" 'vc-ediff))

;(require 'egg-base)
;(require 'egg-const)
;(require 'egg-custom)
;(require 'egg-diff)
;(require 'egg-git)
;(require 'egg-grep)
;(require 'egg-key)
;(require 'egg-svn)
;(require 'egg)

(add-to-list 'auto-mode-alist '("\\.svh\\'" . verilog-mode))
(add-to-list 'interpreter-mode-alist '("svh" . verilog-mode))

(setq verilog-indent-level              2
      verilog-indent-level-module       2
      verilog-indent-level-declaration  2
      verilog-indent-level-behavioral   2
      verilog-indent-level-directive    0
      verilog-indent-begin-after-if     nil
      verilog-indent-lists              nil
      verilog-indent-declaration-macros nil
      verilog-case-indent               2
      verilog-auto-newline              nil
      verilog-auto-lineup               nil
      verilog-minimum-comment-distance  12
      verilog-align-ifelse              t
      verilog-auto-endcomments          nil
      verilog-linter "verilator --lint-only"
      )

(eval-after-load "vc-hooks"
         '(define-key vc-prefix-map "=" 'ediff-revision))

(defun myverilog-electric-comma (count) "',,' --> ' <= '"
  (interactive "p")
  (if (and t (= count 1) t)
      (cond ((= (preceding-char) last-input-event)
	     (progn (delete-char -1)
		    (unless (eq (preceding-char) ? ) (insert " "))
		    (insert "<= ")))
	    (t (insert-char ?\, 1)))
    (self-insert-command count)))

;(setq myverilog-mode-map (make-sparse-keymap))
;(define-key myverilog-mode-map ","		   'myverilog-electric-comma)
;(use-local-map myverilog-mode-map)
(global-set-key "," 'myverilog-electric-comma)

;disable auto indent in python
(add-hook 'python-mode-hook
          (lambda ()
            (setq electric-indent-chars (delq ?: electric-indent-chars))))

(global-auto-revert-mode t)

;Select python debugger
(setq gud-pdb-command-name "python -m pdb")

; Interactive buffer stuff
;(require 'ido)
;(ido-mode t)
;(setq ido-enable-flex-matching t)

(when (> emacs-major-version 23)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa-stable" . "https://stable.melpa.org/packages/") t)
  (when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
  ;(package-initialize)
  )

(defun pdb-set-trace ()
  ;; http://www.emacswiki.org/emacs/InteractiveFunction
  (interactive)
  (insert "import pdb; pdb.set_trace()"))
(require 'python)
(define-key python-mode-map [(control ?x) (control ?d)] 'pdb-set-trace)

;(add-to-list 'load-path "~/homedir/emacs.d/popup-el")
;(add-to-list 'load-path "~/homedir/emacs.d/auto-complete")

; Autocomplete
;(require 'auto-complete)
;(add-to-list 'ac-dictionary-directories "~/homedir/emacs.d/auto-complete/ac-dict")
;(require 'auto-complete-config)
;(ac-config-default)
;(global-auto-complete-mode t)

(when (> emacs-major-version 23)
  (add-to-list 'load-path "~/homedir/emacs.d/yasnippet/")
  (require 'yasnippet)
  (setq yas-snippet-dirs
        '("~/homedir/emacs.d/snippets"                 ;; personal snippets
          "~/homedir/emacs.d/yasnippet/snippets"         ;; the default collection
          ))
  (yas-global-mode 1)
  )

(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (electric-verilog-tab))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (electric-verilog-tab))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

; Disable secondary selection
(global-unset-key [M-mouse-1])
(global-unset-key [M-drag-mouse-1])
(global-unset-key [M-down-mouse-1])
(global-unset-key [M-mouse-3])
(global-unset-key [M-mouse-2])

;(define-key yas-minor-mode-map (kbd "<tab>") nil)
;(define-key yas-minor-mode-map (kbd "TAB") nil)
;(define-key yas-minor-mode-map (kbd "SPC") 'yas-expand)

;; Allow tab for autocomplete
;(setq completion-cycle-threshold t)
;; Print possible completions
;(setq icomplete-mode t)

;; Add 'substring' and 'initials' to list of completion options
(setq completion-styles
   (quote
    (basic partial-completion emacs22 substring initials)))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; Disable color when grepping
(setq grep-program "grep --color=never")

(add-hook 'before-save-hook 'delete-trailing-whitespace)

; 25.2 changes this behavior, set it back
(add-to-list 'display-buffer-alist
     '("^\\*shell\\*$" . (display-buffer-same-window)))

; Enable projectile
(setq projectile-keymap-prefix (kbd "C-x p"))
(require 'projectile)
(projectile-global-mode)

; Enable grizzl
(require 'grizzl)
(setq projectile-completion-system (quote grizzl))

; scad-mode for openscad
(autoload 'scad-mode "scad-mode" "A major mode for editing OpenSCAD code." t)
(add-to-list 'auto-mode-alist '("\\.scad$" . scad-mode))
