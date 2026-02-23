(define (problem depotprob22)
(:domain depots)
(:requirements)
(:objects 
  depot0 - DEPOT
  depot1 - DEPOT
  depot2 - DEPOT
  depot3 - DEPOT
  depot4 - DEPOT
  depot5 - DEPOT
  depot6 - DEPOT
  distributor0 - DISTRIBUTOR
  distributor1 - DISTRIBUTOR
  distributor2 - DISTRIBUTOR
  distributor3 - DISTRIBUTOR
  distributor4 - DISTRIBUTOR
  distributor5 - DISTRIBUTOR
  distributor6 - DISTRIBUTOR
  truck0 - TRUCK
  truck1 - TRUCK
  truck2 - TRUCK
  truck3 - TRUCK
  truck4 - TRUCK
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
  pallet12 - PALLET
  pallet13 - PALLET
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
  crate20 - CRATE
  crate21 - CRATE
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
  hoist12 - HOIST
  hoist13 - HOIST
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_pallet pallet0)
  (at_pallet_depot pallet1 depot1)
  (clear_crate crate12)
  (at_pallet_depot pallet2 depot2)
  (clear_crate crate3)
  (at_pallet_depot pallet3 depot3)
  (clear_crate crate20)
  (at_pallet_depot pallet4 depot4)
  (clear_crate crate4)
  (at_pallet_depot pallet5 depot5)
  (clear_crate crate19)
  (at_pallet_depot pallet6 depot6)
  (clear_pallet pallet6)
  (at_pallet_distributor pallet7 distributor0)
  (clear_pallet pallet7)
  (at_pallet_distributor pallet8 distributor1)
  (clear_crate crate10)
  (at_pallet_distributor pallet9 distributor2)
  (clear_crate crate7)
  (at_pallet_distributor pallet10 distributor3)
  (clear_crate crate18)
  (at_pallet_distributor pallet11 distributor4)
  (clear_pallet pallet11)
  (at_pallet_distributor pallet12 distributor5)
  (clear_crate crate11)
  (at_pallet_distributor pallet13 distributor6)
  (clear_crate crate21)
  (at_truck_depot truck0 depot0)
  (at_truck_distributor truck1 distributor6)
  (at_truck_distributor truck2 distributor3)
  (at_truck_depot truck3 depot5)
  (at_truck_distributor truck4 distributor3)
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
  (at_hoist_depot hoist6 depot6)
  (available hoist6)
  (at_hoist_distributor hoist7 distributor0)
  (available hoist7)
  (at_hoist_distributor hoist8 distributor1)
  (available hoist8)
  (at_hoist_distributor hoist9 distributor2)
  (available hoist9)
  (at_hoist_distributor hoist10 distributor3)
  (available hoist10)
  (at_hoist_distributor hoist11 distributor4)
  (available hoist11)
  (at_hoist_distributor hoist12 distributor5)
  (available hoist12)
  (at_hoist_distributor hoist13 distributor6)
  (available hoist13)
  (at_crate_depot crate0 depot2)
  (on_pallet crate0 pallet2)
  (at_crate_depot crate1 depot4)
  (on_pallet crate1 pallet4)
  (at_crate_distributor crate2 distributor6)
  (on_pallet crate2 pallet13)
  (at_crate_depot crate3 depot2)
  (on_crate crate3 crate0)
  (at_crate_depot crate4 depot4)
  (on_crate crate4 crate1)
  (at_crate_distributor crate5 distributor3)
  (on_pallet crate5 pallet10)
  (at_crate_distributor crate6 distributor1)
  (on_pallet crate6 pallet8)
  (at_crate_distributor crate7 distributor2)
  (on_pallet crate7 pallet9)
  (at_crate_distributor crate8 distributor5)
  (on_pallet crate8 pallet12)
  (at_crate_distributor crate9 distributor3)
  (on_crate crate9 crate5)
  (at_crate_distributor crate10 distributor1)
  (on_crate crate10 crate6)
  (at_crate_distributor crate11 distributor5)
  (on_crate crate11 crate8)
  (at_crate_depot crate12 depot1)
  (on_pallet crate12 pallet1)
  (at_crate_depot crate13 depot5)
  (on_pallet crate13 pallet5)
  (at_crate_depot crate14 depot5)
  (on_crate crate14 crate13)
  (at_crate_distributor crate15 distributor6)
  (on_crate crate15 crate2)
  (at_crate_depot crate16 depot5)
  (on_crate crate16 crate14)
  (at_crate_distributor crate17 distributor6)
  (on_crate crate17 crate15)
  (at_crate_distributor crate18 distributor3)
  (on_crate crate18 crate9)
  (at_crate_depot crate19 depot5)
  (on_crate crate19 crate16)
  (at_crate_depot crate20 depot3)
  (on_pallet crate20 pallet3)
  (at_crate_distributor crate21 distributor6)
  (on_crate crate21 crate17)
)
(:goal   (and (on_pallet crate0 pallet13)
  (on_pallet crate1 pallet6)
  (on_crate crate2 crate7)
  (on_crate crate3 crate10)
  (on_crate crate4 crate13)
  (on_pallet crate5 pallet12)
  (on_pallet crate6 pallet4)
  (on_crate crate7 crate3)
  (on_crate crate8 crate12)
  (on_pallet crate10 pallet5)
  (on_pallet crate11 pallet8)
  (on_pallet crate12 pallet2)
  (on_pallet crate13 pallet3)
  (on_crate crate15 crate19)
  (on_crate crate16 crate21)
  (on_crate crate17 crate0)
  (on_crate crate18 crate20)
  (on_pallet crate19 pallet1)
  (on_crate crate20 crate15)
  (on_pallet crate21 pallet9)))
)
