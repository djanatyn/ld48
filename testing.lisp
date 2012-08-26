;; stuff to test the game quickly

;; the test creature!
;; ------------------
(defvar *creature* (make-instance 'creature :x 50 :y 50 :health 100))
(defun reset-test-creature ()
  (setf (creature-x *creature*) 50)
  (setf (creature-y *creature*) 50)
  (setf (creature-color *creature*) (random-color)))
