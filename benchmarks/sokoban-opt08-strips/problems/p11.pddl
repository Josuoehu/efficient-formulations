(define (problem p152-microban-sequential)
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
  pos-01-07 - LOCATION
  pos-01-08 - LOCATION
  pos-01-09 - LOCATION
  pos-02-01 - LOCATION
  pos-02-02 - LOCATION
  pos-02-03 - LOCATION
  pos-02-04 - LOCATION
  pos-02-05 - LOCATION
  pos-02-06 - LOCATION
  pos-02-07 - LOCATION
  pos-02-08 - LOCATION
  pos-02-09 - LOCATION
  pos-03-01 - LOCATION
  pos-03-02 - LOCATION
  pos-03-03 - LOCATION
  pos-03-04 - LOCATION
  pos-03-05 - LOCATION
  pos-03-06 - LOCATION
  pos-03-07 - LOCATION
  pos-03-08 - LOCATION
  pos-03-09 - LOCATION
  pos-04-01 - LOCATION
  pos-04-02 - LOCATION
  pos-04-03 - LOCATION
  pos-04-04 - LOCATION
  pos-04-05 - LOCATION
  pos-04-06 - LOCATION
  pos-04-07 - LOCATION
  pos-04-08 - LOCATION
  pos-04-09 - LOCATION
  pos-05-01 - LOCATION
  pos-05-02 - LOCATION
  pos-05-03 - LOCATION
  pos-05-04 - LOCATION
  pos-05-05 - LOCATION
  pos-05-06 - LOCATION
  pos-05-07 - LOCATION
  pos-05-08 - LOCATION
  pos-05-09 - LOCATION
  pos-06-01 - LOCATION
  pos-06-02 - LOCATION
  pos-06-03 - LOCATION
  pos-06-04 - LOCATION
  pos-06-05 - LOCATION
  pos-06-06 - LOCATION
  pos-06-07 - LOCATION
  pos-06-08 - LOCATION
  pos-06-09 - LOCATION
  pos-07-01 - LOCATION
  pos-07-02 - LOCATION
  pos-07-03 - LOCATION
  pos-07-04 - LOCATION
  pos-07-05 - LOCATION
  pos-07-06 - LOCATION
  pos-07-07 - LOCATION
  pos-07-08 - LOCATION
  pos-07-09 - LOCATION
  pos-08-01 - LOCATION
  pos-08-02 - LOCATION
  pos-08-03 - LOCATION
  pos-08-04 - LOCATION
  pos-08-05 - LOCATION
  pos-08-06 - LOCATION
  pos-08-07 - LOCATION
  pos-08-08 - LOCATION
  pos-08-09 - LOCATION
  pos-09-01 - LOCATION
  pos-09-02 - LOCATION
  pos-09-03 - LOCATION
  pos-09-04 - LOCATION
  pos-09-05 - LOCATION
  pos-09-06 - LOCATION
  pos-09-07 - LOCATION
  pos-09-08 - LOCATION
  pos-09-09 - LOCATION
  pos-10-01 - LOCATION
  pos-10-02 - LOCATION
  pos-10-03 - LOCATION
  pos-10-04 - LOCATION
  pos-10-05 - LOCATION
  pos-10-06 - LOCATION
  pos-10-07 - LOCATION
  pos-10-08 - LOCATION
  pos-10-09 - LOCATION
  pos-11-01 - LOCATION
  pos-11-02 - LOCATION
  pos-11-03 - LOCATION
  pos-11-04 - LOCATION
  pos-11-05 - LOCATION
  pos-11-06 - LOCATION
  pos-11-07 - LOCATION
  pos-11-08 - LOCATION
  pos-11-09 - LOCATION
  pos-12-01 - LOCATION
  pos-12-02 - LOCATION
  pos-12-03 - LOCATION
  pos-12-04 - LOCATION
  pos-12-05 - LOCATION
  pos-12-06 - LOCATION
  pos-12-07 - LOCATION
  pos-12-08 - LOCATION
  pos-12-09 - LOCATION
  pos-13-01 - LOCATION
  pos-13-02 - LOCATION
  pos-13-03 - LOCATION
  pos-13-04 - LOCATION
  pos-13-05 - LOCATION
  pos-13-06 - LOCATION
  pos-13-07 - LOCATION
  pos-13-08 - LOCATION
  pos-13-09 - LOCATION
  pos-14-01 - LOCATION
  pos-14-02 - LOCATION
  pos-14-03 - LOCATION
  pos-14-04 - LOCATION
  pos-14-05 - LOCATION
  pos-14-06 - LOCATION
  pos-14-07 - LOCATION
  pos-14-08 - LOCATION
  pos-14-09 - LOCATION
  pos-15-01 - LOCATION
  pos-15-02 - LOCATION
  pos-15-03 - LOCATION
  pos-15-04 - LOCATION
  pos-15-05 - LOCATION
  pos-15-06 - LOCATION
  pos-15-07 - LOCATION
  pos-15-08 - LOCATION
  pos-15-09 - LOCATION
  stone-01 - STONE
  stone-02 - STONE
  stone-03 - STONE
  stone-04 - STONE
)
(:init
  (is-goal pos-02-03)
  (is-goal pos-02-08)
  (is-goal pos-11-08)
  (is-goal pos-13-08)
  (is-nongoal pos-01-01)
  (is-nongoal pos-01-02)
  (is-nongoal pos-01-03)
  (is-nongoal pos-01-04)
  (is-nongoal pos-01-05)
  (is-nongoal pos-01-06)
  (is-nongoal pos-01-07)
  (is-nongoal pos-01-08)
  (is-nongoal pos-01-09)
  (is-nongoal pos-02-01)
  (is-nongoal pos-02-02)
  (is-nongoal pos-02-04)
  (is-nongoal pos-02-05)
  (is-nongoal pos-02-06)
  (is-nongoal pos-02-07)
  (is-nongoal pos-02-09)
  (is-nongoal pos-03-01)
  (is-nongoal pos-03-02)
  (is-nongoal pos-03-03)
  (is-nongoal pos-03-04)
  (is-nongoal pos-03-05)
  (is-nongoal pos-03-06)
  (is-nongoal pos-03-07)
  (is-nongoal pos-03-08)
  (is-nongoal pos-03-09)
  (is-nongoal pos-04-01)
  (is-nongoal pos-04-02)
  (is-nongoal pos-04-03)
  (is-nongoal pos-04-04)
  (is-nongoal pos-04-05)
  (is-nongoal pos-04-06)
  (is-nongoal pos-04-07)
  (is-nongoal pos-04-08)
  (is-nongoal pos-04-09)
  (is-nongoal pos-05-01)
  (is-nongoal pos-05-02)
  (is-nongoal pos-05-03)
  (is-nongoal pos-05-04)
  (is-nongoal pos-05-05)
  (is-nongoal pos-05-06)
  (is-nongoal pos-05-07)
  (is-nongoal pos-05-08)
  (is-nongoal pos-05-09)
  (is-nongoal pos-06-01)
  (is-nongoal pos-06-02)
  (is-nongoal pos-06-03)
  (is-nongoal pos-06-04)
  (is-nongoal pos-06-05)
  (is-nongoal pos-06-06)
  (is-nongoal pos-06-07)
  (is-nongoal pos-06-08)
  (is-nongoal pos-06-09)
  (is-nongoal pos-07-01)
  (is-nongoal pos-07-02)
  (is-nongoal pos-07-03)
  (is-nongoal pos-07-04)
  (is-nongoal pos-07-05)
  (is-nongoal pos-07-06)
  (is-nongoal pos-07-07)
  (is-nongoal pos-07-08)
  (is-nongoal pos-07-09)
  (is-nongoal pos-08-01)
  (is-nongoal pos-08-02)
  (is-nongoal pos-08-03)
  (is-nongoal pos-08-04)
  (is-nongoal pos-08-05)
  (is-nongoal pos-08-06)
  (is-nongoal pos-08-07)
  (is-nongoal pos-08-08)
  (is-nongoal pos-08-09)
  (is-nongoal pos-09-01)
  (is-nongoal pos-09-02)
  (is-nongoal pos-09-03)
  (is-nongoal pos-09-04)
  (is-nongoal pos-09-05)
  (is-nongoal pos-09-06)
  (is-nongoal pos-09-07)
  (is-nongoal pos-09-08)
  (is-nongoal pos-09-09)
  (is-nongoal pos-10-01)
  (is-nongoal pos-10-02)
  (is-nongoal pos-10-03)
  (is-nongoal pos-10-04)
  (is-nongoal pos-10-05)
  (is-nongoal pos-10-06)
  (is-nongoal pos-10-07)
  (is-nongoal pos-10-08)
  (is-nongoal pos-10-09)
  (is-nongoal pos-11-01)
  (is-nongoal pos-11-02)
  (is-nongoal pos-11-03)
  (is-nongoal pos-11-04)
  (is-nongoal pos-11-05)
  (is-nongoal pos-11-06)
  (is-nongoal pos-11-07)
  (is-nongoal pos-11-09)
  (is-nongoal pos-12-01)
  (is-nongoal pos-12-02)
  (is-nongoal pos-12-03)
  (is-nongoal pos-12-04)
  (is-nongoal pos-12-05)
  (is-nongoal pos-12-06)
  (is-nongoal pos-12-07)
  (is-nongoal pos-12-08)
  (is-nongoal pos-12-09)
  (is-nongoal pos-13-01)
  (is-nongoal pos-13-02)
  (is-nongoal pos-13-03)
  (is-nongoal pos-13-04)
  (is-nongoal pos-13-05)
  (is-nongoal pos-13-06)
  (is-nongoal pos-13-07)
  (is-nongoal pos-13-09)
  (is-nongoal pos-14-01)
  (is-nongoal pos-14-02)
  (is-nongoal pos-14-03)
  (is-nongoal pos-14-04)
  (is-nongoal pos-14-05)
  (is-nongoal pos-14-06)
  (is-nongoal pos-14-07)
  (is-nongoal pos-14-08)
  (is-nongoal pos-14-09)
  (is-nongoal pos-15-01)
  (is-nongoal pos-15-02)
  (is-nongoal pos-15-03)
  (is-nongoal pos-15-04)
  (is-nongoal pos-15-05)
  (is-nongoal pos-15-06)
  (is-nongoal pos-15-07)
  (is-nongoal pos-15-08)
  (is-nongoal pos-15-09)
  (move-dir pos-02-02 pos-02-03 dir-down)
  (move-dir pos-02-02 pos-03-02 dir-right)
  (move-dir pos-02-03 pos-02-02 dir-up)
  (move-dir pos-02-03 pos-02-04 dir-down)
  (move-dir pos-02-04 pos-02-03 dir-up)
  (move-dir pos-02-04 pos-02-05 dir-down)
  (move-dir pos-02-04 pos-03-04 dir-right)
  (move-dir pos-02-05 pos-02-04 dir-up)
  (move-dir pos-02-05 pos-02-06 dir-down)
  (move-dir pos-02-05 pos-03-05 dir-right)
  (move-dir pos-02-06 pos-02-05 dir-up)
  (move-dir pos-02-06 pos-02-07 dir-down)
  (move-dir pos-02-07 pos-02-06 dir-up)
  (move-dir pos-02-07 pos-02-08 dir-down)
  (move-dir pos-02-08 pos-02-07 dir-up)
  (move-dir pos-02-08 pos-03-08 dir-right)
  (move-dir pos-03-02 pos-02-02 dir-left)
  (move-dir pos-03-02 pos-04-02 dir-right)
  (move-dir pos-03-04 pos-02-04 dir-left)
  (move-dir pos-03-04 pos-03-05 dir-down)
  (move-dir pos-03-04 pos-04-04 dir-right)
  (move-dir pos-03-05 pos-02-05 dir-left)
  (move-dir pos-03-05 pos-03-04 dir-up)
  (move-dir pos-03-05 pos-04-05 dir-right)
  (move-dir pos-03-08 pos-02-08 dir-left)
  (move-dir pos-03-08 pos-04-08 dir-right)
  (move-dir pos-04-02 pos-03-02 dir-left)
  (move-dir pos-04-02 pos-05-02 dir-right)
  (move-dir pos-04-04 pos-03-04 dir-left)
  (move-dir pos-04-04 pos-04-05 dir-down)
  (move-dir pos-04-05 pos-03-05 dir-left)
  (move-dir pos-04-05 pos-04-04 dir-up)
  (move-dir pos-04-05 pos-04-06 dir-down)
  (move-dir pos-04-06 pos-04-05 dir-up)
  (move-dir pos-04-06 pos-04-07 dir-down)
  (move-dir pos-04-06 pos-05-06 dir-right)
  (move-dir pos-04-07 pos-04-06 dir-up)
  (move-dir pos-04-07 pos-04-08 dir-down)
  (move-dir pos-04-08 pos-03-08 dir-left)
  (move-dir pos-04-08 pos-04-07 dir-up)
  (move-dir pos-04-08 pos-05-08 dir-right)
  (move-dir pos-05-02 pos-04-02 dir-left)
  (move-dir pos-05-02 pos-05-03 dir-down)
  (move-dir pos-05-02 pos-06-02 dir-right)
  (move-dir pos-05-03 pos-05-02 dir-up)
  (move-dir pos-05-03 pos-06-03 dir-right)
  (move-dir pos-05-06 pos-04-06 dir-left)
  (move-dir pos-05-06 pos-06-06 dir-right)
  (move-dir pos-05-08 pos-04-08 dir-left)
  (move-dir pos-05-08 pos-06-08 dir-right)
  (move-dir pos-06-02 pos-05-02 dir-left)
  (move-dir pos-06-02 pos-06-03 dir-down)
  (move-dir pos-06-03 pos-05-03 dir-left)
  (move-dir pos-06-03 pos-06-02 dir-up)
  (move-dir pos-06-03 pos-06-04 dir-down)
  (move-dir pos-06-04 pos-06-03 dir-up)
  (move-dir pos-06-04 pos-06-05 dir-down)
  (move-dir pos-06-04 pos-07-04 dir-right)
  (move-dir pos-06-05 pos-06-04 dir-up)
  (move-dir pos-06-05 pos-06-06 dir-down)
  (move-dir pos-06-06 pos-05-06 dir-left)
  (move-dir pos-06-06 pos-06-05 dir-up)
  (move-dir pos-06-06 pos-07-06 dir-right)
  (move-dir pos-06-08 pos-05-08 dir-left)
  (move-dir pos-06-08 pos-07-08 dir-right)
  (move-dir pos-07-04 pos-06-04 dir-left)
  (move-dir pos-07-04 pos-08-04 dir-right)
  (move-dir pos-07-06 pos-06-06 dir-left)
  (move-dir pos-07-06 pos-08-06 dir-right)
  (move-dir pos-07-08 pos-06-08 dir-left)
  (move-dir pos-07-08 pos-08-08 dir-right)
  (move-dir pos-08-02 pos-08-03 dir-down)
  (move-dir pos-08-02 pos-09-02 dir-right)
  (move-dir pos-08-03 pos-08-02 dir-up)
  (move-dir pos-08-03 pos-08-04 dir-down)
  (move-dir pos-08-04 pos-07-04 dir-left)
  (move-dir pos-08-04 pos-08-03 dir-up)
  (move-dir pos-08-04 pos-09-04 dir-right)
  (move-dir pos-08-06 pos-07-06 dir-left)
  (move-dir pos-08-06 pos-09-06 dir-right)
  (move-dir pos-08-08 pos-07-08 dir-left)
  (move-dir pos-08-08 pos-09-08 dir-right)
  (move-dir pos-09-02 pos-08-02 dir-left)
  (move-dir pos-09-02 pos-10-02 dir-right)
  (move-dir pos-09-04 pos-08-04 dir-left)
  (move-dir pos-09-04 pos-10-04 dir-right)
  (move-dir pos-09-06 pos-08-06 dir-left)
  (move-dir pos-09-06 pos-09-07 dir-down)
  (move-dir pos-09-07 pos-09-06 dir-up)
  (move-dir pos-09-07 pos-09-08 dir-down)
  (move-dir pos-09-07 pos-10-07 dir-right)
  (move-dir pos-09-08 pos-08-08 dir-left)
  (move-dir pos-09-08 pos-09-07 dir-up)
  (move-dir pos-09-08 pos-10-08 dir-right)
  (move-dir pos-10-02 pos-09-02 dir-left)
  (move-dir pos-10-02 pos-11-02 dir-right)
  (move-dir pos-10-04 pos-09-04 dir-left)
  (move-dir pos-10-04 pos-10-05 dir-down)
  (move-dir pos-10-05 pos-10-04 dir-up)
  (move-dir pos-10-05 pos-11-05 dir-right)
  (move-dir pos-10-07 pos-09-07 dir-left)
  (move-dir pos-10-07 pos-10-08 dir-down)
  (move-dir pos-10-08 pos-09-08 dir-left)
  (move-dir pos-10-08 pos-10-07 dir-up)
  (move-dir pos-10-08 pos-11-08 dir-right)
  (move-dir pos-11-02 pos-10-02 dir-left)
  (move-dir pos-11-02 pos-11-03 dir-down)
  (move-dir pos-11-03 pos-11-02 dir-up)
  (move-dir pos-11-03 pos-12-03 dir-right)
  (move-dir pos-11-05 pos-10-05 dir-left)
  (move-dir pos-11-05 pos-11-06 dir-down)
  (move-dir pos-11-06 pos-11-05 dir-up)
  (move-dir pos-11-06 pos-12-06 dir-right)
  (move-dir pos-11-08 pos-10-08 dir-left)
  (move-dir pos-11-08 pos-12-08 dir-right)
  (move-dir pos-12-01 pos-13-01 dir-right)
  (move-dir pos-12-03 pos-11-03 dir-left)
  (move-dir pos-12-03 pos-12-04 dir-down)
  (move-dir pos-12-04 pos-12-03 dir-up)
  (move-dir pos-12-04 pos-13-04 dir-right)
  (move-dir pos-12-06 pos-11-06 dir-left)
  (move-dir pos-12-06 pos-12-07 dir-down)
  (move-dir pos-12-07 pos-12-06 dir-up)
  (move-dir pos-12-07 pos-12-08 dir-down)
  (move-dir pos-12-08 pos-11-08 dir-left)
  (move-dir pos-12-08 pos-12-07 dir-up)
  (move-dir pos-12-08 pos-13-08 dir-right)
  (move-dir pos-13-01 pos-12-01 dir-left)
  (move-dir pos-13-01 pos-13-02 dir-down)
  (move-dir pos-13-01 pos-14-01 dir-right)
  (move-dir pos-13-02 pos-13-01 dir-up)
  (move-dir pos-13-02 pos-14-02 dir-right)
  (move-dir pos-13-04 pos-12-04 dir-left)
  (move-dir pos-13-04 pos-13-05 dir-down)
  (move-dir pos-13-05 pos-13-04 dir-up)
  (move-dir pos-13-05 pos-14-05 dir-right)
  (move-dir pos-13-08 pos-12-08 dir-left)
  (move-dir pos-13-08 pos-14-08 dir-right)
  (move-dir pos-14-01 pos-13-01 dir-left)
  (move-dir pos-14-01 pos-14-02 dir-down)
  (move-dir pos-14-01 pos-15-01 dir-right)
  (move-dir pos-14-02 pos-13-02 dir-left)
  (move-dir pos-14-02 pos-14-01 dir-up)
  (move-dir pos-14-02 pos-14-03 dir-down)
  (move-dir pos-14-02 pos-15-02 dir-right)
  (move-dir pos-14-03 pos-14-02 dir-up)
  (move-dir pos-14-03 pos-15-03 dir-right)
  (move-dir pos-14-05 pos-13-05 dir-left)
  (move-dir pos-14-05 pos-14-06 dir-down)
  (move-dir pos-14-06 pos-14-05 dir-up)
  (move-dir pos-14-06 pos-14-07 dir-down)
  (move-dir pos-14-07 pos-14-06 dir-up)
  (move-dir pos-14-07 pos-14-08 dir-down)
  (move-dir pos-14-08 pos-13-08 dir-left)
  (move-dir pos-14-08 pos-14-07 dir-up)
  (move-dir pos-15-01 pos-14-01 dir-left)
  (move-dir pos-15-01 pos-15-02 dir-down)
  (move-dir pos-15-02 pos-14-02 dir-left)
  (move-dir pos-15-02 pos-15-01 dir-up)
  (move-dir pos-15-02 pos-15-03 dir-down)
  (move-dir pos-15-03 pos-14-03 dir-left)
  (move-dir pos-15-03 pos-15-02 dir-up)
  (move-dir pos-15-03 pos-15-04 dir-down)
  (move-dir pos-15-04 pos-15-03 dir-up)
  (at_player player-01 pos-04-08)
  (at_stone stone-01 pos-08-03)
  (at_stone stone-02 pos-02-05)
  (at_stone stone-03 pos-09-08)
  (at_stone stone-04 pos-11-08)
  (at-goal stone-04)
  (clear pos-02-02)
  (clear pos-02-03)
  (clear pos-02-04)
  (clear pos-02-06)
  (clear pos-02-07)
  (clear pos-02-08)
  (clear pos-03-02)
  (clear pos-03-04)
  (clear pos-03-05)
  (clear pos-03-08)
  (clear pos-04-02)
  (clear pos-04-04)
  (clear pos-04-05)
  (clear pos-04-06)
  (clear pos-04-07)
  (clear pos-05-02)
  (clear pos-05-03)
  (clear pos-05-06)
  (clear pos-05-08)
  (clear pos-06-02)
  (clear pos-06-03)
  (clear pos-06-04)
  (clear pos-06-05)
  (clear pos-06-06)
  (clear pos-06-08)
  (clear pos-07-01)
  (clear pos-07-04)
  (clear pos-07-06)
  (clear pos-07-08)
  (clear pos-08-02)
  (clear pos-08-04)
  (clear pos-08-06)
  (clear pos-08-08)
  (clear pos-09-02)
  (clear pos-09-04)
  (clear pos-09-06)
  (clear pos-09-07)
  (clear pos-10-02)
  (clear pos-10-04)
  (clear pos-10-05)
  (clear pos-10-07)
  (clear pos-10-08)
  (clear pos-11-02)
  (clear pos-11-03)
  (clear pos-11-05)
  (clear pos-11-06)
  (clear pos-12-01)
  (clear pos-12-03)
  (clear pos-12-04)
  (clear pos-12-06)
  (clear pos-12-07)
  (clear pos-12-08)
  (clear pos-13-01)
  (clear pos-13-02)
  (clear pos-13-04)
  (clear pos-13-05)
  (clear pos-13-08)
  (clear pos-14-01)
  (clear pos-14-02)
  (clear pos-14-03)
  (clear pos-14-05)
  (clear pos-14-06)
  (clear pos-14-07)
  (clear pos-14-08)
  (clear pos-15-01)
  (clear pos-15-02)
  (clear pos-15-03)
  (clear pos-15-04)
)
(:goal   (and (at-goal stone-01)
  (at-goal stone-02)
  (at-goal stone-03)
  (at-goal stone-04)))
)
