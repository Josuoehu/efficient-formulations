(define (problem storage-3)
(:domain storage-propositional)
(:objects 
  depot0-1-1 - STOREAREA
  depot0-1-2 - STOREAREA
  depot0-1-3 - STOREAREA
  container-0-0 - STOREAREA
  hoist0 - HOIST
  hoist1 - HOIST
  hoist2 - HOIST
  crate0 - CRATE
  container0 - CONTAINER
  depot0 - DEPOT
  loadarea - TRANSITAREA
)
(:init
  (connected_storearea_storearea depot0-1-1 depot0-1-2)
  (connected_storearea_storearea depot0-1-2 depot0-1-3)
  (connected_storearea_storearea depot0-1-2 depot0-1-1)
  (connected_storearea_storearea depot0-1-3 depot0-1-2)
  (in_storearea_depot depot0-1-1 depot0)
  (in_storearea_depot depot0-1-2 depot0)
  (in_storearea_depot depot0-1-3 depot0)
  (on crate0 container-0-0)
  (in_crate_container crate0 container0)
  (in_storearea_container container-0-0 container0)
  (connected_transitarea_storearea loadarea container-0-0)
  (connected_storearea_transitarea container-0-0 loadarea)
  (connected_storearea_transitarea depot0-1-2 loadarea)
  (connected_transitarea_storearea loadarea depot0-1-2)
  (at_storearea hoist0 depot0-1-2)
  (available hoist0)
  (at_storearea hoist1 depot0-1-3)
  (available hoist1)
  (at_storearea hoist2 depot0-1-1)
  (available hoist2)
)
(:goal   (and (in_crate_depot crate0 depot0)))
)
