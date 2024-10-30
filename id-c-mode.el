;;; id-c-mode.el --- A minimal major mode for C  -*- lexical-binding:t -*-

;; Copyright (C) 2024  CToID <funk443@yahoo.com.tw>

;; Author: CToID <funk443@yahoo.com.tw>
;; Version: 1.0

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Code:

(defvar id-c-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?/ ". 14" table)
    (modify-syntax-entry ?* ". 23" table)
    (modify-syntax-entry ?# "." table)
    (modify-syntax-entry ?& "." table)
    (modify-syntax-entry ?' "\"" table)
    table))

(defvar id-c-mode-font-lock-keywords
  '(("# *[#a-zA-Z0-9_]+" . font-lock-preprocessor-face)
    ("# *include *\\([<\"].*[>\"]\\)" . (1 font-lock-string-face))))

(defun id-c-mode-format-buffer ()
  (interactive)
  (if (executable-find "astyle")
      (let ((line (line-number-at-pos)))
        (shell-command-on-region
         (point-min) (point-max)
         "astyle --style=kr"
         nil t)
        (goto-line line))
    (message "ERROR: `astyle` not found in executable path.")))

(defvar-keymap id-c-mode-map
  :doc "Keymap for ID's C Mode."
  "C-M-\\" #'id-c-mode-format-buffer)

;;;###autoload
(define-derived-mode id-c-mode prog-mode "ID's C"
  "Minimum syntax-highlighting C mode, indented by astyle."
  :syntax-table id-c-mode-syntax-table
  (setq-local font-lock-defaults (list id-c-mode-font-lock-keywords)
              comment-start "/* "
              comment-end " */"))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.[hc]\\'" . id-c-mode))

(provide 'id-c-mode)

;;; id-c-mode.el ends here
