(define (domain socks-and-shoes)
 (:requirements :strips :typing :negative-preconditions)
 (:types side - thing)

 (:predicates
  (shoe ?x - side)
  (sock ?x - side))

 (:action put_shoe
  :parameters (?x - side)
  :precondition (sock ?x)
  :effect (shoe ?x))

 (:action put_sock
  :parameters (?x - side)
  :precondition (not (shoe ?x))
  :effect (sock ?x))

)
