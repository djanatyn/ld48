(eval-when (:compile-toplevel) (defpackage :ld48 (:use :common-lisp :lispbuilder-sdl)) (in-package :ld48))

(defclass creature ()
  ((x :accessor creature-x
      :initform (error "creature needs coordinates")
      :initarg :x)
   (y :accessor creature-y
      :initform (error "creature needs coordinates")
      :initarg :y)
   (health :accessor creature-health
	   :initform (error "creature needs health")
	   :initarg :health)
   (color :accessor creature-color
	  :initform (random-color)
	  :initarg :color)))

(defmethod move ((mover creature))
  (let ((choice (random 5)))
    (case choice
      (0 (incf (creature-x mover) 5)) ;; move right
      (1 (decf (creature-x mover) 5)) ;; move left
      (2 (incf (creature-y mover) 5)) ;; move down
      (3 (decf (creature-y mover) 5)) ;; move up
      (4 nil))))

(defmethod draw ((drawn creature))
  (sdl-gfx:draw-box (rectangle :x (creature-x drawn) :y (creature-y drawn) :w 5 :h 5) :color (creature-color drawn)))

(defvar *box-x* 5)
(defvar *box-y* 5)

(defconstant *WIDTH* 640)
(defconstant *HEIGHT* 480)

(defun random-color () (color :r (random 256) :g (random 256) :b (random 256)))

;; clock functions
;; ---------------
(defvar *clock* 0)
(defun tick ()
  (incf *clock*))
(defun listen-for-tick (interval)
  (if (= (mod *clock* interval) 0) t))

(defun key-handler (key)
  (flet ((key-is (key-to-test) (key= key-to-test key)))
    (cond ((key-is :sdl-key-up) (setf *box-y* (- *box-y* 5)))
	  ((key-is :sdl-key-down) (setf *box-y* (+ *box-y* 5)))
	  ((key-is :sdl-key-right) (setf *box-x* (+ *box-x* 5)))
	  ((key-is :sdl-key-left) (setf *box-x* (- *box-x* 5)))
	  ((key-is :sdl-key-escape) (push-quit-event)))))

;; testing
;; -------
(defvar *creature* (make-instance 'creature :x 50 :y 50 :health 100))
(defun reset-test-creature ()
  (setf (creature-x *creature*) 50)
  (setf (creature-y *creature*) 50)
  (setf (creature-color *creature*) (random-color)))

(defun run-game ()
  (with-init ()
    (window *WIDTH* *HEIGHT*)
    (enable-key-repeat 1 1)
    (setf (frame-rate) 60)
    (with-events ()
      (:quit-event () t)
      (:key-down-event (:key key) (key-handler key))
      (:idle ()
	     (clear-display *black*)
	     (sdl-gfx:draw-box (rectangle :x *box-x* :y *box-y* :w 10 :h 10) :color *white*)
	     (draw *creature*)
	     (tick)
	     (if (listen-for-tick 60) (move *creature*))
	     (update-display)))))
