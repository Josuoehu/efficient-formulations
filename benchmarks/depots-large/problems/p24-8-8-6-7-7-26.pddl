(define (problem depotprob24)
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
  depot7 - DEPOT
  distributor0 - DISTRIBUTOR
  distributor1 - DISTRIBUTOR
  distributor2 - DISTRIBUTOR
  distributor3 - DISTRIBUTOR
  distributor4 - DISTRIBUTOR
  distributor5 - DISTRIBUTOR
  distributor6 - DISTRIBUTOR
  distributor7 - DISTRIBUTOR
  truck0 - TRUCK
  truck1 - TRUCK
  truck2 - TRUCK
  truck3 - TRUCK
  truck4 - TRUCK
  truck5 - TRUCK
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
  pallet14 - PALLET
  pallet15 - PALLET
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
  crate22 - CRATE
  crate23 - CRATE
  crate24 - CRATE
  crate25 - CRATE
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
  hoist14 - HOIST
  hoist15 - HOIST
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_crate crate8)
  (at_pallet_depot pallet1 depot1)
  (clear_crate crate4)
  (at_pallet_depot pallet2 depot2)
  (clear_crate crate19)
  (at_pallet_depot pallet3 depot3)
  (clear_crate crate20)
  (at_pallet_depot pallet4 depot4)
  (clear_crate crate9)
  (at_pallet_depot pallet5 depot5)
  (clear_crate crate11)
  (at_pallet_depot pallet6 depot6)
  (clear_pallet pallet6)
  (at_pallet_depot pallet7 depot7)
  (clear_crate crate10)
  (at_pallet_distributor pallet8 distributor0)
  (clear_pallet pallet8)
  (at_pallet_distributor pallet9 distributor1)
  (clear_crate crate1)
  (at_pallet_distributor pallet10 distributor2)
  (clear_crate crate25)
  (at_pallet_distributor pallet11 distributor3)
  (clear_crate crate24)
  (at_pallet_distributor pallet12 distributor4)
  (clear_crate crate23)
  (at_pallet_distributor pallet13 distributor5)
  (clear_crate crate22)
  (at_pallet_distributor pallet14 distributor6)
  (clear_crate crate21)
  (at_pallet_distributor pallet15 distributor7)
  (clear_crate crate3)
  (at_truck_depot truck0 depot3)
  (at_truck_distributor truck1 distributor2)
  (at_truck_distributor truck2 distributor4)
  (at_truck_depot truck3 depot3)
  (at_truck_distributor truck4 distributor2)
  (at_truck_distributor truck5 distributor4)
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
  (at_hoist_depot hoist7 depot7)
  (available hoist7)
  (at_hoist_distributor hoist8 distributor0)
  (available hoist8)
  (at_hoist_distributor hoist9 distributor1)
  (available hoist9)
  (at_hoist_distributor hoist10 distributor2)
  (available hoist10)
  (at_hoist_distributor hoist11 distributor3)
  (available hoist11)
  (at_hoist_distributor hoist12 distributor4)
  (available hoist12)
  (at_hoist_distributor hoist13 distributor5)
  (available hoist13)
  (at_hoist_distributor hoist14 distributor6)
  (available hoist14)
  (at_hoist_distributor hoist15 distributor7)
  (available hoist15)
  (at_crate_depot crate0 depot2)
  (on_pallet crate0 pallet2)
  (at_crate_distributor crate1 distributor1)
  (on_pallet crate1 pallet9)
  (at_crate_depot crate2 depot5)
  (on_pallet crate2 pallet5)
  (at_crate_distributor crate3 distributor7)
  (on_pallet crate3 pallet15)
  (at_crate_depot crate4 depot1)
  (on_pallet crate4 pallet1)
  (at_crate_depot crate5 depot3)
  (on_pallet crate5 pallet3)
  (at_crate_depot crate6 depot5)
  (on_crate crate6 crate2)
  (at_crate_distributor crate7 distributor4)
  (on_pallet crate7 pallet12)
  (at_crate_depot crate8 depot0)
  (on_pallet crate8 pallet0)
  (at_crate_depot crate9 depot4)
  (on_pallet crate9 pallet4)
  (at_crate_depot crate10 depot7)
  (on_pallet crate10 pallet7)
  (at_crate_depot crate11 depot5)
  (on_crate crate11 crate6)
  (at_crate_depot crate12 depot2)
  (on_crate crate12 crate0)
  (at_crate_distributor crate13 distributor4)
  (on_crate crate13 crate7)
  (at_crate_distributor crate14 distributor3)
  (on_pallet crate14 pallet11)
  (at_crate_distributor crate15 distributor6)
  (on_pallet crate15 pallet14)
  (at_crate_distributor crate16 distributor6)
  (on_crate crate16 crate15)
  (at_crate_depot crate17 depot3)
  (on_crate crate17 crate5)
  (at_crate_distributor crate18 distributor5)
  (on_pallet crate18 pallet13)
  (at_crate_depot crate19 depot2)
  (on_crate crate19 crate12)
  (at_crate_depot crate20 depot3)
  (on_crate crate20 crate17)
  (at_crate_distributor crate21 distributor6)
  (on_crate crate21 crate16)
  (at_crate_distributor crate22 distributor5)
  (on_crate crate22 crate18)
  (at_crate_distributor crate23 distributor4)
  (on_crate crate23 crate13)
  (at_crate_distributor crate24 distributor3)
  (on_crate crate24 crate14)
  (at_crate_distributor crate25 distributor2)
  (on_pallet crate25 pallet10)
)
(:goal   (and (on_crate crate0 crate22)
  (on_crate crate2 crate18)
  (on_crate crate3 crate4)
  (on_pallet crate4 pallet11)
  (on_pallet crate5 pallet7)
  (on_pallet crate6 pallet4)
  (on_pallet crate7 pallet6)
  (on_crate crate8 crate0)
  (on_crate crate9 crate7)
  (on_pallet crate10 pallet3)
  (on_pallet crate11 pallet13)
  (on_pallet crate14 pallet9)
  (on_crate crate15 crate9)
  (on_pallet crate16 pallet10)
  (on_crate crate17 crate19)
  (on_pallet crate18 pallet5)
  (on_crate crate19 crate5)
  (on_crate crate20 crate23)
  (on_pallet crate21 pallet0)
  (on_crate crate22 crate21)
  (on_pallet crate23 pallet15)
  (on_pallet crate24 pallet2)
  (on_crate crate25 crate14)))
)
