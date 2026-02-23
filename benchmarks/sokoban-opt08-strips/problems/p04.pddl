(define (problem p006-microban-sequential)
(:domain sokoban-sequential)
(:objects 
  dir-down - DIRECTION
  dir-left - DIRECTION
  dir-right - DIRECTION
  dir-up - DIRECTION
  player-01 - PLAYER
  pos-01-01 - LOCATION
  pos-01-02 - LOCATION
  pos-01-03 - LOCATION
  pos-01-04 - LOCATION
  pos-01-05 - LOCATION
  pos-01-06 - LOCATION
  pos-02-01 - LOCATION
  pos-02-02 - LOCATION
  pos-02-03 - LOCATION
  pos-02-04 - LOCATION
  pos-02-05 - LOCATION
  pos-02-06 - LOCATION
  pos-03-01 - LOCATION
  pos-03-02 - LOCATION
  pos-03-03 - LOCATION
  pos-03-04 - LOCATION
  pos-03-05 - LOCATION
  pos-03-06 - LOCATION
  pos-04-01 - LOCATION
  pos-04-02 - LOCATION
  pos-04-03 - LOCATION
  pos-04-04 - LOCATION
  pos-04-05 - LOCATION
  pos-04-06 - LOCATION
  pos-05-01 - LOCATION
  pos-05-02 - LOCATION
  pos-05-03 - LOCATION
  pos-05-04 - LOCATION
  pos-05-05 - LOCATION
  pos-05-06 - LOCATION
  pos-06-01 - LOCATION
  pos-06-02 - LOCATION
  pos-06-03 - LOCATION
  pos-06-04 - LOCATION
  pos-06-05 - LOCATION
  pos-06-06 - LOCATION
  pos-07-01 - LOCATION
  pos-07-02 - LOCATION
  pos-07-03 - LOCATION
  pos-07-04 - LOCATION
  pos-07-05 - LOCATION
  pos-07-06 - LOCATION
  pos-08-01 - LOCATION
  pos-08-02 - LOCATION
  pos-08-03 - LOCATION
  pos-08-04 - LOCATION
  pos-08-05 - LOCATION
  pos-08-06 - LOCATION
  pos-09-01 - LOCATION
  pos-09-02 - LOCATION
  pos-09-03 - LOCATION
  pos-09-04 - LOCATION
  pos-09-05 - LOCATION
  pos-09-06 - LOCATION
  pos-10-01 - LOCATION
  pos-10-02 - LOCATION
  pos-10-03 - LOCATION
  pos-10-04 - LOCATION
  pos-10-05 - LOCATION
  pos-10-06 - LOCATION
  pos-11-01 - LOCATION
  pos-11-02 - LOCATION
  pos-11-03 - LOCATION
  pos-11-04 - LOCATION
  pos-11-05 - LOCATION
  pos-11-06 - LOCATION
  pos-12-01 - LOCATION
  pos-12-02 - LOCATION
  pos-12-03 - LOCATION
  pos-12-04 - LOCATION
  pos-12-05 - LOCATION
  pos-12-06 - LOCATION
  stone-01 - STONE
  stone-02 - STONE
  stone-03 - STONE
)
(:init
  (is-goal pos-06-04)
  (is-goal pos-07-04)
  (is-goal pos-08-04)
  (is-nongoal pos-01-01)
  (is-nongoal pos-01-02)
  (is-nongoal pos-01-03)
  (is-nongoal pos-01-04)
  (is-nongoal pos-01-05)
  (is-nongoal pos-01-06)
  (is-nongoal pos-02-01)
  (is-nongoal pos-02-02)
  (is-nongoal pos-02-03)
  (is-nongoal pos-02-04)
  (is-nongoal pos-02-05)
  (is-nongoal pos-02-06)
  (is-nongoal pos-03-01)
  (is-nongoal pos-03-02)
  (is-nongoal pos-03-03)
  (is-nongoal pos-03-04)
  (is-nongoal pos-03-05)
  (is-nongoal pos-03-06)
  (is-nongoal pos-04-01)
  (is-nongoal pos-04-02)
  (is-nongoal pos-04-03)
  (is-nongoal pos-04-04)
  (is-nongoal pos-04-05)
  (is-nongoal pos-04-06)
  (is-nongoal pos-05-01)
  (is-nongoal pos-05-02)
  (is-nongoal pos-05-03)
  (is-nongoal pos-05-04)
  (is-nongoal pos-05-05)
  (is-nongoal pos-05-06)
  (is-nongoal pos-06-01)
  (is-nongoal pos-06-02)
  (is-nongoal pos-06-03)
  (is-nongoal pos-06-05)
  (is-nongoal pos-06-06)
  (is-nongoal pos-07-01)
  (is-nongoal pos-07-02)
  (is-nongoal pos-07-03)
  (is-nongoal pos-07-05)
  (is-nongoal pos-07-06)
  (is-nongoal pos-08-01)
  (is-nongoal pos-08-02)
  (is-nongoal pos-08-03)
  (is-nongoal pos-08-05)
  (is-nongoal pos-08-06)
  (is-nongoal pos-09-01)
  (is-nongoal pos-09-02)
  (is-nongoal pos-09-03)
  (is-nongoal pos-09-04)
  (is-nongoal pos-09-05)
  (is-nongoal pos-09-06)
  (is-nongoal pos-10-01)
  (is-nongoal pos-10-02)
  (is-nongoal pos-10-03)
  (is-nongoal pos-10-04)
  (is-nongoal pos-10-05)
  (is-nongoal pos-10-06)
  (is-nongoal pos-11-01)
  (is-nongoal pos-11-02)
  (is-nongoal pos-11-03)
  (is-nongoal pos-11-04)
  (is-nongoal pos-11-05)
  (is-nongoal pos-11-06)
  (is-nongoal pos-12-01)
  (is-nongoal pos-12-02)
  (is-nongoal pos-12-03)
  (is-nongoal pos-12-04)
  (is-nongoal pos-12-05)
  (is-nongoal pos-12-06)
  (move-dir pos-02-02 pos-02-03 dir-down)
  (move-dir pos-02-02 pos-03-02 dir-right)
  (move-dir pos-02-03 pos-02-02 dir-up)
  (move-dir pos-02-03 pos-02-04 dir-down)
  (move-dir pos-02-03 pos-03-03 dir-right)
  (move-dir pos-02-04 pos-02-03 dir-up)
  (move-dir pos-02-04 pos-02-05 dir-down)
  (move-dir pos-02-04 pos-03-04 dir-right)
  (move-dir pos-02-05 pos-02-04 dir-up)
  (move-dir pos-02-05 pos-03-05 dir-right)
  (move-dir pos-03-02 pos-02-02 dir-left)
  (move-dir pos-03-02 pos-03-03 dir-down)
  (move-dir pos-03-02 pos-04-02 dir-right)
  (move-dir pos-03-03 pos-02-03 dir-left)
  (move-dir pos-03-03 pos-03-02 dir-up)
  (move-dir pos-03-03 pos-03-04 dir-down)
  (move-dir pos-03-03 pos-04-03 dir-right)
  (move-dir pos-03-04 pos-02-04 dir-left)
  (move-dir pos-03-04 pos-03-03 dir-up)
  (move-dir pos-03-04 pos-03-05 dir-down)
  (move-dir pos-03-04 pos-04-04 dir-right)
  (move-dir pos-03-05 pos-02-05 dir-left)
  (move-dir pos-03-05 pos-03-04 dir-up)
  (move-dir pos-03-05 pos-04-05 dir-right)
  (move-dir pos-04-02 pos-03-02 dir-left)
  (move-dir pos-04-02 pos-04-03 dir-down)
  (move-dir pos-04-02 pos-05-02 dir-right)
  (move-dir pos-04-03 pos-03-03 dir-left)
  (move-dir pos-04-03 pos-04-02 dir-up)
  (move-dir pos-04-03 pos-04-04 dir-down)
  (move-dir pos-04-03 pos-05-03 dir-right)
  (move-dir pos-04-04 pos-03-04 dir-left)
  (move-dir pos-04-04 pos-04-03 dir-up)
  (move-dir pos-04-04 pos-04-05 dir-down)
  (move-dir pos-04-05 pos-03-05 dir-left)
  (move-dir pos-04-05 pos-04-04 dir-up)
  (move-dir pos-05-02 pos-04-02 dir-left)
  (move-dir pos-05-02 pos-05-03 dir-down)
  (move-dir pos-05-03 pos-04-03 dir-left)
  (move-dir pos-05-03 pos-05-02 dir-up)
  (move-dir pos-05-03 pos-06-03 dir-right)
  (move-dir pos-06-03 pos-05-03 dir-left)
  (move-dir pos-06-03 pos-06-04 dir-down)
  (move-dir pos-06-03 pos-07-03 dir-right)
  (move-dir pos-06-04 pos-06-03 dir-up)
  (move-dir pos-06-04 pos-07-04 dir-right)
  (move-dir pos-06-06 pos-07-06 dir-right)
  (move-dir pos-07-03 pos-06-03 dir-left)
  (move-dir pos-07-03 pos-07-04 dir-down)
  (move-dir pos-07-03 pos-08-03 dir-right)
  (move-dir pos-07-04 pos-06-04 dir-left)
  (move-dir pos-07-04 pos-07-03 dir-up)
  (move-dir pos-07-04 pos-08-04 dir-right)
  (move-dir pos-07-06 pos-06-06 dir-left)
  (move-dir pos-07-06 pos-08-06 dir-right)
  (move-dir pos-08-03 pos-07-03 dir-left)
  (move-dir pos-08-03 pos-08-04 dir-down)
  (move-dir pos-08-03 pos-09-03 dir-right)
  (move-dir pos-08-04 pos-07-04 dir-left)
  (move-dir pos-08-04 pos-08-03 dir-up)
  (move-dir pos-08-04 pos-09-04 dir-right)
  (move-dir pos-08-06 pos-07-06 dir-left)
  (move-dir pos-08-06 pos-09-06 dir-right)
  (move-dir pos-09-02 pos-09-03 dir-down)
  (move-dir pos-09-02 pos-10-02 dir-right)
  (move-dir pos-09-03 pos-08-03 dir-left)
  (move-dir pos-09-03 pos-09-02 dir-up)
  (move-dir pos-09-03 pos-09-04 dir-down)
  (move-dir pos-09-04 pos-08-04 dir-left)
  (move-dir pos-09-04 pos-09-03 dir-up)
  (move-dir pos-09-04 pos-10-04 dir-right)
  (move-dir pos-09-06 pos-08-06 dir-left)
  (move-dir pos-09-06 pos-10-06 dir-right)
  (move-dir pos-10-02 pos-09-02 dir-left)
  (move-dir pos-10-02 pos-11-02 dir-right)
  (move-dir pos-10-04 pos-09-04 dir-left)
  (move-dir pos-10-04 pos-11-04 dir-right)
  (move-dir pos-10-06 pos-09-06 dir-left)
  (move-dir pos-10-06 pos-11-06 dir-right)
  (move-dir pos-11-02 pos-10-02 dir-left)
  (move-dir pos-11-02 pos-11-03 dir-down)
  (move-dir pos-11-03 pos-11-02 dir-up)
  (move-dir pos-11-03 pos-11-04 dir-down)
  (move-dir pos-11-04 pos-10-04 dir-left)
  (move-dir pos-11-04 pos-11-03 dir-up)
  (move-dir pos-11-06 pos-10-06 dir-left)
  (move-dir pos-11-06 pos-12-06 dir-right)
  (move-dir pos-12-06 pos-11-06 dir-left)
  (at_player player-01 pos-11-03)
  (at_stone stone-01 pos-03-03)
  (at_stone stone-02 pos-04-03)
  (at_stone stone-03 pos-03-04)
  (clear pos-02-02)
  (clear pos-02-03)
  (clear pos-02-04)
  (clear pos-02-05)
  (clear pos-03-02)
  (clear pos-03-05)
  (clear pos-04-02)
  (clear pos-04-04)
  (clear pos-04-05)
  (clear pos-05-02)
  (clear pos-05-03)
  (clear pos-06-03)
  (clear pos-06-04)
  (clear pos-06-06)
  (clear pos-07-01)
  (clear pos-07-03)
  (clear pos-07-04)
  (clear pos-07-06)
  (clear pos-08-03)
  (clear pos-08-04)
  (clear pos-08-06)
  (clear pos-09-02)
  (clear pos-09-03)
  (clear pos-09-04)
  (clear pos-09-06)
  (clear pos-10-02)
  (clear pos-10-04)
  (clear pos-10-06)
  (clear pos-11-02)
  (clear pos-11-04)
  (clear pos-11-06)
  (clear pos-12-06)
)
(:goal   (and (at-goal stone-01)
  (at-goal stone-02)
  (at-goal stone-03)))
)
