(define (domain sokoban-sequential)
(:requirements :strips :typing :action-costs)
(:types 
  location - OBJECT
  thing - OBJECT
  direction - OBJECT
  player - THING
  stone - THING
)
(:predicates 
  (clear ?l - LOCATION)
  (at_player ?t - PLAYER ?l - LOCATION)
  (at_stone ?t - STONE ?l - LOCATION)
  (at-goal ?s - STONE)
  (is-goal ?l - LOCATION)
  (is-nongoal ?l - LOCATION)
  (move-dir ?from - LOCATION ?to - LOCATION ?dir - DIRECTION)
)
(:action move
:parameters (?p - PLAYER ?from - LOCATION ?to - LOCATION ?dir - DIRECTION)
:precondition 
  (and (at_player ?p ?from)
  (clear ?to)
  (move-dir ?from ?to ?dir))
:effect 
  (and (not (at_player ?p ?from))
  (not (clear ?to))
  (at_player ?p ?to)
  (clear ?from))
)
(:action push-to-nongoal
:parameters (?p - PLAYER ?s - STONE ?ppos - LOCATION ?from - LOCATION ?to - LOCATION ?dir - DIRECTION)
:precondition 
  (and (at_player ?p ?ppos)
  (at_stone ?s ?from)
  (clear ?to)
  (move-dir ?ppos ?from ?dir)
  (move-dir ?from ?to ?dir)
  (is-nongoal ?to))
:effect 
  (and (not (at_player ?p ?ppos))
  (not (at_stone ?s ?from))
  (not (clear ?to))
  (at_player ?p ?from)
  (at_stone ?s ?to)
  (clear ?ppos)
  (not (at-goal ?s)))
)
(:action push-to-goal
:parameters (?p - PLAYER ?s - STONE ?ppos - LOCATION ?from - LOCATION ?to - LOCATION ?dir - DIRECTION)
:precondition 
  (and (at_player ?p ?ppos)
  (at_stone ?s ?from)
  (clear ?to)
  (move-dir ?ppos ?from ?dir)
  (move-dir ?from ?to ?dir)
  (is-goal ?to))
:effect 
  (and (not (at_player ?p ?ppos))
  (not (at_stone ?s ?from))
  (not (clear ?to))
  (at_player ?p ?from)
  (at_stone ?s ?to)
  (clear ?ppos)
  (at-goal ?s))
)
)
