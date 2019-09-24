
(in-package #:lisp-motd-server)

(defclass ddb-request (zaws:request zaws:json-auth-v3)
  ((action :initarg :action
           :accessor action))
  (:default-initargs :host "dynamodb.us-east-1.amazonaws.com"
    :content-type "application/x-amz-json-1.0"
    :method :post
    :uri-path "/"))

(defmethod zaws:prepare-for-signing :after ((request ddb-request))
  (zaws:ensure-header "x-amz-target"
                      (format nil "DynamoDB_20120810.~A"
                              (action request))
                      request))

(defun clean-up-dynamodb-item (item)
  (labels ((decode-value (type value)
             (ecase type
               (:N
                (check-type value string)
                (parse-integer value))
               (:S
                (check-type value string)
                value)
               (:M
                (check-type value list)
                (mapcar #'decode-entry value))
               (:SS
                (check-type value list)
                (assert (every #'stringp value))
                value)
               (:NN
                (check-type value list)
                (assert (every #'stringp value))
                (mapcar #'parse-integer value))))

           (decode-entry (entry)
             (destructuring-bind (name (type . value)) entry
               (cons name (decode-value type value)))))
    (mapcar #'decode-entry item)))

(defun get-messages-since (category since)
  (check-type category string)
  (check-type since (integer 0))
  (with-json-request (json 'ddb-request :action "Query")
      `((:|TableName| . "LispMotd")
        (:|IndexName| . "Category-UpdatedAt-index")
        (:|KeyConditionExpression|
          . "Category = :hkey AND UpdatedAt > :skey")
        (:|ExpressionAttributeValues|
          . ((:|:hkey| . ((:|S| . ,category)))
             (:|:skey| . ((:|N| . ,(format nil "~D" since)))))))
    (mapcar #'clean-up-dynamodb-item (cdr (assoc :|Items| json)))))
