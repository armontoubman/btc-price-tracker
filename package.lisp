;;;; package.lisp

(defpackage #:btc-price-tracker
  (:use #:cl+qt :arrow-macros)
  (:export :get-price
           :main))
