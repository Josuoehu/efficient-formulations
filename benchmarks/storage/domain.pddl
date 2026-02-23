(define (domain storage-propositional)
(:requirements :strips :typing)
(:types 
  container - OBJECT
  storearea -OBJECT
  depot - OBJECT
  crate - OBJECT
  hoist - OBJECT
  transitarea - OBJECT
)
(:predicates 
  (clear ?s - STOREAREA)
  (in_storearea_container ?x - STOREAREA ?p - CONTAINER)
  (in_crate_container ?x - CRATE ?p - CONTAINER)
  (in_storearea_depot ?x - STOREAREA ?p - DEPOT)
  (in_crate_depot ?x - CRATE ?p - DEPOT)
  (available ?h - HOIST)
  (lifting ?h - HOIST ?c - CRATE)
  (at_storearea ?h - HOIST ?a - STOREAREA)
  (at_transitarea ?h - HOIST ?a - TRANSITAREA)
  (on ?c - CRATE ?s - STOREAREA)
  (connected_storearea_storearea ?a1 - STOREAREA ?a2 - STOREAREA)
  (connected_storearea_transitarea ?a1 - STOREAREA ?a2 - TRANSITAREA)
  (connected_transitarea_storearea ?a1 - TRANSITAREA ?a2 - STOREAREA)
  (connected_transitarea_transitarea ?a1 - TRANSITAREA ?a2 - TRANSITAREA)
  (compatible ?c1 - CRATE ?c2 - CRATE)
)
(:action move
:parameters (?h - HOIST ?from - STOREAREA ?to - STOREAREA)
:precondition 
  (and (at_storearea ?h ?from)
  (clear ?to)
  (connected_storearea_storearea ?from ?to))
:effect 
  (and (not (at_storearea ?h ?from))
  (at_storearea ?h ?to)
  (not (clear ?to))
  (clear ?from))
)
(:action go-out
:parameters (?h - HOIST ?from - STOREAREA ?to - TRANSITAREA)
:precondition 
  (and (at_storearea ?h ?from)
  (connected_storearea_transitarea ?from ?to))
:effect 
  (and (not (at_storearea ?h ?from))
  (at_transitarea ?h ?to)
  (clear ?from))
)
(:action go-in
:parameters (?h - HOIST ?from - TRANSITAREA ?to - STOREAREA)
:precondition 
  (and (at_transitarea ?h ?from)
  (connected_transitarea_storearea ?from ?to)
  (clear ?to))
:effect 
  (and (not (at_transitarea ?h ?from))
  (at_storearea ?h ?to)
  (not (clear ?to)))
)
(:action lift_storearea_container
:parameters (?h - HOIST ?c - CRATE ?a1 - STOREAREA ?a2 - STOREAREA ?p - CONTAINER)
:precondition 
  (and (connected_storearea_storearea ?a1 ?a2)
  (at_storearea ?h ?a2)
  (available ?h)
  (on ?c ?a1)
  (in_storearea_container ?a1 ?p))
:effect 
  (and (not (on ?c ?a1))
  (clear ?a1)
  (not (available ?h))
  (lifting ?h ?c)
  (not (in_crate_container ?c ?p)))
)
(:action lift_storearea_depot
:parameters (?h - HOIST ?c - CRATE ?a1 - STOREAREA ?a2 - STOREAREA ?p - DEPOT)
:precondition 
  (and (connected_storearea_storearea ?a1 ?a2)
  (at_storearea ?h ?a2)
  (available ?h)
  (on ?c ?a1)
  (in_storearea_depot ?a1 ?p))
:effect 
  (and (not (on ?c ?a1))
  (clear ?a1)
  (not (available ?h))
  (lifting ?h ?c)
  (not (in_crate_depot ?c ?p)))
)
(:action lift_transitarea_container
:parameters (?h - HOIST ?c - CRATE ?a1 - STOREAREA ?a2 - TRANSITAREA ?p - CONTAINER)
:precondition 
  (and (connected_storearea_transitarea ?a1 ?a2)
  (at_transitarea ?h ?a2)
  (available ?h)
  (on ?c ?a1)
  (in_storearea_container ?a1 ?p))
:effect 
  (and (not (on ?c ?a1))
  (clear ?a1)
  (not (available ?h))
  (lifting ?h ?c)
  (not (in_crate_container ?c ?p)))
)
(:action lift_transitarea_depot
:parameters (?h - HOIST ?c - CRATE ?a1 - STOREAREA ?a2 - TRANSITAREA ?p - DEPOT)
:precondition 
  (and (connected_storearea_transitarea ?a1 ?a2)
  (at_transitarea ?h ?a2)
  (available ?h)
  (on ?c ?a1)
  (in_storearea_depot ?a1 ?p))
:effect 
  (and (not (on ?c ?a1))
  (clear ?a1)
  (not (available ?h))
  (lifting ?h ?c)
  (not (in_crate_depot ?c ?p)))
)
(:action drop_storearea_container
:parameters (?h - HOIST ?c - CRATE ?a1 - STOREAREA ?a2 - STOREAREA ?p - CONTAINER)
:precondition 
  (and (connected_storearea_storearea ?a1 ?a2)
  (at_storearea ?h ?a2)
  (lifting ?h ?c)
  (clear ?a1)
  (in_storearea_container ?a1 ?p))
:effect 
  (and (not (lifting ?h ?c))
  (available ?h)
  (not (clear ?a1))
  (on ?c ?a1)
  (in_crate_container ?c ?p))
)
(:action drop_storearea_depot
:parameters (?h - HOIST ?c - CRATE ?a1 - STOREAREA ?a2 - STOREAREA ?p - DEPOT)
:precondition 
  (and (connected_storearea_storearea ?a1 ?a2)
  (at_storearea ?h ?a2)
  (lifting ?h ?c)
  (clear ?a1)
  (in_storearea_depot ?a1 ?p))
:effect 
  (and (not (lifting ?h ?c))
  (available ?h)
  (not (clear ?a1))
  (on ?c ?a1)
  (in_crate_depot ?c ?p))
)
(:action drop_transitarea_container
:parameters (?h - HOIST ?c - CRATE ?a1 - STOREAREA ?a2 - TRANSITAREA ?p - CONTAINER)
:precondition 
  (and (connected_storearea_transitarea ?a1 ?a2)
  (at_transitarea ?h ?a2)
  (lifting ?h ?c)
  (clear ?a1)
  (in_storearea_container ?a1 ?p))
:effect 
  (and (not (lifting ?h ?c))
  (available ?h)
  (not (clear ?a1))
  (on ?c ?a1)
  (in_crate_container ?c ?p))
)
(:action drop_transitarea_depot
:parameters (?h - HOIST ?c - CRATE ?a1 - STOREAREA ?a2 - TRANSITAREA ?p - DEPOT)
:precondition 
  (and (connected_storearea_transitarea ?a1 ?a2)
  (at_transitarea ?h ?a2)
  (lifting ?h ?c)
  (clear ?a1)
  (in_storearea_depot ?a1 ?p))
:effect 
  (and (not (lifting ?h ?c))
  (available ?h)
  (not (clear ?a1))
  (on ?c ?a1)
  (in_crate_depot ?c ?p))
)
)
