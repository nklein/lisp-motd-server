
(in-package #:lisp-motd-server)

(defmethod zaws:check-response-error ((request zaws:request)
                                      (response zaws:response))
  (unless (= (zaws:status-code response) 200)
    (error 'zaws:response-error
           :request request
           :response response)))
