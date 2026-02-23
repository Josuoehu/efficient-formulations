(define (domain tpp-propositional)
(:requirements :strips :typing)
(:types 
  market - PLACE
  depot - PLACE
  level - OBJECT
  truck - LOCATABLE
  goods - LOCATABLE
  place - OBJECT
  locatable - OBJECT
)
(:predicates 
  (loaded ?g - GOODS ?t - TRUCK ?l - LEVEL)
  (ready-to-load ?g - GOODS ?m - MARKET ?l - LEVEL)
  (stored ?g - GOODS ?l - LEVEL)
  (on-sale ?g - GOODS ?m - MARKET ?l - LEVEL)
  (next ?l1 - LEVEL ?l2 - LEVEL)
  (at_depot ?t - TRUCK ?p - DEPOT)
  (at_market ?t - TRUCK ?p - MARKET)
  (connected_depot_depot ?p1 - DEPOT ?p2 - DEPOT)
  (connected_depot_market ?p1 - DEPOT ?p2 - MARKET)
  (connected_market_depot ?p1 - MARKET ?p2 - DEPOT)
  (connected_market_market ?p1 - MARKET ?p2 - MARKET)
)
(:action load
:parameters (?g - GOODS ?t - TRUCK ?m - MARKET ?l1 - LEVEL ?l2 - LEVEL ?l3 - LEVEL ?l4 - LEVEL)
:precondition 
  (and (at_market ?t ?m)
  (loaded ?g ?t ?l3)
  (ready-to-load ?g ?m ?l2)
  (next ?l2 ?l1)
  (next ?l4 ?l3))
:effect 
  (and (loaded ?g ?t ?l4)
  (not (loaded ?g ?t ?l3))
  (ready-to-load ?g ?m ?l1)
  (not (ready-to-load ?g ?m ?l2)))
)
(:action unload
:parameters (?g - GOODS ?t - TRUCK ?d - DEPOT ?l1 - LEVEL ?l2 - LEVEL ?l3 - LEVEL ?l4 - LEVEL)
:precondition 
  (and (at_depot ?t ?d)
  (loaded ?g ?t ?l2)
  (stored ?g ?l3)
  (next ?l2 ?l1)
  (next ?l4 ?l3))
:effect 
  (and (loaded ?g ?t ?l1)
  (not (loaded ?g ?t ?l2))
  (stored ?g ?l4)
  (not (stored ?g ?l3)))
)
(:action buy
:parameters (?t - TRUCK ?g - GOODS ?m - MARKET ?l1 - LEVEL ?l2 - LEVEL ?l3 - LEVEL ?l4 - LEVEL)
:precondition 
  (and (at_market ?t ?m)
  (on-sale ?g ?m ?l2)
  (ready-to-load ?g ?m ?l3)
  (next ?l2 ?l1)
  (next ?l4 ?l3))
:effect 
  (and (on-sale ?g ?m ?l1)
  (not (on-sale ?g ?m ?l2))
  (ready-to-load ?g ?m ?l4)
  (not (ready-to-load ?g ?m ?l3)))
)
(:action drive_depot_depot
:parameters (?t - TRUCK ?from - DEPOT ?to - DEPOT)
:precondition 
  (and (at_depot ?t ?from)
  (connected_depot_depot ?from ?to))
:effect 
  (and (not (at_depot ?t ?from))
  (at_depot ?t ?to))
)
(:action drive_depot_market
:parameters (?t - TRUCK ?from - DEPOT ?to - MARKET)
:precondition 
  (and (at_depot ?t ?from)
  (connected_depot_market ?from ?to))
:effect 
  (and (not (at_depot ?t ?from))
  (at_market ?t ?to))
)
(:action drive_market_depot
:parameters (?t - TRUCK ?from - MARKET ?to - DEPOT)
:precondition 
  (and (at_market ?t ?from)
  (connected_market_depot ?from ?to))
:effect 
  (and (not (at_market ?t ?from))
  (at_depot ?t ?to))
)
(:action drive_market_market
:parameters (?t - TRUCK ?from - MARKET ?to - MARKET)
:precondition 
  (and (at_market ?t ?from)
  (connected_market_market ?from ?to))
:effect 
  (and (not (at_market ?t ?from))
  (at_market ?t ?to))
)
)
