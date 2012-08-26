(defvar *player-x* 0)
(defvar *player-y* 0)

(defun move-player (x y)
  (setf *player-x* (+ *player-x* x))
  (setf *player-y* (+ *player-y* (* -1 y))))

(defun draw-player ()
  (sdl-gfx:draw-circle (point :x *player-x* :y *player-y*) 20 :color *white*))
