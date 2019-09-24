
(in-package #:lisp-motd-server)

(defun get-messages-handler (body-seq)
  (let* ((body-string (map 'string #'code-char body-seq))
         (body (json:decode-json-from-string body-string))
         (category (cdr (assoc :|category| body)))
         (since (cdr (assoc :|since| body))))
    (values (json:encode-json-to-string
             (get-messages-since (or category "general")
                                 (or since 0)))
            "application/json")))
