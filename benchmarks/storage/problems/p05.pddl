(define (problem storage-5)
(:domain storage-propositional)
(:objects 
  depot0-1-1 - STOREAREA
  depot0-1-2 - STOREAREA
  depot0-2-1 - STOREAREA
  depot0-2-2 - STOREAREA
  container-0-0 - STOREAREA
  container-0-1 - STOREAREA
  hoist0 - HOIST
  hoist1 - HOIST
  crate0 - CRATE
  crate1 - CRATE
  container0 - CONTAINER
  depot0 - DEPOT
  loadarea - TRANSITAREA
)
(:init
  (connected_storearea_storearea depot0-1-1 depot0-2-1)
  (connected_storearea_storearea depot0-1-1 depot0-1-2)
  (connected_storearea_storearea depot0-1-2 depot0-2-2)
  (connected_storearea_storearea depot0-1-2 depot0-1-1)
  (connected_storearea_storearea depot0-2-1 depot0-1-1)
  (connected_storearea_storearea depot0-2-1 depot0-2-2)
  (connected_storearea_storearea depot0-2-2 depot0-1-2)
  (connected_storearea_storearea depot0-2-2 depot0-2-1)
  (in_storearea_depot depot0-1-1 depot0)
  (in_storearea_depot depot0-1-2 depot0)
  (in_storearea_depot depot0-2-1 depot0)
  (in_storearea_depot depot0-2-2 depot0)
  (on crate0 container-0-0)
  (on crate1 container-0-1)
  (in_crate_container crate0 container0)
  (in_crate_container crate1 container0)
  (in_storearea_container container-0-0 container0)
  (in_storearea_container container-0-1 container0)
  (connected_transitarea_storearea loadarea container-0-0)
  (connected_storearea_transitarea container-0-0 loadarea)
  (connected_transitarea_storearea loadarea container-0-1)
  (connected_storearea_transitarea container-0-1 loadarea)
  (connected_storearea_transitarea depot0-2-1 loadarea)
  (connected_transitarea_storearea loadarea depot0-2-1)
  (clear depot0-2-2)
  (clear depot0-2-1)
  (at_storearea hoist0 depot0-1-1)
  (available hoist0)
  (at_storearea hoist1 depot0-1-2)
  (available hoist1)
)
(:goal   (and (in_crate_depot crate0 depot0)
  (in_crate_depot crate1 depot0)))
)
