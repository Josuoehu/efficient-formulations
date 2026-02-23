(define (problem depotprob25)
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
  depot8 - DEPOT
  distributor0 - DISTRIBUTOR
  distributor1 - DISTRIBUTOR
  distributor2 - DISTRIBUTOR
  distributor3 - DISTRIBUTOR
  distributor4 - DISTRIBUTOR
  distributor5 - DISTRIBUTOR
  distributor6 - DISTRIBUTOR
  distributor7 - DISTRIBUTOR
  distributor8 - DISTRIBUTOR
  truck0 - TRUCK
  truck1 - TRUCK
  truck2 - TRUCK
  truck3 - TRUCK
  truck4 - TRUCK
  truck5 - TRUCK
  truck6 - TRUCK
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
  pallet16 - PALLET
  pallet17 - PALLET
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
  crate26 - CRATE
  crate27 - CRATE
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
  hoist16 - HOIST
  hoist17 - HOIST
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_pallet pallet0)
  (at_pallet_depot pallet1 depot1)
  (clear_crate crate4)
  (at_pallet_depot pallet2 depot2)
  (clear_crate crate27)
  (at_pallet_depot pallet3 depot3)
  (clear_pallet pallet3)
  (at_pallet_depot pallet4 depot4)
  (clear_crate crate26)
  (at_pallet_depot pallet5 depot5)
  (clear_crate crate24)
  (at_pallet_depot pallet6 depot6)
  (clear_pallet pallet6)
  (at_pallet_depot pallet7 depot7)
  (clear_pallet pallet7)
  (at_pallet_depot pallet8 depot8)
  (clear_crate crate19)
  (at_pallet_distributor pallet9 distributor0)
  (clear_crate crate12)
  (at_pallet_distributor pallet10 distributor1)
  (clear_crate crate20)
  (at_pallet_distributor pallet11 distributor2)
  (clear_pallet pallet11)
  (at_pallet_distributor pallet12 distributor3)
  (clear_crate crate21)
  (at_pallet_distributor pallet13 distributor4)
  (clear_crate crate5)
  (at_pallet_distributor pallet14 distributor5)
  (clear_crate crate22)
  (at_pallet_distributor pallet15 distributor6)
  (clear_crate crate17)
  (at_pallet_distributor pallet16 distributor7)
  (clear_crate crate25)
  (at_pallet_distributor pallet17 distributor8)
  (clear_crate crate3)
  (at_truck_distributor truck0 distributor4)
  (at_truck_depot truck1 depot7)
  (at_truck_distributor truck2 distributor4)
  (at_truck_depot truck3 depot4)
  (at_truck_distributor truck4 distributor5)
  (at_truck_distributor truck5 distributor6)
  (at_truck_depot truck6 depot7)
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
  (at_hoist_depot hoist8 depot8)
  (available hoist8)
  (at_hoist_distributor hoist9 distributor0)
  (available hoist9)
  (at_hoist_distributor hoist10 distributor1)
  (available hoist10)
  (at_hoist_distributor hoist11 distributor2)
  (available hoist11)
  (at_hoist_distributor hoist12 distributor3)
  (available hoist12)
  (at_hoist_distributor hoist13 distributor4)
  (available hoist13)
  (at_hoist_distributor hoist14 distributor5)
  (available hoist14)
  (at_hoist_distributor hoist15 distributor6)
  (available hoist15)
  (at_hoist_distributor hoist16 distributor7)
  (available hoist16)
  (at_hoist_distributor hoist17 distributor8)
  (available hoist17)
  (at_crate_distributor crate0 distributor0)
  (on_pallet crate0 pallet9)
  (at_crate_distributor crate1 distributor3)
  (on_pallet crate1 pallet12)
  (at_crate_distributor crate2 distributor7)
  (on_pallet crate2 pallet16)
  (at_crate_distributor crate3 distributor8)
  (on_pallet crate3 pallet17)
  (at_crate_depot crate4 depot1)
  (on_pallet crate4 pallet1)
  (at_crate_distributor crate5 distributor4)
  (on_pallet crate5 pallet13)
  (at_crate_depot crate6 depot2)
  (on_pallet crate6 pallet2)
  (at_crate_distributor crate7 distributor5)
  (on_pallet crate7 pallet14)
  (at_crate_depot crate8 depot5)
  (on_pallet crate8 pallet5)
  (at_crate_depot crate9 depot5)
  (on_crate crate9 crate8)
  (at_crate_distributor crate10 distributor7)
  (on_crate crate10 crate2)
  (at_crate_distributor crate11 distributor3)
  (on_crate crate11 crate1)
  (at_crate_distributor crate12 distributor0)
  (on_crate crate12 crate0)
  (at_crate_distributor crate13 distributor7)
  (on_crate crate13 crate10)
  (at_crate_depot crate14 depot2)
  (on_crate crate14 crate6)
  (at_crate_distributor crate15 distributor3)
  (on_crate crate15 crate11)
  (at_crate_distributor crate16 distributor1)
  (on_pallet crate16 pallet10)
  (at_crate_distributor crate17 distributor6)
  (on_pallet crate17 pallet15)
  (at_crate_depot crate18 depot2)
  (on_crate crate18 crate14)
  (at_crate_depot crate19 depot8)
  (on_pallet crate19 pallet8)
  (at_crate_distributor crate20 distributor1)
  (on_crate crate20 crate16)
  (at_crate_distributor crate21 distributor3)
  (on_crate crate21 crate15)
  (at_crate_distributor crate22 distributor5)
  (on_crate crate22 crate7)
  (at_crate_depot crate23 depot4)
  (on_pallet crate23 pallet4)
  (at_crate_depot crate24 depot5)
  (on_crate crate24 crate9)
  (at_crate_distributor crate25 distributor7)
  (on_crate crate25 crate13)
  (at_crate_depot crate26 depot4)
  (on_crate crate26 crate23)
  (at_crate_depot crate27 depot2)
  (on_crate crate27 crate18)
)
(:goal   (and (on_pallet crate0 pallet8)
  (on_pallet crate1 pallet1)
  (on_pallet crate2 pallet10)
  (on_crate crate3 crate26)
  (on_pallet crate5 pallet7)
  (on_crate crate7 crate25)
  (on_pallet crate8 pallet14)
  (on_pallet crate9 pallet6)
  (on_pallet crate10 pallet13)
  (on_pallet crate11 pallet9)
  (on_pallet crate12 pallet2)
  (on_pallet crate13 pallet0)
  (on_pallet crate14 pallet3)
  (on_pallet crate15 pallet17)
  (on_crate crate16 crate10)
  (on_crate crate17 crate1)
  (on_crate crate18 crate8)
  (on_pallet crate19 pallet4)
  (on_crate crate20 crate13)
  (on_pallet crate21 pallet11)
  (on_pallet crate22 pallet15)
  (on_crate crate23 crate14)
  (on_crate crate24 crate12)
  (on_pallet crate25 pallet12)
  (on_pallet crate26 pallet16)
  (on_crate crate27 crate21)))
)
