;;; load-recursive.el --- Load Emacs Lisp Sources Recursively

;; Copyright (C) 2014 shelling
;; Author: shelling <navyblueshellingford@gmail.com>
;; Keyword: load
;; Created: 25 Aug 2014
;; Package-Version: 0.1.0
;; Package-Requires: ((emacs "24.1"))

;;; Code:

(defun recursive-load (name)
  (let ((type (car (file-attributes name))))
    (cond
     ;; is file
     ((eq type nil)
      (load (file-name-nondirectory (replace-regexp-in-string "\\.el$" "" name))))
     ;; is dir
     ((eq type t)
      (progn
        (add-to-list 'load-path (expand-file-name name))
        (loop for file in-ref (directory-files name) do
              (if (and (not (string= ".." file))
                       (not (string= "." file)))
                  (recursive-load (concat (file-name-as-directory name) file))))))
     ;; is symlink, type is the original file path
     ((stringp type)
      (recursive-load type)))))

(provide 'load-recursive.el)

;;; load-recursive.el ends here
