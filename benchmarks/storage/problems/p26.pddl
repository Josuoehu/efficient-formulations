(define (problem storage-26)
(:domain storage-propositional)
(:objects 
  depot0-1-1 - STOREAREA
  depot0-1-2 - STOREAREA
  depot0-1-3 - STOREAREA
  depot0-1-4 - STOREAREA
  depot0-2-1 - STOREAREA
  depot0-2-2 - STOREAREA
  depot0-2-3 - STOREAREA
  depot0-2-4 - STOREAREA
  depot1-1-1 - STOREAREA
  depot1-1-2 - STOREAREA
  depot1-1-3 - STOREAREA
  depot1-1-4 - STOREAREA
  depot1-2-1 - STOREAREA
  depot1-2-2 - STOREAREA
  depot1-2-3 - STOREAREA
  depot1-2-4 - STOREAREA
  depot2-1-1 - STOREAREA
  depot2-1-2 - STOREAREA
  depot2-1-3 - STOREAREA
  depot2-1-4 - STOREAREA
  depot2-2-1 - STOREAREA
  depot2-2-2 - STOREAREA
  depot2-2-3 - STOREAREA
  depot2-2-4 - STOREAREA
  depot3-1-1 - STOREAREA
  depot3-1-2 - STOREAREA
  depot3-1-3 - STOREAREA
  depot3-1-4 - STOREAREA
  depot3-2-1 - STOREAREA
  depot3-2-2 - STOREAREA
  depot3-2-3 - STOREAREA
  depot3-2-4 - STOREAREA
  container-0-0 - STOREAREA
  container-0-1 - STOREAREA
  container-0-2 - STOREAREA
  container-0-3 - STOREAREA
  container-1-0 - STOREAREA
  container-1-1 - STOREAREA
  container-1-2 - STOREAREA
  container-1-3 - STOREAREA
  container-2-0 - STOREAREA
  container-2-1 - STOREAREA
  container-2-2 - STOREAREA
  container-2-3 - STOREAREA
  container-3-0 - STOREAREA
  container-3-1 - STOREAREA
  container-3-2 - STOREAREA
  container-3-3 - STOREAREA
  hoist0 - HOIST
  hoist1 - HOIST
  hoist2 - HOIST
  hoist3 - HOIST
  hoist4 - HOIST
  crate0 - CRATE
  crate1 - CRATE
  crate2 - CRATE
  crate3 - CRATE
  crate4 - CRATE
  crate5 - CRATE
  crate6 - CRATE
  crate7 - CRATE
  crate8 - CRATE
  crate9 - CRATE
  crate10 - CRATE
  crate11 - CRATE
  crate12 - CRATE
  crate13 - CRATE
  crate14 - CRATE
  crate15 - CRATE
  container0 - CONTAINER
  container1 - CONTAINER
  container2 - CONTAINER
  container3 - CONTAINER
  depot0 - DEPOT
  depot1 - DEPOT
  depot2 - DEPOT
  depot3 - DEPOT
  loadarea - TRANSITAREA
  transit0 - TRANSITAREA
)
(:init
  (connected_storearea_storearea depot0-1-1 depot0-2-1)
  (connected_storearea_storearea depot0-1-1 depot0-1-2)
  (connected_storearea_storearea depot0-1-2 depot0-2-2)
  (connected_storearea_storearea depot0-1-2 depot0-1-3)
  (connected_storearea_storearea depot0-1-2 depot0-1-1)
  (connected_storearea_storearea depot0-1-3 depot0-2-3)
  (connected_storearea_storearea depot0-1-3 depot0-1-4)
  (connected_storearea_storearea depot0-1-3 depot0-1-2)
  (connected_storearea_storearea depot0-1-4 depot0-2-4)
  (connected_storearea_storearea depot0-1-4 depot0-1-3)
  (connected_storearea_storearea depot0-2-1 depot0-1-1)
  (connected_storearea_storearea depot0-2-1 depot0-2-2)
  (connected_storearea_storearea depot0-2-2 depot0-1-2)
  (connected_storearea_storearea depot0-2-2 depot0-2-3)
  (connected_storearea_storearea depot0-2-2 depot0-2-1)
  (connected_storearea_storearea depot0-2-3 depot0-1-3)
  (connected_storearea_storearea depot0-2-3 depot0-2-4)
  (connected_storearea_storearea depot0-2-3 depot0-2-2)
  (connected_storearea_storearea depot0-2-4 depot0-1-4)
  (connected_storearea_storearea depot0-2-4 depot0-2-3)
  (connected_storearea_storearea depot1-1-1 depot1-2-1)
  (connected_storearea_storearea depot1-1-1 depot1-1-2)
  (connected_storearea_storearea depot1-1-2 depot1-2-2)
  (connected_storearea_storearea depot1-1-2 depot1-1-3)
  (connected_storearea_storearea depot1-1-2 depot1-1-1)
  (connected_storearea_storearea depot1-1-3 depot1-2-3)
  (connected_storearea_storearea depot1-1-3 depot1-1-4)
  (connected_storearea_storearea depot1-1-3 depot1-1-2)
  (connected_storearea_storearea depot1-1-4 depot1-2-4)
  (connected_storearea_storearea depot1-1-4 depot1-1-3)
  (connected_storearea_storearea depot1-2-1 depot1-1-1)
  (connected_storearea_storearea depot1-2-1 depot1-2-2)
  (connected_storearea_storearea depot1-2-2 depot1-1-2)
  (connected_storearea_storearea depot1-2-2 depot1-2-3)
  (connected_storearea_storearea depot1-2-2 depot1-2-1)
  (connected_storearea_storearea depot1-2-3 depot1-1-3)
  (connected_storearea_storearea depot1-2-3 depot1-2-4)
  (connected_storearea_storearea depot1-2-3 depot1-2-2)
  (connected_storearea_storearea depot1-2-4 depot1-1-4)
  (connected_storearea_storearea depot1-2-4 depot1-2-3)
  (connected_storearea_storearea depot2-1-1 depot2-2-1)
  (connected_storearea_storearea depot2-1-1 depot2-1-2)
  (connected_storearea_storearea depot2-1-2 depot2-2-2)
  (connected_storearea_storearea depot2-1-2 depot2-1-3)
  (connected_storearea_storearea depot2-1-2 depot2-1-1)
  (connected_storearea_storearea depot2-1-3 depot2-2-3)
  (connected_storearea_storearea depot2-1-3 depot2-1-4)
  (connected_storearea_storearea depot2-1-3 depot2-1-2)
  (connected_storearea_storearea depot2-1-4 depot2-2-4)
  (connected_storearea_storearea depot2-1-4 depot2-1-3)
  (connected_storearea_storearea depot2-2-1 depot2-1-1)
  (connected_storearea_storearea depot2-2-1 depot2-2-2)
  (connected_storearea_storearea depot2-2-2 depot2-1-2)
  (connected_storearea_storearea depot2-2-2 depot2-2-3)
  (connected_storearea_storearea depot2-2-2 depot2-2-1)
  (connected_storearea_storearea depot2-2-3 depot2-1-3)
  (connected_storearea_storearea depot2-2-3 depot2-2-4)
  (connected_storearea_storearea depot2-2-3 depot2-2-2)
  (connected_storearea_storearea depot2-2-4 depot2-1-4)
  (connected_storearea_storearea depot2-2-4 depot2-2-3)
  (connected_storearea_storearea depot3-1-1 depot3-2-1)
  (connected_storearea_storearea depot3-1-1 depot3-1-2)
  (connected_storearea_storearea depot3-1-2 depot3-2-2)
  (connected_storearea_storearea depot3-1-2 depot3-1-3)
  (connected_storearea_storearea depot3-1-2 depot3-1-1)
  (connected_storearea_storearea depot3-1-3 depot3-2-3)
  (connected_storearea_storearea depot3-1-3 depot3-1-4)
  (connected_storearea_storearea depot3-1-3 depot3-1-2)
  (connected_storearea_storearea depot3-1-4 depot3-2-4)
  (connected_storearea_storearea depot3-1-4 depot3-1-3)
  (connected_storearea_storearea depot3-2-1 depot3-1-1)
  (connected_storearea_storearea depot3-2-1 depot3-2-2)
  (connected_storearea_storearea depot3-2-2 depot3-1-2)
  (connected_storearea_storearea depot3-2-2 depot3-2-3)
  (connected_storearea_storearea depot3-2-2 depot3-2-1)
  (connected_storearea_storearea depot3-2-3 depot3-1-3)
  (connected_storearea_storearea depot3-2-3 depot3-2-4)
  (connected_storearea_storearea depot3-2-3 depot3-2-2)
  (connected_storearea_storearea depot3-2-4 depot3-1-4)
  (connected_storearea_storearea depot3-2-4 depot3-2-3)
  (connected_transitarea_storearea transit0 depot0-1-4)
  (connected_transitarea_storearea transit0 depot1-1-1)
  (in_storearea_depot depot0-1-1 depot0)
  (in_storearea_depot depot0-1-2 depot0)
  (in_storearea_depot depot0-1-3 depot0)
  (in_storearea_depot depot0-1-4 depot0)
  (in_storearea_depot depot0-2-1 depot0)
  (in_storearea_depot depot0-2-2 depot0)
  (in_storearea_depot depot0-2-3 depot0)
  (in_storearea_depot depot0-2-4 depot0)
  (in_storearea_depot depot1-1-1 depot1)
  (in_storearea_depot depot1-1-2 depot1)
  (in_storearea_depot depot1-1-3 depot1)
  (in_storearea_depot depot1-1-4 depot1)
  (in_storearea_depot depot1-2-1 depot1)
  (in_storearea_depot depot1-2-2 depot1)
  (in_storearea_depot depot1-2-3 depot1)
  (in_storearea_depot depot1-2-4 depot1)
  (in_storearea_depot depot2-1-1 depot2)
  (in_storearea_depot depot2-1-2 depot2)
  (in_storearea_depot depot2-1-3 depot2)
  (in_storearea_depot depot2-1-4 depot2)
  (in_storearea_depot depot2-2-1 depot2)
  (in_storearea_depot depot2-2-2 depot2)
  (in_storearea_depot depot2-2-3 depot2)
  (in_storearea_depot depot2-2-4 depot2)
  (in_storearea_depot depot3-1-1 depot3)
  (in_storearea_depot depot3-1-2 depot3)
  (in_storearea_depot depot3-1-3 depot3)
  (in_storearea_depot depot3-1-4 depot3)
  (in_storearea_depot depot3-2-1 depot3)
  (in_storearea_depot depot3-2-2 depot3)
  (in_storearea_depot depot3-2-3 depot3)
  (in_storearea_depot depot3-2-4 depot3)
  (on crate0 container-0-0)
  (on crate1 container-0-1)
  (on crate2 container-0-2)
  (on crate3 container-0-3)
  (on crate4 container-1-0)
  (on crate5 container-1-1)
  (on crate6 container-1-2)
  (on crate7 container-1-3)
  (on crate8 container-2-0)
  (on crate9 container-2-1)
  (on crate10 container-2-2)
  (on crate11 container-2-3)
  (on crate12 container-3-0)
  (on crate13 container-3-1)
  (on crate14 container-3-2)
  (on crate15 container-3-3)
  (in_crate_container crate0 container0)
  (in_crate_container crate1 container0)
  (in_crate_container crate2 container0)
  (in_crate_container crate3 container0)
  (in_crate_container crate4 container1)
  (in_crate_container crate5 container1)
  (in_crate_container crate6 container1)
  (in_crate_container crate7 container1)
  (in_crate_container crate8 container2)
  (in_crate_container crate9 container2)
  (in_crate_container crate10 container2)
  (in_crate_container crate11 container2)
  (in_crate_container crate12 container3)
  (in_crate_container crate13 container3)
  (in_crate_container crate14 container3)
  (in_crate_container crate15 container3)
  (in_storearea_container container-0-0 container0)
  (in_storearea_container container-0-1 container0)
  (in_storearea_container container-0-2 container0)
  (in_storearea_container container-0-3 container0)
  (in_storearea_container container-1-0 container1)
  (in_storearea_container container-1-1 container1)
  (in_storearea_container container-1-2 container1)
  (in_storearea_container container-1-3 container1)
  (in_storearea_container container-2-0 container2)
  (in_storearea_container container-2-1 container2)
  (in_storearea_container container-2-2 container2)
  (in_storearea_container container-2-3 container2)
  (in_storearea_container container-3-0 container3)
  (in_storearea_container container-3-1 container3)
  (in_storearea_container container-3-2 container3)
  (in_storearea_container container-3-3 container3)
  (connected_transitarea_storearea loadarea container-0-0)
  (connected_storearea_transitarea container-0-0 loadarea)
  (connected_transitarea_storearea loadarea container-0-1)
  (connected_storearea_transitarea container-0-1 loadarea)
  (connected_transitarea_storearea loadarea container-0-2)
  (connected_storearea_transitarea container-0-2 loadarea)
  (connected_transitarea_storearea loadarea container-0-3)
  (connected_storearea_transitarea container-0-3 loadarea)
  (connected_transitarea_storearea loadarea container-1-0)
  (connected_storearea_transitarea container-1-0 loadarea)
  (connected_transitarea_storearea loadarea container-1-1)
  (connected_storearea_transitarea container-1-1 loadarea)
  (connected_transitarea_storearea loadarea container-1-2)
  (connected_storearea_transitarea container-1-2 loadarea)
  (connected_transitarea_storearea loadarea container-1-3)
  (connected_storearea_transitarea container-1-3 loadarea)
  (connected_transitarea_storearea loadarea container-2-0)
  (connected_storearea_transitarea container-2-0 loadarea)
  (connected_transitarea_storearea loadarea container-2-1)
  (connected_storearea_transitarea container-2-1 loadarea)
  (connected_transitarea_storearea loadarea container-2-2)
  (connected_storearea_transitarea container-2-2 loadarea)
  (connected_transitarea_storearea loadarea container-2-3)
  (connected_storearea_transitarea container-2-3 loadarea)
  (connected_transitarea_storearea loadarea container-3-0)
  (connected_storearea_transitarea container-3-0 loadarea)
  (connected_transitarea_storearea loadarea container-3-1)
  (connected_storearea_transitarea container-3-1 loadarea)
  (connected_transitarea_storearea loadarea container-3-2)
  (connected_storearea_transitarea container-3-2 loadarea)
  (connected_transitarea_storearea loadarea container-3-3)
  (connected_storearea_transitarea container-3-3 loadarea)
  (connected_storearea_transitarea depot0-2-2 loadarea)
  (connected_transitarea_storearea loadarea depot0-2-2)
  (connected_storearea_transitarea depot1-2-4 loadarea)
  (connected_transitarea_storearea loadarea depot1-2-4)
  (connected_storearea_transitarea depot2-2-2 loadarea)
  (connected_transitarea_storearea loadarea depot2-2-2)
  (connected_storearea_transitarea depot3-2-1 loadarea)
  (connected_transitarea_storearea loadarea depot3-2-1)
  (clear depot0-1-1)
  (clear depot0-1-2)
  (clear depot0-1-3)
  (clear depot0-1-4)
  (clear depot0-2-1)
  (clear depot0-2-4)
  (clear depot1-1-1)
  (clear depot1-1-2)
  (clear depot1-1-3)
  (clear depot1-2-4)
  (clear depot1-2-1)
  (clear depot1-2-2)
  (clear depot1-2-3)
  (clear depot2-1-1)
  (clear depot2-1-2)
  (clear depot2-1-3)
  (clear depot2-1-4)
  (clear depot2-2-1)
  (clear depot2-2-3)
  (clear depot3-1-1)
  (clear depot3-1-2)
  (clear depot3-1-3)
  (clear depot3-1-4)
  (clear depot3-2-1)
  (clear depot3-2-2)
  (clear depot3-2-3)
  (clear depot3-2-4)
  (at_storearea hoist0 depot0-2-3)
  (available hoist0)
  (at_storearea hoist1 depot0-2-2)
  (available hoist1)
  (at_storearea hoist2 depot1-1-4)
  (available hoist2)
  (at_storearea hoist3 depot2-2-4)
  (available hoist3)
  (at_storearea hoist4 depot2-2-2)
  (available hoist4)
)
(:goal   (and (in_crate_depot crate0 depot0)
  (in_crate_depot crate1 depot0)
  (in_crate_depot crate2 depot0)
  (in_crate_depot crate3 depot0)
  (in_crate_depot crate4 depot1)
  (in_crate_depot crate5 depot1)
  (in_crate_depot crate6 depot1)
  (in_crate_depot crate7 depot1)
  (in_crate_depot crate8 depot2)
  (in_crate_depot crate9 depot2)
  (in_crate_depot crate10 depot2)
  (in_crate_depot crate11 depot2)
  (in_crate_depot crate12 depot3)
  (in_crate_depot crate13 depot3)
  (in_crate_depot crate14 depot3)
  (in_crate_depot crate15 depot3)))
)
