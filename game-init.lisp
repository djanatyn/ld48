;; the actual game
;; ---------------

(eval-when (:compile-toplevel)
  (defpackage :ld48 (:use :common-lisp :lispbuilder-sdl))
  (in-package :ld48)
  (mapcar #'load '("settings.lisp" "utilities.lisp" "creature.lisp" "player.lisp" "testing.lisp")))

(reset-player)

(defun key-handler (key)
  "handle input"
  (flet ((key-is (key-to-test) (key= key-to-test key)))
    (cond ((key-is :sdl-key-up)     (move-player 0 -5))
	  ((key-is :sdl-key-down)   (move-player 0 5))
	  ((key-is :sdl-key-right)  (move-player 5 0))
	  ((key-is :sdl-key-left)   (move-player -5 0))
	  ((key-is :sdl-key-space)  (drop-creature))
	  ((key-is :sdl-key-escape) (push-quit-event)))))

(defun run-game ()
  (with-init ()
    (if *fullscreen?* (window *WIDTH* *HEIGHT* :fullscreen t) (window *WIDTH* *HEIGHT*))
    (enable-key-repeat 1 1)
    (setf (frame-rate) 60)
    (with-events ()
      (:quit-event () t)
      (:key-down-event (:key key) (key-handler key))
      (:idle ()
	     (clear-display *black*)
	     (draw-player)
	     (mapcar #'draw *creatures*)
	     (tick)
	     (on-tick 10 (mapcar #'move *creatures*))
	     (update-display)))))
