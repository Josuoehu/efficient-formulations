(define (domain htg-child-snack)
(:requirements :strips :typing :equality)
(:types 
  tray - OBJECT
  bread-portion - OBJECT
  content-portion - OBJECT
  sandwich - OBJECT
  place - OBJECT
  content-description - OBJECT
  child - OBJECT
)
(:constants 
  kitchen - PLACE
)
(:predicates 
  (at_kitchen_bread ?b - BREAD-PORTION)
  (at_kitchen_content ?c - CONTENT-PORTION)
  (at_kitchen_sandwich ?s - SANDWICH)
  (descr ?c - CONTENT-PORTION ?d - CONTENT-DESCRIPTION)
  (sandwich_contents ?s - SANDWICH ?d0 - CONTENT-DESCRIPTION ?d1 - CONTENT-DESCRIPTION)
  (ontray ?s - SANDWICH ?t - TRAY)
  (likes ?c - CHILD ?d - CONTENT-DESCRIPTION)
  (served ?c - CHILD)
  (waiting ?c - CHILD ?p - PLACE)
  (at ?t - TRAY ?p - PLACE)
  (notexist ?s - SANDWICH)
)
(:action make_sandwich
:parameters (?s - SANDWICH ?b - BREAD-PORTION ?c0 - CONTENT-PORTION ?c1 - CONTENT-PORTION ?d0 - CONTENT-DESCRIPTION ?d1 - CONTENT-DESCRIPTION)
:precondition 
  (and (at_kitchen_bread ?b)
  (at_kitchen_content ?c0)
  (at_kitchen_content ?c1)
  (not (= ?d0 ?d1))
  (descr ?c0 ?d0)
  (descr ?c1 ?d1)
  (notexist ?s))
:effect 
  (and (not (at_kitchen_bread ?b))
  (not (at_kitchen_content ?c0))
  (not (at_kitchen_content ?c1))
  (at_kitchen_sandwich ?s)
  (sandwich_contents ?s ?d0 ?d1)
  (not (notexist ?s)))
)
(:action put_on_tray
:parameters (?s - SANDWICH ?t - TRAY)
:precondition 
  (and (at_kitchen_sandwich ?s)
  (at ?t kitchen))
:effect 
  (and (not (at_kitchen_sandwich ?s))
  (ontray ?s ?t))
)
(:action serve_sandwich
:parameters (?s - SANDWICH ?d0 - CONTENT-DESCRIPTION ?d1 - CONTENT-DESCRIPTION ?c - CHILD ?t - TRAY ?p - PLACE)
:precondition 
  (and (sandwich_contents ?s ?d0 ?d1)
  (ontray ?s ?t)
  (waiting ?c ?p)
  (likes ?c ?d0)
  (likes ?c ?d1)
  (at ?t ?p))
:effect 
  (and (not (ontray ?s ?t))
  (served ?c))
)
(:action move_tray
:parameters (?t - TRAY ?p1 - PLACE ?p2 - PLACE)
:precondition 
  (and (at ?t ?p1))
:effect 
  (and (not (at ?t ?p1))
  (at ?t ?p2))
)
)
