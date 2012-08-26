;; utility functions for the ld48 game

(defun random-color ()
  "generate a random SDL color"
  (sdl:color :r (random 256) :g (random 256) :b (random 256)))

(defvar *clock* 0)

(defun tick ()
  "increase the clock"
  (incf *clock*))
(defmacro on-tick (interval &body body)
  `(if (= (mod *clock* ,interval) 0) (progn ,@body)))
