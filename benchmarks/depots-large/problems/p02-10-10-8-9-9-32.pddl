(define (problem depotprob2)
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
  crate30 - CRATE
  crate31 - CRATE
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
  (clear_crate crate26)
  (at_pallet_depot pallet1 depot1)
  (clear_crate crate28)
  (at_pallet_depot pallet2 depot2)
  (clear_crate crate31)
  (at_pallet_depot pallet3 depot3)
  (clear_crate crate17)
  (at_pallet_depot pallet4 depot4)
  (clear_crate crate23)
  (at_pallet_depot pallet5 depot5)
  (clear_crate crate6)
  (at_pallet_depot pallet6 depot6)
  (clear_crate crate5)
  (at_pallet_depot pallet7 depot7)
  (clear_crate crate9)
  (at_pallet_depot pallet8 depot8)
  (clear_crate crate22)
  (at_pallet_depot pallet9 depot9)
  (clear_crate crate20)
  (at_pallet_distributor pallet10 distributor0)
  (clear_crate crate11)
  (at_pallet_distributor pallet11 distributor1)
  (clear_pallet pallet11)
  (at_pallet_distributor pallet12 distributor2)
  (clear_pallet pallet12)
  (at_pallet_distributor pallet13 distributor3)
  (clear_crate crate29)
  (at_pallet_distributor pallet14 distributor4)
  (clear_pallet pallet14)
  (at_pallet_distributor pallet15 distributor5)
  (clear_crate crate30)
  (at_pallet_distributor pallet16 distributor6)
  (clear_crate crate8)
  (at_pallet_distributor pallet17 distributor7)
  (clear_crate crate10)
  (at_pallet_distributor pallet18 distributor8)
  (clear_pallet pallet18)
  (at_pallet_distributor pallet19 distributor9)
  (clear_crate crate18)
  (at_truck_distributor truck0 distributor4)
  (at_truck_depot truck1 depot2)
  (at_truck_depot truck2 depot4)
  (at_truck_distributor truck3 distributor9)
  (at_truck_distributor truck4 distributor8)
  (at_truck_distributor truck5 distributor1)
  (at_truck_distributor truck6 distributor6)
  (at_truck_distributor truck7 distributor0)
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
  (at_crate_distributor crate0 distributor5)
  (on_pallet crate0 pallet15)
  (at_crate_distributor crate1 distributor6)
  (on_pallet crate1 pallet16)
  (at_crate_distributor crate2 distributor3)
  (on_pallet crate2 pallet13)
  (at_crate_depot crate3 depot9)
  (on_pallet crate3 pallet9)
  (at_crate_depot crate4 depot1)
  (on_pallet crate4 pallet1)
  (at_crate_depot crate5 depot6)
  (on_pallet crate5 pallet6)
  (at_crate_depot crate6 depot5)
  (on_pallet crate6 pallet5)
  (at_crate_distributor crate7 distributor7)
  (on_pallet crate7 pallet17)
  (at_crate_distributor crate8 distributor6)
  (on_crate crate8 crate1)
  (at_crate_depot crate9 depot7)
  (on_pallet crate9 pallet7)
  (at_crate_distributor crate10 distributor7)
  (on_crate crate10 crate7)
  (at_crate_distributor crate11 distributor0)
  (on_pallet crate11 pallet10)
  (at_crate_depot crate12 depot1)
  (on_crate crate12 crate4)
  (at_crate_depot crate13 depot8)
  (on_pallet crate13 pallet8)
  (at_crate_depot crate14 depot2)
  (on_pallet crate14 pallet2)
  (at_crate_depot crate15 depot1)
  (on_crate crate15 crate12)
  (at_crate_depot crate16 depot0)
  (on_pallet crate16 pallet0)
  (at_crate_depot crate17 depot3)
  (on_pallet crate17 pallet3)
  (at_crate_distributor crate18 distributor9)
  (on_pallet crate18 pallet19)
  (at_crate_depot crate19 depot4)
  (on_pallet crate19 pallet4)
  (at_crate_depot crate20 depot9)
  (on_crate crate20 crate3)
  (at_crate_depot crate21 depot0)
  (on_crate crate21 crate16)
  (at_crate_depot crate22 depot8)
  (on_crate crate22 crate13)
  (at_crate_depot crate23 depot4)
  (on_crate crate23 crate19)
  (at_crate_distributor crate24 distributor5)
  (on_crate crate24 crate0)
  (at_crate_distributor crate25 distributor3)
  (on_crate crate25 crate2)
  (at_crate_depot crate26 depot0)
  (on_crate crate26 crate21)
  (at_crate_depot crate27 depot2)
  (on_crate crate27 crate14)
  (at_crate_depot crate28 depot1)
  (on_crate crate28 crate15)
  (at_crate_distributor crate29 distributor3)
  (on_crate crate29 crate25)
  (at_crate_distributor crate30 distributor5)
  (on_crate crate30 crate24)
  (at_crate_depot crate31 depot2)
  (on_crate crate31 crate27)
)
(:goal   (and (on_crate crate0 crate11)
  (on_pallet crate1 pallet2)
  (on_pallet crate2 pallet0)
  (on_crate crate3 crate28)
  (on_pallet crate4 pallet9)
  (on_pallet crate5 pallet5)
  (on_pallet crate7 pallet18)
  (on_crate crate8 crate29)
  (on_pallet crate9 pallet6)
  (on_pallet crate10 pallet11)
  (on_pallet crate11 pallet1)
  (on_crate crate12 crate16)
  (on_pallet crate14 pallet7)
  (on_crate crate15 crate19)
  (on_crate crate16 crate26)
  (on_pallet crate18 pallet14)
  (on_pallet crate19 pallet19)
  (on_pallet crate21 pallet4)
  (on_pallet crate22 pallet17)
  (on_crate crate23 crate18)
  (on_crate crate24 crate10)
  (on_pallet crate25 pallet13)
  (on_pallet crate26 pallet12)
  (on_pallet crate27 pallet3)
  (on_pallet crate28 pallet16)
  (on_crate crate29 crate14)
  (on_crate crate30 crate4)
  (on_pallet crate31 pallet10)))
)
