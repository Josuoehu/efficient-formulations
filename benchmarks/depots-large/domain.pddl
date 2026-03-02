(define (domain depots)
(:requirements :strips :typing)
(:types 
  depot - PLACE
  surface - LOCATABLE
  truck - LOCATABLE
  pallet - SURFACE
  place - OBJECT
  crate - SURFACE
  locatable - OBJECT
  distributor - PLACE
  hoist - LOCATABLE
)
(:predicates 
  (at_crate_depot ?x - CRATE ?y - DEPOT)
  (at_crate_distributor ?x - CRATE ?y - DISTRIBUTOR)
  (at_hoist_depot ?x - HOIST ?y - DEPOT)
  (at_hoist_distributor ?x - HOIST ?y - DISTRIBUTOR)
  (at_pallet_depot ?x - PALLET ?y - DEPOT)
  (at_pallet_distributor ?x - PALLET ?y - DISTRIBUTOR)
  (at_truck_depot ?x - TRUCK ?y - DEPOT)
  (at_truck_distributor ?x - TRUCK ?y - DISTRIBUTOR)
  (on_crate ?x - CRATE ?y - CRATE)
  (on_pallet ?x - CRATE ?y - PALLET)
  (in ?x - CRATE ?y - TRUCK)
  (lifting ?x - HOIST ?y - CRATE)
  (available ?x - HOIST)
  (clear_crate ?x - CRATE)
  (clear_pallet ?x - PALLET)
)
(:action drive_depot_depot
:parameters (?x - TRUCK ?y - DEPOT ?z - DEPOT)
:precondition 
  (and (at_truck_depot ?x ?y))
:effect 
  (and (not (at_truck_depot ?x ?y))
  (at_truck_depot ?x ?z))
)
(:action drive_depot_distributor
:parameters (?x - TRUCK ?y - DEPOT ?z - DISTRIBUTOR)
:precondition 
  (and (at_truck_depot ?x ?y))
:effect 
  (and (not (at_truck_depot ?x ?y))
  (at_truck_distributor ?x ?z))
)
(:action drive_distributor_depot
:parameters (?x - TRUCK ?y - DISTRIBUTOR ?z - DEPOT)
:precondition 
  (and (at_truck_distributor ?x ?y))
:effect 
  (and (not (at_truck_distributor ?x ?y))
  (at_truck_depot ?x ?z))
)
(:action drive_distributor_distributor
:parameters (?x - TRUCK ?y - DISTRIBUTOR ?z - DISTRIBUTOR)
:precondition 
  (and (at_truck_distributor ?x ?y))
:effect 
  (and (not (at_truck_distributor ?x ?y))
  (at_truck_distributor ?x ?z))
)
(:action lift_crate_depot
:parameters (?x - HOIST ?y - CRATE ?z - CRATE ?p - DEPOT)
:precondition 
  (and (at_hoist_depot ?x ?p)
  (available ?x)
  (at_crate_depot ?y ?p)
  (on_crate ?y ?z)
  (clear_crate ?y))
:effect 
  (and (not (at_crate_depot ?y ?p))
  (lifting ?x ?y)
  (not (clear_crate ?y))
  (not (available ?x))
  (clear_crate ?z)
  (not (on_crate ?y ?z)))
)
(:action lift_crate_distributor
:parameters (?x - HOIST ?y - CRATE ?z - CRATE ?p - DISTRIBUTOR)
:precondition 
  (and (at_hoist_distributor ?x ?p)
  (available ?x)
  (at_crate_distributor ?y ?p)
  (on_crate ?y ?z)
  (clear_crate ?y))
:effect 
  (and (not (at_crate_distributor ?y ?p))
  (lifting ?x ?y)
  (not (clear_crate ?y))
  (not (available ?x))
  (clear_crate ?z)
  (not (on_crate ?y ?z)))
)
(:action lift_pallet_depot
:parameters (?x - HOIST ?y - CRATE ?z - PALLET ?p - DEPOT)
:precondition 
  (and (at_hoist_depot ?x ?p)
  (available ?x)
  (at_crate_depot ?y ?p)
  (on_pallet ?y ?z)
  (clear_crate ?y))
:effect 
  (and (not (at_crate_depot ?y ?p))
  (lifting ?x ?y)
  (not (clear_crate ?y))
  (not (available ?x))
  (clear_pallet ?z)
  (not (on_pallet ?y ?z)))
)
(:action lift_pallet_distributor
:parameters (?x - HOIST ?y - CRATE ?z - PALLET ?p - DISTRIBUTOR)
:precondition 
  (and (at_hoist_distributor ?x ?p)
  (available ?x)
  (at_crate_distributor ?y ?p)
  (on_pallet ?y ?z)
  (clear_crate ?y))
:effect 
  (and (not (at_crate_distributor ?y ?p))
  (lifting ?x ?y)
  (not (clear_crate ?y))
  (not (available ?x))
  (clear_pallet ?z)
  (not (on_pallet ?y ?z)))
)
(:action drop_crate_depot
:parameters (?x - HOIST ?y - CRATE ?z - CRATE ?p - DEPOT)
:precondition 
  (and (at_hoist_depot ?x ?p)
  (at_crate_depot ?z ?p)
  (clear_crate ?z)
  (lifting ?x ?y))
:effect 
  (and (available ?x)
  (not (lifting ?x ?y))
  (at_crate_depot ?y ?p)
  (not (clear_crate ?z))
  (clear_crate ?y)
  (on_crate ?y ?z))
)
(:action drop_crate_distributor
:parameters (?x - HOIST ?y - CRATE ?z - CRATE ?p - DISTRIBUTOR)
:precondition 
  (and (at_hoist_distributor ?x ?p)
  (at_crate_distributor ?z ?p)
  (clear_crate ?z)
  (lifting ?x ?y))
:effect 
  (and (available ?x)
  (not (lifting ?x ?y))
  (at_crate_distributor ?y ?p)
  (not (clear_crate ?z))
  (clear_crate ?y)
  (on_crate ?y ?z))
)
(:action drop_pallet_depot
:parameters (?x - HOIST ?y - CRATE ?z - PALLET ?p - DEPOT)
:precondition 
  (and (at_hoist_depot ?x ?p)
  (at_pallet_depot ?z ?p)
  (clear_pallet ?z)
  (lifting ?x ?y))
:effect 
  (and (available ?x)
  (not (lifting ?x ?y))
  (at_crate_depot ?y ?p)
  (not (clear_pallet ?z))
  (clear_crate ?y)
  (on_pallet ?y ?z))
)
(:action drop_pallet_distributor
:parameters (?x - HOIST ?y - CRATE ?z - PALLET ?p - DISTRIBUTOR)
:precondition 
  (and (at_hoist_distributor ?x ?p)
  (at_pallet_distributor ?z ?p)
  (clear_pallet ?z)
  (lifting ?x ?y))
:effect 
  (and (available ?x)
  (not (lifting ?x ?y))
  (at_crate_distributor ?y ?p)
  (not (clear_pallet ?z))
  (clear_crate ?y)
  (on_pallet ?y ?z))
)
(:action load_depot
:parameters (?x - HOIST ?y - CRATE ?z - TRUCK ?p - DEPOT)
:precondition 
  (and (at_hoist_depot ?x ?p)
  (at_truck_depot ?z ?p)
  (lifting ?x ?y))
:effect 
  (and (not (lifting ?x ?y))
  (in ?y ?z)
  (available ?x))
)
(:action load_distributor
:parameters (?x - HOIST ?y - CRATE ?z - TRUCK ?p - DISTRIBUTOR)
:precondition 
  (and (at_hoist_distributor ?x ?p)
  (at_truck_distributor ?z ?p)
  (lifting ?x ?y))
:effect 
  (and (not (lifting ?x ?y))
  (in ?y ?z)
  (available ?x))
)
(:action unload_depot
:parameters (?x - HOIST ?y - CRATE ?z - TRUCK ?p - DEPOT)
:precondition 
  (and (at_hoist_depot ?x ?p)
  (at_truck_depot ?z ?p)
  (available ?x)
  (in ?y ?z))
:effect 
  (and (not (in ?y ?z))
  (not (available ?x))
  (lifting ?x ?y))
)
(:action unload_distributor
:parameters (?x - HOIST ?y - CRATE ?z - TRUCK ?p - DISTRIBUTOR)
:precondition 
  (and (at_hoist_distributor ?x ?p)
  (at_truck_distributor ?z ?p)
  (available ?x)
  (in ?y ?z))
:effect 
  (and (not (in ?y ?z))
  (not (available ?x))
  (lifting ?x ?y))
)
)
