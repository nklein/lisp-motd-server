
(in-package #:lisp-motd-server)

(defmacro with-json-request ((var instance-type &key action) content
                             &body body)
  (let ((request (gensym "REQUEST"))
        (response (gensym "RESPONSE")))
    `(let* ((,request (make-instance ,instance-type
                                     :action ,action
                                     :content (json:encode-json-to-string
                                               ,content)))
            (,response (zaws:submit ,request))
            (,var (json:decode-json-from-string (map 'string
                                                     #'code-char
                                                     (zaws:content
                                                      ,response)))))
       ,@body)))
