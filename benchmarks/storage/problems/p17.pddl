(define (problem storage-17)
(:domain storage-propositional)
(:objects 
  depot0-1-1 - STOREAREA
  depot0-1-2 - STOREAREA
  depot0-1-3 - STOREAREA
  depot0-1-4 - STOREAREA
  depot0-2-1 - STOREAREA
  depot0-2-2 - STOREAREA
  depot0-2-3 - STOREAREA
  depot1-1-1 - STOREAREA
  depot1-1-2 - STOREAREA
  depot1-1-3 - STOREAREA
  depot1-1-4 - STOREAREA
  depot1-2-1 - STOREAREA
  depot1-2-2 - STOREAREA
  depot1-2-3 - STOREAREA
  container-0-0 - STOREAREA
  container-0-1 - STOREAREA
  container-0-2 - STOREAREA
  container-0-3 - STOREAREA
  container-1-0 - STOREAREA
  container-1-1 - STOREAREA
  container-1-2 - STOREAREA
  hoist0 - HOIST
  hoist1 - HOIST
  hoist2 - HOIST
  crate0 - CRATE
  crate1 - CRATE
  crate2 - CRATE
  crate3 - CRATE
  crate4 - CRATE
  crate5 - CRATE
  crate6 - CRATE
  container0 - CONTAINER
  container1 - CONTAINER
  depot0 - DEPOT
  depot1 - DEPOT
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
  (connected_storearea_storearea depot0-1-4 depot0-1-3)
  (connected_storearea_storearea depot0-2-1 depot0-1-1)
  (connected_storearea_storearea depot0-2-1 depot0-2-2)
  (connected_storearea_storearea depot0-2-2 depot0-1-2)
  (connected_storearea_storearea depot0-2-2 depot0-2-3)
  (connected_storearea_storearea depot0-2-2 depot0-2-1)
  (connected_storearea_storearea depot0-2-3 depot0-1-3)
  (connected_storearea_storearea depot0-2-3 depot0-2-2)
  (connected_storearea_storearea depot1-1-1 depot1-2-1)
  (connected_storearea_storearea depot1-1-1 depot1-1-2)
  (connected_storearea_storearea depot1-1-2 depot1-2-2)
  (connected_storearea_storearea depot1-1-2 depot1-1-3)
  (connected_storearea_storearea depot1-1-2 depot1-1-1)
  (connected_storearea_storearea depot1-1-3 depot1-2-3)
  (connected_storearea_storearea depot1-1-3 depot1-1-4)
  (connected_storearea_storearea depot1-1-3 depot1-1-2)
  (connected_storearea_storearea depot1-1-4 depot1-1-3)
  (connected_storearea_storearea depot1-2-1 depot1-1-1)
  (connected_storearea_storearea depot1-2-1 depot1-2-2)
  (connected_storearea_storearea depot1-2-2 depot1-1-2)
  (connected_storearea_storearea depot1-2-2 depot1-2-3)
  (connected_storearea_storearea depot1-2-2 depot1-2-1)
  (connected_storearea_storearea depot1-2-3 depot1-1-3)
  (connected_storearea_storearea depot1-2-3 depot1-2-2)
  (connected_transitarea_storearea transit0 depot0-1-4)
  (connected_transitarea_storearea transit0 depot1-1-1)
  (in_storearea_depot depot0-1-1 depot0)
  (in_storearea_depot depot0-1-2 depot0)
  (in_storearea_depot depot0-1-3 depot0)
  (in_storearea_depot depot0-1-4 depot0)
  (in_storearea_depot depot0-2-1 depot0)
  (in_storearea_depot depot0-2-2 depot0)
  (in_storearea_depot depot0-2-3 depot0)
  (in_storearea_depot depot1-1-1 depot1)
  (in_storearea_depot depot1-1-2 depot1)
  (in_storearea_depot depot1-1-3 depot1)
  (in_storearea_depot depot1-1-4 depot1)
  (in_storearea_depot depot1-2-1 depot1)
  (in_storearea_depot depot1-2-2 depot1)
  (in_storearea_depot depot1-2-3 depot1)
  (on crate0 container-0-0)
  (on crate1 container-0-1)
  (on crate2 container-0-2)
  (on crate3 container-0-3)
  (on crate4 container-1-0)
  (on crate5 container-1-1)
  (on crate6 container-1-2)
  (in_crate_container crate0 container0)
  (in_crate_container crate1 container0)
  (in_crate_container crate2 container0)
  (in_crate_container crate3 container0)
  (in_crate_container crate4 container1)
  (in_crate_container crate5 container1)
  (in_crate_container crate6 container1)
  (in_storearea_container container-0-0 container0)
  (in_storearea_container container-0-1 container0)
  (in_storearea_container container-0-2 container0)
  (in_storearea_container container-0-3 container0)
  (in_storearea_container container-1-0 container1)
  (in_storearea_container container-1-1 container1)
  (in_storearea_container container-1-2 container1)
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
  (connected_storearea_transitarea depot0-2-2 loadarea)
  (connected_transitarea_storearea loadarea depot0-2-2)
  (connected_storearea_transitarea depot1-2-3 loadarea)
  (connected_transitarea_storearea loadarea depot1-2-3)
  (clear depot0-2-3)
  (clear depot0-1-2)
  (clear depot0-1-3)
  (clear depot0-1-4)
  (clear depot0-2-1)
  (clear depot0-2-2)
  (clear depot1-1-1)
  (clear depot1-1-2)
  (clear depot1-1-3)
  (clear depot1-1-4)
  (clear depot1-2-2)
  (at_storearea hoist0 depot0-1-1)
  (available hoist0)
  (at_storearea hoist1 depot1-2-1)
  (available hoist1)
  (at_storearea hoist2 depot1-2-3)
  (available hoist2)
)
(:goal   (and (in_crate_depot crate0 depot0)
  (in_crate_depot crate1 depot0)
  (in_crate_depot crate2 depot0)
  (in_crate_depot crate3 depot1)
  (in_crate_depot crate4 depot1)
  (in_crate_depot crate5 depot1)
  (in_crate_depot crate6 depot1)))
)
