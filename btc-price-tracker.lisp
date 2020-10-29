;;;; btc-price-tracker.lisp

(in-package :btc-price-tracker)
(named-readtables:in-readtable :qtools)


(defparameter *url* "https://api.coindesk.com/v1/bpi/currentprice.json")
(defparameter *update-rate-ms* 5000)


(defun get-price ()
  (let ((the-json (-> *url* #'dex:get #'flexi-streams:octets-to-string #'st-json:read-json)))
    (st-json:getjso* "bpi.USD.rate" the-json)))


(defclass btc-price-tracker-app ()
  ((price-label :accessor price-label)
   (update-timer :accessor update-timer))
  (:metaclass qt-class)
  (:qt-superclass "QWidget")
  (:slots ("show-price()" show-price)))


(defmethod show-price ((instance btc-price-tracker-app))
  (q+:set-text (price-label instance) (concatenate 'string "$" (get-price))))


(defmethod initialize-instance :after 
  ((instance btc-price-tracker-app) &key) 
  (new instance)
  (init-ui instance))


(defmethod init-ui ((instance btc-price-tracker-app))
  (let ((x 200)
        (y 200)
        (w 300)
        (h 300))
    (q+:set-geometry instance x y w h)
    (q+:set-window-title instance "BTC price tracker")
    (setf (price-label instance) (#_new QLabel "Loading price..." instance)) ; https://doc.qt.io/archives/qt-4.8/qlabel.html
    (setf (update-timer instance) (#_new QTimer instance)) ; https://doc.qt.io/archives/qt-4.8/qtimer.html
    (q+:set-geometry (price-label instance) 0 0 w h)
    (q+:set-alignment (price-label instance) (#_Qt::AlignCenter))
    (connect (update-timer instance) "timeout()" instance "show-price()")
    (#_start (update-timer instance) *update-rate-ms*)))


(defun main ()
  (make-qapplication)
  (with-main-window (window (make-instance 'btc-price-tracker-app))))
