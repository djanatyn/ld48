;; creature definitions
;; --------------------

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
  (sdl-gfx:draw-box (sdl:rectangle :x (creature-x drawn) :y (creature-y drawn) :w (creature-health drawn) :h (creature-health drawn)) :color (creature-color drawn)))

(defun random-creature ()
  (make-instance 'creature :health (random 10) :x (random *HEIGHT*) :y (random *WIDTH*)))

(defun spawn-creatures (num-creatures)
  (if (> num-creatures 0) (cons (random-creature) (spawn-creatures (- num-creatures 1)))))
