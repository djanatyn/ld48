;; player
;; ------

(defvar *player-x* 0)
(defvar *player-y* 0)
(defvar *player-health* 50)

(defun move-player (x y)
  "add x and y to player coordinates if it lands him in an inbounds space"
  (if (apply #'empty? (mapcar #'+ (list x y) (list *player-x* *player-y*)))
      (progn (incf *player-x* x) (incf *player-y* y))))

(defun draw-player ()
  "draw the player to the screen"
  (sdl-gfx:draw-circle (point :x *player-x* :y *player-y*) *player-health* :color *white*))

(defun reset-player ()
  "send the player back to the center"
  (setf *player-x* (/ *WIDTH* 2))
  (setf *player-y* (/ *HEIGHT* 2))
  (setf *player-health* 20))

(defun drop-creature ()
  "drop creatures at the player's feet"
  (if (>= *player-health* 5)
      (progn (setf *creatures* (cons (make-instance 'creature :health 20 :x *player-x* :y *player-y*) *creatures*))
	     (decf *player-health* 5))))

(defun gain-health ()
  (if (< *player-health* 50) (incf *player-health* 1)))
