(define (problem depotprob21)
(:domain depots)
(:requirements)
(:objects 
  depot0 - DEPOT
  depot1 - DEPOT
  depot2 - DEPOT
  depot3 - DEPOT
  depot4 - DEPOT
  depot5 - DEPOT
  distributor0 - DISTRIBUTOR
  distributor1 - DISTRIBUTOR
  distributor2 - DISTRIBUTOR
  distributor3 - DISTRIBUTOR
  distributor4 - DISTRIBUTOR
  distributor5 - DISTRIBUTOR
  truck0 - TRUCK
  truck1 - TRUCK
  truck2 - TRUCK
  truck3 - TRUCK
  pallet0 - PALLET
  pallet1 - PALLET
  pallet2 - PALLET
  pallet3 - PALLET
  pallet4 - PALLET
  pallet5 - PALLET
  pallet6 - PALLET
  pallet7 - PALLET
  pallet8 - PALLET
  pallet9 - PALLET
  pallet10 - PALLET
  pallet11 - PALLET
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
  crate16 - CRATE
  crate17 - CRATE
  crate18 - CRATE
  crate19 - CRATE
  hoist0 - HOIST
  hoist1 - HOIST
  hoist2 - HOIST
  hoist3 - HOIST
  hoist4 - HOIST
  hoist5 - HOIST
  hoist6 - HOIST
  hoist7 - HOIST
  hoist8 - HOIST
  hoist9 - HOIST
  hoist10 - HOIST
  hoist11 - HOIST
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_crate crate9)
  (at_pallet_depot pallet1 depot1)
  (clear_crate crate18)
  (at_pallet_depot pallet2 depot2)
  (clear_crate crate5)
  (at_pallet_depot pallet3 depot3)
  (clear_crate crate14)
  (at_pallet_depot pallet4 depot4)
  (clear_crate crate17)
  (at_pallet_depot pallet5 depot5)
  (clear_crate crate10)
  (at_pallet_distributor pallet6 distributor0)
  (clear_pallet pallet6)
  (at_pallet_distributor pallet7 distributor1)
  (clear_pallet pallet7)
  (at_pallet_distributor pallet8 distributor2)
  (clear_crate crate13)
  (at_pallet_distributor pallet9 distributor3)
  (clear_crate crate16)
  (at_pallet_distributor pallet10 distributor4)
  (clear_crate crate19)
  (at_pallet_distributor pallet11 distributor5)
  (clear_crate crate2)
  (at_truck_depot truck0 depot0)
  (at_truck_depot truck1 depot4)
  (at_truck_depot truck2 depot2)
  (at_truck_distributor truck3 distributor2)
  (at_hoist_depot hoist0 depot0)
  (available hoist0)
  (at_hoist_depot hoist1 depot1)
  (available hoist1)
  (at_hoist_depot hoist2 depot2)
  (available hoist2)
  (at_hoist_depot hoist3 depot3)
  (available hoist3)
  (at_hoist_depot hoist4 depot4)
  (available hoist4)
  (at_hoist_depot hoist5 depot5)
  (available hoist5)
  (at_hoist_distributor hoist6 distributor0)
  (available hoist6)
  (at_hoist_distributor hoist7 distributor1)
  (available hoist7)
  (at_hoist_distributor hoist8 distributor2)
  (available hoist8)
  (at_hoist_distributor hoist9 distributor3)
  (available hoist9)
  (at_hoist_distributor hoist10 distributor4)
  (available hoist10)
  (at_hoist_distributor hoist11 distributor5)
  (available hoist11)
  (at_crate_depot crate0 depot3)
  (on_pallet crate0 pallet3)
  (at_crate_depot crate1 depot2)
  (on_pallet crate1 pallet2)
  (at_crate_distributor crate2 distributor5)
  (on_pallet crate2 pallet11)
  (at_crate_distributor crate3 distributor2)
  (on_pallet crate3 pallet8)
  (at_crate_depot crate4 depot5)
  (on_pallet crate4 pallet5)
  (at_crate_depot crate5 depot2)
  (on_crate crate5 crate1)
  (at_crate_depot crate6 depot0)
  (on_pallet crate6 pallet0)
  (at_crate_depot crate7 depot1)
  (on_pallet crate7 pallet1)
  (at_crate_distributor crate8 distributor3)
  (on_pallet crate8 pallet9)
  (at_crate_depot crate9 depot0)
  (on_crate crate9 crate6)
  (at_crate_depot crate10 depot5)
  (on_crate crate10 crate4)
  (at_crate_distributor crate11 distributor4)
  (on_pallet crate11 pallet10)
  (at_crate_distributor crate12 distributor4)
  (on_crate crate12 crate11)
  (at_crate_distributor crate13 distributor2)
  (on_crate crate13 crate3)
  (at_crate_depot crate14 depot3)
  (on_crate crate14 crate0)
  (at_crate_distributor crate15 distributor4)
  (on_crate crate15 crate12)
  (at_crate_distributor crate16 distributor3)
  (on_crate crate16 crate8)
  (at_crate_depot crate17 depot4)
  (on_pallet crate17 pallet4)
  (at_crate_depot crate18 depot1)
  (on_crate crate18 crate7)
  (at_crate_distributor crate19 distributor4)
  (on_crate crate19 crate15)
)
(:goal   (and (on_crate crate0 crate19)
  (on_pallet crate1 pallet3)
  (on_crate crate2 crate5)
  (on_pallet crate3 pallet10)
  (on_pallet crate4 pallet11)
  (on_crate crate5 crate11)
  (on_crate crate6 crate14)
  (on_pallet crate7 pallet4)
  (on_pallet crate8 pallet7)
  (on_pallet crate9 pallet2)
  (on_crate crate10 crate3)
  (on_pallet crate11 pallet0)
  (on_crate crate12 crate10)
  (on_crate crate13 crate1)
  (on_crate crate14 crate7)
  (on_crate crate15 crate0)
  (on_pallet crate16 pallet1)
  (on_pallet crate17 pallet8)
  (on_crate crate19 crate8)))
)
