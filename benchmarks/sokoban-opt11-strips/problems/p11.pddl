(define (problem p142-microban-sequential)
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
  pos-1-7 - LOCATION
  pos-1-8 - LOCATION
  pos-1-9 - LOCATION
  pos-2-1 - LOCATION
  pos-2-2 - LOCATION
  pos-2-3 - LOCATION
  pos-2-4 - LOCATION
  pos-2-5 - LOCATION
  pos-2-6 - LOCATION
  pos-2-7 - LOCATION
  pos-2-8 - LOCATION
  pos-2-9 - LOCATION
  pos-3-1 - LOCATION
  pos-3-2 - LOCATION
  pos-3-3 - LOCATION
  pos-3-4 - LOCATION
  pos-3-5 - LOCATION
  pos-3-6 - LOCATION
  pos-3-7 - LOCATION
  pos-3-8 - LOCATION
  pos-3-9 - LOCATION
  pos-4-1 - LOCATION
  pos-4-2 - LOCATION
  pos-4-3 - LOCATION
  pos-4-4 - LOCATION
  pos-4-5 - LOCATION
  pos-4-6 - LOCATION
  pos-4-7 - LOCATION
  pos-4-8 - LOCATION
  pos-4-9 - LOCATION
  pos-5-1 - LOCATION
  pos-5-2 - LOCATION
  pos-5-3 - LOCATION
  pos-5-4 - LOCATION
  pos-5-5 - LOCATION
  pos-5-6 - LOCATION
  pos-5-7 - LOCATION
  pos-5-8 - LOCATION
  pos-5-9 - LOCATION
  pos-6-1 - LOCATION
  pos-6-2 - LOCATION
  pos-6-3 - LOCATION
  pos-6-4 - LOCATION
  pos-6-5 - LOCATION
  pos-6-6 - LOCATION
  pos-6-7 - LOCATION
  pos-6-8 - LOCATION
  pos-6-9 - LOCATION
  pos-7-1 - LOCATION
  pos-7-2 - LOCATION
  pos-7-3 - LOCATION
  pos-7-4 - LOCATION
  pos-7-5 - LOCATION
  pos-7-6 - LOCATION
  pos-7-7 - LOCATION
  pos-7-8 - LOCATION
  pos-7-9 - LOCATION
  pos-8-1 - LOCATION
  pos-8-2 - LOCATION
  pos-8-3 - LOCATION
  pos-8-4 - LOCATION
  pos-8-5 - LOCATION
  pos-8-6 - LOCATION
  pos-8-7 - LOCATION
  pos-8-8 - LOCATION
  pos-8-9 - LOCATION
  pos-9-1 - LOCATION
  pos-9-2 - LOCATION
  pos-9-3 - LOCATION
  pos-9-4 - LOCATION
  pos-9-5 - LOCATION
  pos-9-6 - LOCATION
  pos-9-7 - LOCATION
  pos-9-8 - LOCATION
  pos-9-9 - LOCATION
  stone-01 - STONE
  stone-02 - STONE
  stone-03 - STONE
  stone-04 - STONE
)
(:init
  (is-goal pos-4-5)
  (is-goal pos-5-4)
  (is-goal pos-5-6)
  (is-goal pos-6-5)
  (is-nongoal pos-1-1)
  (is-nongoal pos-1-2)
  (is-nongoal pos-1-3)
  (is-nongoal pos-1-4)
  (is-nongoal pos-1-5)
  (is-nongoal pos-1-6)
  (is-nongoal pos-1-7)
  (is-nongoal pos-1-8)
  (is-nongoal pos-1-9)
  (is-nongoal pos-2-1)
  (is-nongoal pos-2-2)
  (is-nongoal pos-2-3)
  (is-nongoal pos-2-4)
  (is-nongoal pos-2-5)
  (is-nongoal pos-2-6)
  (is-nongoal pos-2-7)
  (is-nongoal pos-2-8)
  (is-nongoal pos-2-9)
  (is-nongoal pos-3-1)
  (is-nongoal pos-3-2)
  (is-nongoal pos-3-3)
  (is-nongoal pos-3-4)
  (is-nongoal pos-3-5)
  (is-nongoal pos-3-6)
  (is-nongoal pos-3-7)
  (is-nongoal pos-3-8)
  (is-nongoal pos-3-9)
  (is-nongoal pos-4-1)
  (is-nongoal pos-4-2)
  (is-nongoal pos-4-3)
  (is-nongoal pos-4-4)
  (is-nongoal pos-4-6)
  (is-nongoal pos-4-7)
  (is-nongoal pos-4-8)
  (is-nongoal pos-4-9)
  (is-nongoal pos-5-1)
  (is-nongoal pos-5-2)
  (is-nongoal pos-5-3)
  (is-nongoal pos-5-5)
  (is-nongoal pos-5-7)
  (is-nongoal pos-5-8)
  (is-nongoal pos-5-9)
  (is-nongoal pos-6-1)
  (is-nongoal pos-6-2)
  (is-nongoal pos-6-3)
  (is-nongoal pos-6-4)
  (is-nongoal pos-6-6)
  (is-nongoal pos-6-7)
  (is-nongoal pos-6-8)
  (is-nongoal pos-6-9)
  (is-nongoal pos-7-1)
  (is-nongoal pos-7-2)
  (is-nongoal pos-7-3)
  (is-nongoal pos-7-4)
  (is-nongoal pos-7-5)
  (is-nongoal pos-7-6)
  (is-nongoal pos-7-7)
  (is-nongoal pos-7-8)
  (is-nongoal pos-7-9)
  (is-nongoal pos-8-1)
  (is-nongoal pos-8-2)
  (is-nongoal pos-8-3)
  (is-nongoal pos-8-4)
  (is-nongoal pos-8-5)
  (is-nongoal pos-8-6)
  (is-nongoal pos-8-7)
  (is-nongoal pos-8-8)
  (is-nongoal pos-8-9)
  (is-nongoal pos-9-1)
  (is-nongoal pos-9-2)
  (is-nongoal pos-9-3)
  (is-nongoal pos-9-4)
  (is-nongoal pos-9-5)
  (is-nongoal pos-9-6)
  (is-nongoal pos-9-7)
  (is-nongoal pos-9-8)
  (is-nongoal pos-9-9)
  (move-dir pos-1-1 pos-1-2 dir-down)
  (move-dir pos-1-1 pos-2-1 dir-right)
  (move-dir pos-1-2 pos-1-1 dir-up)
  (move-dir pos-1-2 pos-1-3 dir-down)
  (move-dir pos-1-2 pos-2-2 dir-right)
  (move-dir pos-1-3 pos-1-2 dir-up)
  (move-dir pos-1-3 pos-2-3 dir-right)
  (move-dir pos-1-8 pos-1-9 dir-down)
  (move-dir pos-1-8 pos-2-8 dir-right)
  (move-dir pos-1-9 pos-1-8 dir-up)
  (move-dir pos-1-9 pos-2-9 dir-right)
  (move-dir pos-2-1 pos-1-1 dir-left)
  (move-dir pos-2-1 pos-2-2 dir-down)
  (move-dir pos-2-2 pos-1-2 dir-left)
  (move-dir pos-2-2 pos-2-1 dir-up)
  (move-dir pos-2-2 pos-2-3 dir-down)
  (move-dir pos-2-3 pos-1-3 dir-left)
  (move-dir pos-2-3 pos-2-2 dir-up)
  (move-dir pos-2-5 pos-2-6 dir-down)
  (move-dir pos-2-5 pos-3-5 dir-right)
  (move-dir pos-2-6 pos-2-5 dir-up)
  (move-dir pos-2-6 pos-3-6 dir-right)
  (move-dir pos-2-8 pos-1-8 dir-left)
  (move-dir pos-2-8 pos-2-9 dir-down)
  (move-dir pos-2-8 pos-3-8 dir-right)
  (move-dir pos-2-9 pos-1-9 dir-left)
  (move-dir pos-2-9 pos-2-8 dir-up)
  (move-dir pos-2-9 pos-3-9 dir-right)
  (move-dir pos-3-5 pos-2-5 dir-left)
  (move-dir pos-3-5 pos-3-6 dir-down)
  (move-dir pos-3-5 pos-4-5 dir-right)
  (move-dir pos-3-6 pos-2-6 dir-left)
  (move-dir pos-3-6 pos-3-5 dir-up)
  (move-dir pos-3-6 pos-4-6 dir-right)
  (move-dir pos-3-8 pos-2-8 dir-left)
  (move-dir pos-3-8 pos-3-9 dir-down)
  (move-dir pos-3-9 pos-2-9 dir-left)
  (move-dir pos-3-9 pos-3-8 dir-up)
  (move-dir pos-4-2 pos-4-3 dir-down)
  (move-dir pos-4-2 pos-5-2 dir-right)
  (move-dir pos-4-3 pos-4-2 dir-up)
  (move-dir pos-4-3 pos-4-4 dir-down)
  (move-dir pos-4-3 pos-5-3 dir-right)
  (move-dir pos-4-4 pos-4-3 dir-up)
  (move-dir pos-4-4 pos-4-5 dir-down)
  (move-dir pos-4-4 pos-5-4 dir-right)
  (move-dir pos-4-5 pos-3-5 dir-left)
  (move-dir pos-4-5 pos-4-4 dir-up)
  (move-dir pos-4-5 pos-4-6 dir-down)
  (move-dir pos-4-5 pos-5-5 dir-right)
  (move-dir pos-4-6 pos-3-6 dir-left)
  (move-dir pos-4-6 pos-4-5 dir-up)
  (move-dir pos-4-6 pos-5-6 dir-right)
  (move-dir pos-5-2 pos-4-2 dir-left)
  (move-dir pos-5-2 pos-5-3 dir-down)
  (move-dir pos-5-3 pos-4-3 dir-left)
  (move-dir pos-5-3 pos-5-2 dir-up)
  (move-dir pos-5-3 pos-5-4 dir-down)
  (move-dir pos-5-4 pos-4-4 dir-left)
  (move-dir pos-5-4 pos-5-3 dir-up)
  (move-dir pos-5-4 pos-5-5 dir-down)
  (move-dir pos-5-4 pos-6-4 dir-right)
  (move-dir pos-5-5 pos-4-5 dir-left)
  (move-dir pos-5-5 pos-5-4 dir-up)
  (move-dir pos-5-5 pos-5-6 dir-down)
  (move-dir pos-5-5 pos-6-5 dir-right)
  (move-dir pos-5-6 pos-4-6 dir-left)
  (move-dir pos-5-6 pos-5-5 dir-up)
  (move-dir pos-5-6 pos-5-7 dir-down)
  (move-dir pos-5-6 pos-6-6 dir-right)
  (move-dir pos-5-7 pos-5-6 dir-up)
  (move-dir pos-5-7 pos-5-8 dir-down)
  (move-dir pos-5-7 pos-6-7 dir-right)
  (move-dir pos-5-8 pos-5-7 dir-up)
  (move-dir pos-5-8 pos-6-8 dir-right)
  (move-dir pos-6-4 pos-5-4 dir-left)
  (move-dir pos-6-4 pos-6-5 dir-down)
  (move-dir pos-6-4 pos-7-4 dir-right)
  (move-dir pos-6-5 pos-5-5 dir-left)
  (move-dir pos-6-5 pos-6-4 dir-up)
  (move-dir pos-6-5 pos-6-6 dir-down)
  (move-dir pos-6-5 pos-7-5 dir-right)
  (move-dir pos-6-6 pos-5-6 dir-left)
  (move-dir pos-6-6 pos-6-5 dir-up)
  (move-dir pos-6-6 pos-6-7 dir-down)
  (move-dir pos-6-7 pos-5-7 dir-left)
  (move-dir pos-6-7 pos-6-6 dir-up)
  (move-dir pos-6-7 pos-6-8 dir-down)
  (move-dir pos-6-8 pos-5-8 dir-left)
  (move-dir pos-6-8 pos-6-7 dir-up)
  (move-dir pos-7-1 pos-7-2 dir-down)
  (move-dir pos-7-1 pos-8-1 dir-right)
  (move-dir pos-7-2 pos-7-1 dir-up)
  (move-dir pos-7-2 pos-8-2 dir-right)
  (move-dir pos-7-4 pos-6-4 dir-left)
  (move-dir pos-7-4 pos-7-5 dir-down)
  (move-dir pos-7-4 pos-8-4 dir-right)
  (move-dir pos-7-5 pos-6-5 dir-left)
  (move-dir pos-7-5 pos-7-4 dir-up)
  (move-dir pos-7-5 pos-8-5 dir-right)
  (move-dir pos-8-1 pos-7-1 dir-left)
  (move-dir pos-8-1 pos-8-2 dir-down)
  (move-dir pos-8-1 pos-9-1 dir-right)
  (move-dir pos-8-2 pos-7-2 dir-left)
  (move-dir pos-8-2 pos-8-1 dir-up)
  (move-dir pos-8-2 pos-9-2 dir-right)
  (move-dir pos-8-4 pos-7-4 dir-left)
  (move-dir pos-8-4 pos-8-5 dir-down)
  (move-dir pos-8-5 pos-7-5 dir-left)
  (move-dir pos-8-5 pos-8-4 dir-up)
  (move-dir pos-8-7 pos-8-8 dir-down)
  (move-dir pos-8-7 pos-9-7 dir-right)
  (move-dir pos-8-8 pos-8-7 dir-up)
  (move-dir pos-8-8 pos-8-9 dir-down)
  (move-dir pos-8-8 pos-9-8 dir-right)
  (move-dir pos-8-9 pos-8-8 dir-up)
  (move-dir pos-8-9 pos-9-9 dir-right)
  (move-dir pos-9-1 pos-8-1 dir-left)
  (move-dir pos-9-1 pos-9-2 dir-down)
  (move-dir pos-9-2 pos-8-2 dir-left)
  (move-dir pos-9-2 pos-9-1 dir-up)
  (move-dir pos-9-7 pos-8-7 dir-left)
  (move-dir pos-9-7 pos-9-8 dir-down)
  (move-dir pos-9-8 pos-8-8 dir-left)
  (move-dir pos-9-8 pos-9-7 dir-up)
  (move-dir pos-9-8 pos-9-9 dir-down)
  (move-dir pos-9-9 pos-8-9 dir-left)
  (move-dir pos-9-9 pos-9-8 dir-up)
  (at_player player-01 pos-5-5)
  (at_stone stone-01 pos-4-4)
  (at_stone stone-02 pos-6-4)
  (at_stone stone-03 pos-4-6)
  (at_stone stone-04 pos-6-6)
  (clear pos-1-1)
  (clear pos-1-2)
  (clear pos-1-3)
  (clear pos-1-8)
  (clear pos-1-9)
  (clear pos-2-1)
  (clear pos-2-2)
  (clear pos-2-3)
  (clear pos-2-5)
  (clear pos-2-6)
  (clear pos-2-8)
  (clear pos-2-9)
  (clear pos-3-5)
  (clear pos-3-6)
  (clear pos-3-8)
  (clear pos-3-9)
  (clear pos-4-2)
  (clear pos-4-3)
  (clear pos-4-5)
  (clear pos-5-2)
  (clear pos-5-3)
  (clear pos-5-4)
  (clear pos-5-6)
  (clear pos-5-7)
  (clear pos-5-8)
  (clear pos-6-5)
  (clear pos-6-7)
  (clear pos-6-8)
  (clear pos-7-1)
  (clear pos-7-2)
  (clear pos-7-4)
  (clear pos-7-5)
  (clear pos-8-1)
  (clear pos-8-2)
  (clear pos-8-4)
  (clear pos-8-5)
  (clear pos-8-7)
  (clear pos-8-8)
  (clear pos-8-9)
  (clear pos-9-1)
  (clear pos-9-2)
  (clear pos-9-7)
  (clear pos-9-8)
  (clear pos-9-9)
)
(:goal   (and (at-goal stone-01)
  (at-goal stone-02)
  (at-goal stone-03)
  (at-goal stone-04)))
)
