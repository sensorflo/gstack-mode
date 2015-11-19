;;; gstack-mode.el --- a major-mode for viewing gstack output
;;
;; Copyright 2015 Florian Kaufmann <sensorflo@gmail.com>
;;
;; Author: Florian Kaufmann <sensorflo@gmail.com>
;; URL: https://github.com/sensorflo/gstack-mode
;; Created: 2015
;; Keywords: gstack
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;
;;; Commentary:
;;
;; A major mode for viewing gstack(1) output.


;;; Code:
(require 'font-lock-ext) ; https://github.com/sensorflo/font-lock-ext/

(defconst gstack-font-lock-keywords
  (list
   (list "^\\(Thread\\) \\([0-9]+\\)" '(1 font-lock-keyword-face) '(2 font-lock-function-name-face))
   (list "^\\(#[0-9]+\\)" '(1 font-lock-comment-face))
   (list "^#[0-9]+ +\\(0x[a-f0-9]+\\)" '(1 font-lock-semi-unimportant))
   (list "^#[0-9]+ +0x[a-f0-9]+ in \\(\\(?:[a-zA-Z0-9_:<>@.?]\\|(anonymous namespace)\\)+\\) *("
         '(1 font-lock-function-name-face))
   (list (concat
          "("
          "\\([^,)]*?\\)=\\([^,=)]*?\\)"
          "\\(?:, \\([^,)]*?\\)=\\([^,=)]*?\\)\\)?"
          "\\(?:, \\([^,)]*?\\)=\\([^,=)]*?\\)\\)?"
          "\\(?:, \\([^,)]*?\\)=\\([^,=)]*?\\)\\)?"
          "\\(?:, \\([^,)]*?\\)=\\([^,=)]*?\\)\\)?"
          ")")
         '(1 font-lock-variable-name-face nil t) '(2 font-lock-constant-face nil t)
         '(3 font-lock-variable-name-face nil t) '(4 font-lock-constant-face nil t)
         '(5 font-lock-variable-name-face nil t) '(6 font-lock-constant-face nil t)
         '(7 font-lock-variable-name-face nil t) '(8 font-lock-constant-face nil t)
         '(9 font-lock-variable-name-face nil t) '(10 font-lock-constant-face nil t))
   (list " \\(?:at\\|from\\) \\(.*?\\)$" '(1 font-lock-semi-unimportant))))

;;;###autoload
(define-derived-mode gstack-mode text-mode "gstack"
  "A major mode for viewing gstack output"
  (view-mode 1)
  (set (make-local-variable 'font-lock-defaults)
       '(gstack-font-lock-keywords t))
  (set (make-local-variable 'outline-regexp)
       "^Thread\\b"))

;;;###autoload
(add-to-list 'auto-mode-alist (cons "/gstack[^/.]*\\'" 'gstack-mode))


(provide 'gstack-mode)

;;; gstack-mode.el ends here
