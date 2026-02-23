(define (problem p014-microban-sequential)
(:domain sokoban-sequential)
(:objects 
  dir-down - DIRECTION
  dir-left - DIRECTION
  dir-right - DIRECTION
  dir-up - DIRECTION
  player-01 - PLAYER
  pos-1-1 - LOCATION
  pos-1-2 - LOCATION
  pos-1-3 - LOCATION
  pos-1-4 - LOCATION
  pos-1-5 - LOCATION
  pos-1-6 - LOCATION
  pos-2-1 - LOCATION
  pos-2-2 - LOCATION
  pos-2-3 - LOCATION
  pos-2-4 - LOCATION
  pos-2-5 - LOCATION
  pos-2-6 - LOCATION
  pos-3-1 - LOCATION
  pos-3-2 - LOCATION
  pos-3-3 - LOCATION
  pos-3-4 - LOCATION
  pos-3-5 - LOCATION
  pos-3-6 - LOCATION
  pos-4-1 - LOCATION
  pos-4-2 - LOCATION
  pos-4-3 - LOCATION
  pos-4-4 - LOCATION
  pos-4-5 - LOCATION
  pos-4-6 - LOCATION
  pos-5-1 - LOCATION
  pos-5-2 - LOCATION
  pos-5-3 - LOCATION
  pos-5-4 - LOCATION
  pos-5-5 - LOCATION
  pos-5-6 - LOCATION
  pos-6-1 - LOCATION
  pos-6-2 - LOCATION
  pos-6-3 - LOCATION
  pos-6-4 - LOCATION
  pos-6-5 - LOCATION
  pos-6-6 - LOCATION
  pos-7-1 - LOCATION
  pos-7-2 - LOCATION
  pos-7-3 - LOCATION
  pos-7-4 - LOCATION
  pos-7-5 - LOCATION
  pos-7-6 - LOCATION
  stone-01 - STONE
  stone-02 - STONE
)
(:init
  (is-goal pos-2-4)
  (is-goal pos-5-4)
  (is-nongoal pos-1-1)
  (is-nongoal pos-1-2)
  (is-nongoal pos-1-3)
  (is-nongoal pos-1-4)
  (is-nongoal pos-1-5)
  (is-nongoal pos-1-6)
  (is-nongoal pos-2-1)
  (is-nongoal pos-2-2)
  (is-nongoal pos-2-3)
  (is-nongoal pos-2-5)
  (is-nongoal pos-2-6)
  (is-nongoal pos-3-1)
  (is-nongoal pos-3-2)
  (is-nongoal pos-3-3)
  (is-nongoal pos-3-4)
  (is-nongoal pos-3-5)
  (is-nongoal pos-3-6)
  (is-nongoal pos-4-1)
  (is-nongoal pos-4-2)
  (is-nongoal pos-4-3)
  (is-nongoal pos-4-4)
  (is-nongoal pos-4-5)
  (is-nongoal pos-4-6)
  (is-nongoal pos-5-1)
  (is-nongoal pos-5-2)
  (is-nongoal pos-5-3)
  (is-nongoal pos-5-5)
  (is-nongoal pos-5-6)
  (is-nongoal pos-6-1)
  (is-nongoal pos-6-2)
  (is-nongoal pos-6-3)
  (is-nongoal pos-6-4)
  (is-nongoal pos-6-5)
  (is-nongoal pos-6-6)
  (is-nongoal pos-7-1)
  (is-nongoal pos-7-2)
  (is-nongoal pos-7-3)
  (is-nongoal pos-7-4)
  (is-nongoal pos-7-5)
  (is-nongoal pos-7-6)
  (move-dir pos-2-2 pos-2-3 dir-down)
  (move-dir pos-2-2 pos-3-2 dir-right)
  (move-dir pos-2-3 pos-2-2 dir-up)
  (move-dir pos-2-3 pos-2-4 dir-down)
  (move-dir pos-2-4 pos-2-3 dir-up)
  (move-dir pos-2-4 pos-2-5 dir-down)
  (move-dir pos-2-4 pos-3-4 dir-right)
  (move-dir pos-2-5 pos-2-4 dir-up)
  (move-dir pos-2-5 pos-3-5 dir-right)
  (move-dir pos-3-2 pos-2-2 dir-left)
  (move-dir pos-3-2 pos-4-2 dir-right)
  (move-dir pos-3-4 pos-2-4 dir-left)
  (move-dir pos-3-4 pos-3-5 dir-down)
  (move-dir pos-3-4 pos-4-4 dir-right)
  (move-dir pos-3-5 pos-2-5 dir-left)
  (move-dir pos-3-5 pos-3-4 dir-up)
  (move-dir pos-3-5 pos-4-5 dir-right)
  (move-dir pos-4-2 pos-3-2 dir-left)
  (move-dir pos-4-2 pos-4-3 dir-down)
  (move-dir pos-4-2 pos-5-2 dir-right)
  (move-dir pos-4-3 pos-4-2 dir-up)
  (move-dir pos-4-3 pos-4-4 dir-down)
  (move-dir pos-4-4 pos-3-4 dir-left)
  (move-dir pos-4-4 pos-4-3 dir-up)
  (move-dir pos-4-4 pos-4-5 dir-down)
  (move-dir pos-4-4 pos-5-4 dir-right)
  (move-dir pos-4-5 pos-3-5 dir-left)
  (move-dir pos-4-5 pos-4-4 dir-up)
  (move-dir pos-5-2 pos-4-2 dir-left)
  (move-dir pos-5-2 pos-6-2 dir-right)
  (move-dir pos-5-4 pos-4-4 dir-left)
  (move-dir pos-5-4 pos-6-4 dir-right)
  (move-dir pos-6-2 pos-5-2 dir-left)
  (move-dir pos-6-2 pos-6-3 dir-down)
  (move-dir pos-6-3 pos-6-2 dir-up)
  (move-dir pos-6-3 pos-6-4 dir-down)
  (move-dir pos-6-4 pos-5-4 dir-left)
  (move-dir pos-6-4 pos-6-3 dir-up)
  (move-dir pos-6-6 pos-7-6 dir-right)
  (move-dir pos-7-6 pos-6-6 dir-left)
  (at_player player-01 pos-6-4)
  (at_stone stone-01 pos-4-4)
  (at_stone stone-02 pos-5-4)
  (at-goal stone-02)
  (clear pos-2-2)
  (clear pos-2-3)
  (clear pos-2-4)
  (clear pos-2-5)
  (clear pos-3-2)
  (clear pos-3-4)
  (clear pos-3-5)
  (clear pos-4-2)
  (clear pos-4-3)
  (clear pos-4-5)
  (clear pos-5-2)
  (clear pos-6-2)
  (clear pos-6-3)
  (clear pos-6-6)
  (clear pos-7-6)
)
(:goal   (and (at-goal stone-01)
  (at-goal stone-02)))
)
