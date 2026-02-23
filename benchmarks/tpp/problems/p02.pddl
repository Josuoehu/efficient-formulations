(define (problem tpp)
(:domain tpp-propositional)
(:objects 
  goods1 - GOODS
  goods2 - GOODS
  truck1 - TRUCK
  market1 - MARKET
  depot1 - DEPOT
  level0 - LEVEL
  level1 - LEVEL
)
(:init
  (next level1 level0)
  (ready-to-load goods1 market1 level0)
  (ready-to-load goods2 market1 level0)
  (stored goods1 level0)
  (stored goods2 level0)
  (loaded goods1 truck1 level0)
  (loaded goods2 truck1 level0)
  (connected_depot_market depot1 market1)
  (connected_market_depot market1 depot1)
  (on-sale goods1 market1 level1)
  (on-sale goods2 market1 level1)
  (at_depot truck1 depot1)
)
(:goal   (and (stored goods1 level1)
  (stored goods2 level1)))
)
