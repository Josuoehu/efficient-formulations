(define (problem depotprob1)
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
  depot9 - DEPOT
  distributor0 - DISTRIBUTOR
  distributor1 - DISTRIBUTOR
  distributor2 - DISTRIBUTOR
  distributor3 - DISTRIBUTOR
  distributor4 - DISTRIBUTOR
  distributor5 - DISTRIBUTOR
  distributor6 - DISTRIBUTOR
  distributor7 - DISTRIBUTOR
  distributor8 - DISTRIBUTOR
  distributor9 - DISTRIBUTOR
  truck0 - TRUCK
  truck1 - TRUCK
  truck2 - TRUCK
  truck3 - TRUCK
  truck4 - TRUCK
  truck5 - TRUCK
  truck6 - TRUCK
  truck7 - TRUCK
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
  pallet18 - PALLET
  pallet19 - PALLET
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
  crate28 - CRATE
  crate29 - CRATE
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
  hoist18 - HOIST
  hoist19 - HOIST
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_crate crate0)
  (at_pallet_depot pallet1 depot1)
  (clear_pallet pallet1)
  (at_pallet_depot pallet2 depot2)
  (clear_crate crate29)
  (at_pallet_depot pallet3 depot3)
  (clear_crate crate24)
  (at_pallet_depot pallet4 depot4)
  (clear_pallet pallet4)
  (at_pallet_depot pallet5 depot5)
  (clear_crate crate1)
  (at_pallet_depot pallet6 depot6)
  (clear_crate crate19)
  (at_pallet_depot pallet7 depot7)
  (clear_pallet pallet7)
  (at_pallet_depot pallet8 depot8)
  (clear_pallet pallet8)
  (at_pallet_depot pallet9 depot9)
  (clear_pallet pallet9)
  (at_pallet_distributor pallet10 distributor0)
  (clear_crate crate11)
  (at_pallet_distributor pallet11 distributor1)
  (clear_crate crate20)
  (at_pallet_distributor pallet12 distributor2)
  (clear_crate crate28)
  (at_pallet_distributor pallet13 distributor3)
  (clear_crate crate26)
  (at_pallet_distributor pallet14 distributor4)
  (clear_crate crate10)
  (at_pallet_distributor pallet15 distributor5)
  (clear_crate crate22)
  (at_pallet_distributor pallet16 distributor6)
  (clear_pallet pallet16)
  (at_pallet_distributor pallet17 distributor7)
  (clear_crate crate25)
  (at_pallet_distributor pallet18 distributor8)
  (clear_crate crate14)
  (at_pallet_distributor pallet19 distributor9)
  (clear_crate crate18)
  (at_truck_depot truck0 depot2)
  (at_truck_distributor truck1 distributor0)
  (at_truck_depot truck2 depot6)
  (at_truck_depot truck3 depot3)
  (at_truck_distributor truck4 distributor2)
  (at_truck_distributor truck5 distributor6)
  (at_truck_distributor truck6 distributor8)
  (at_truck_depot truck7 depot4)
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
  (at_hoist_depot hoist9 depot9)
  (available hoist9)
  (at_hoist_distributor hoist10 distributor0)
  (available hoist10)
  (at_hoist_distributor hoist11 distributor1)
  (available hoist11)
  (at_hoist_distributor hoist12 distributor2)
  (available hoist12)
  (at_hoist_distributor hoist13 distributor3)
  (available hoist13)
  (at_hoist_distributor hoist14 distributor4)
  (available hoist14)
  (at_hoist_distributor hoist15 distributor5)
  (available hoist15)
  (at_hoist_distributor hoist16 distributor6)
  (available hoist16)
  (at_hoist_distributor hoist17 distributor7)
  (available hoist17)
  (at_hoist_distributor hoist18 distributor8)
  (available hoist18)
  (at_hoist_distributor hoist19 distributor9)
  (available hoist19)
  (at_crate_depot crate0 depot0)
  (on_pallet crate0 pallet0)
  (at_crate_depot crate1 depot5)
  (on_pallet crate1 pallet5)
  (at_crate_distributor crate2 distributor7)
  (on_pallet crate2 pallet17)
  (at_crate_depot crate3 depot6)
  (on_pallet crate3 pallet6)
  (at_crate_distributor crate4 distributor7)
  (on_crate crate4 crate2)
  (at_crate_depot crate5 depot6)
  (on_crate crate5 crate3)
  (at_crate_depot crate6 depot3)
  (on_pallet crate6 pallet3)
  (at_crate_distributor crate7 distributor0)
  (on_pallet crate7 pallet10)
  (at_crate_distributor crate8 distributor3)
  (on_pallet crate8 pallet13)
  (at_crate_depot crate9 depot3)
  (on_crate crate9 crate6)
  (at_crate_distributor crate10 distributor4)
  (on_pallet crate10 pallet14)
  (at_crate_distributor crate11 distributor0)
  (on_crate crate11 crate7)
  (at_crate_distributor crate12 distributor8)
  (on_pallet crate12 pallet18)
  (at_crate_distributor crate13 distributor8)
  (on_crate crate13 crate12)
  (at_crate_distributor crate14 distributor8)
  (on_crate crate14 crate13)
  (at_crate_distributor crate15 distributor1)
  (on_pallet crate15 pallet11)
  (at_crate_distributor crate16 distributor5)
  (on_pallet crate16 pallet15)
  (at_crate_distributor crate17 distributor1)
  (on_crate crate17 crate15)
  (at_crate_distributor crate18 distributor9)
  (on_pallet crate18 pallet19)
  (at_crate_depot crate19 depot6)
  (on_crate crate19 crate5)
  (at_crate_distributor crate20 distributor1)
  (on_crate crate20 crate17)
  (at_crate_distributor crate21 distributor5)
  (on_crate crate21 crate16)
  (at_crate_distributor crate22 distributor5)
  (on_crate crate22 crate21)
  (at_crate_distributor crate23 distributor2)
  (on_pallet crate23 pallet12)
  (at_crate_depot crate24 depot3)
  (on_crate crate24 crate9)
  (at_crate_distributor crate25 distributor7)
  (on_crate crate25 crate4)
  (at_crate_distributor crate26 distributor3)
  (on_crate crate26 crate8)
  (at_crate_distributor crate27 distributor2)
  (on_crate crate27 crate23)
  (at_crate_distributor crate28 distributor2)
  (on_crate crate28 crate27)
  (at_crate_depot crate29 depot2)
  (on_pallet crate29 pallet2)
)
(:goal   (and (on_pallet crate0 pallet14)
  (on_pallet crate1 pallet1)
  (on_pallet crate3 pallet9)
  (on_crate crate5 crate22)
  (on_crate crate6 crate12)
  (on_crate crate7 crate15)
  (on_pallet crate9 pallet8)
  (on_pallet crate10 pallet13)
  (on_pallet crate11 pallet12)
  (on_pallet crate12 pallet4)
  (on_pallet crate13 pallet2)
  (on_pallet crate14 pallet19)
  (on_crate crate15 crate17)
  (on_crate crate16 crate6)
  (on_pallet crate17 pallet0)
  (on_pallet crate18 pallet18)
  (on_pallet crate19 pallet11)
  (on_crate crate20 crate19)
  (on_pallet crate21 pallet10)
  (on_crate crate22 crate3)
  (on_pallet crate23 pallet6)
  (on_crate crate24 crate21)
  (on_crate crate25 crate14)
  (on_crate crate26 crate25)
  (on_pallet crate27 pallet5)
  (on_pallet crate28 pallet17)))
)
