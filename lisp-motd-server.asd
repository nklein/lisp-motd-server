
(asdf:defsystem #:lisp-motd-server
  :description "Lisp server functions"
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.1.20190919"
  :license "UNLICENSE"
  :depends-on (#:zaws #:cl-json)
  :components
   ((:static-file "README.md")
    (:static-file "UNLICENSE")
    (:module "src"
     :components ((:file "package")
                  (:file "errors" :depends-on ("package"))
                  (:file "util" :depends-on ("package"))
                  (:file "dynamodb" :depends-on ("package"
                                                 "util"))
                  (:file "handler" :depends-on ("package"
                                                "dynamodb"))))))
