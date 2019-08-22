;;; -*- Mode: LISP; Syntax: ANSI-COMMON-LISP; Base: 10 -*-

(in-package :cl-user)

(defpackage :flexi-streams-system
  (:use :asdf :cl))

(in-package :flexi-streams-system)

;;; Maybe it can be made work for some encodings
(when (<= char-code-limit 65533)
  (error "flexi-streams doesn't work on implementations with CHAR-CODE-LIMIT (~a) less than 65533"
         char-code-limit))

(defsystem :flexi-streams
  :version "1.0.18"
  :serial t
  :description "Flexible bivalent streams for Common Lisp"
  :license "BSD-2-Clause"
  :components ((:file "packages")
               (:file "mapping")
               (:file "ascii")
               (:file "koi8-r")
               (:file "iso-8859")
               (:file "code-pages")
               (:file "specials")
               (:file "util")
               (:file "conditions")
               (:file "external-format")
               (:file "length")
               (:file "encode")
               (:file "decode")
               (:file "in-memory")
               (:file "stream")
               #+:lispworks (:file "lw-char-stream")
               (:file "output")
               (:file "input")
               (:file "io")
               (:file "strings"))
  :depends-on (:trivial-gray-streams))

(defsystem :flexi-streams/test
  :components ((:module "test"
                        :serial t
                        :components ((:file "packages")
                                     (:file "test"))))
  :depends-on (:flexi-streams))

(defmethod perform ((o test-op) (c (eql (find-system 'flexi-streams))))
  (operate 'load-op 'flexi-streams-test)
  (funcall (intern (symbol-name :run-all-tests)
                   (find-package :flexi-streams-test))))
