(define (domain transport-strips)
(:requirements :strips :typing :action-costs)
(:types 
  package - LOCATABLE
  truck - LOCATABLE
  location - OBJECT
  locatable - OBJECT
  fuellevel - OBJECT
)
(:predicates 
  (connected ?l1 - LOCATION ?l2 - LOCATION)
  (at_package ?o - PACKAGE ?l - LOCATION)
  (at_truck ?o - TRUCK ?l - LOCATION)
  (in ?p - PACKAGE ?t - TRUCK)
  (fuel ?t - TRUCK ?level - FUELLEVEL)
  (fuelcost ?level - FUELLEVEL ?l1 - LOCATION ?l2 - LOCATION)
  (sum ?a - FUELLEVEL ?b - FUELLEVEL ?c - FUELLEVEL)
)
(:action load
:parameters (?p - PACKAGE ?t - TRUCK ?l - LOCATION)
:precondition 
  (and (at_truck ?t ?l)
  (at_package ?p ?l))
:effect 
  (and (not (at_package ?p ?l))
  (in ?p ?t))
)
(:action unload
:parameters (?p - PACKAGE ?t - TRUCK ?l - LOCATION)
:precondition 
  (and (at_truck ?t ?l)
  (in ?p ?t))
:effect 
  (and (at_package ?p ?l)
  (not (in ?p ?t)))
)
(:action drive
:parameters (?t - TRUCK ?l1 - LOCATION ?l2 - LOCATION ?fuelpost - FUELLEVEL ?fueldelta - FUELLEVEL ?fuelpre - FUELLEVEL)
:precondition 
  (and (connected ?l1 ?l2)
  (fuelcost ?fueldelta ?l1 ?l2)
  (fuel ?t ?fuelpre)
  (sum ?fuelpost ?fueldelta ?fuelpre)
  (at_truck ?t ?l1))
:effect 
  (and (not (at_truck ?t ?l1))
  (at_truck ?t ?l2)
  (not (fuel ?t ?fuelpre))
  (fuel ?t ?fuelpost))
)
)
