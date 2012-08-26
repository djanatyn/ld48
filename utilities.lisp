;; utilities
;; ---------

(defun random-color ()
  "generate a random SDL color"
  (sdl:color :r (random 256) :g (random 256) :b (random 256)))

(defvar *clock* 0)

(defun tick ()
  "increment the clock"
  (incf *clock*))
(defmacro on-tick (interval &body body)
  "evalute the exressions passed if it's time to tick"
  `(if (= (mod *clock* ,interval) 0) (progn ,@body)))

(defun empty? (x y)
  "check to see if a coordinate is within the bounds of the game"
  (if (and (> x 0) (< x *WIDTH*) (> y 0) (< y *HEIGHT*)) t))

