(define (problem depotprob5)
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
  depot10 - DEPOT
  depot11 - DEPOT
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
  distributor10 - DISTRIBUTOR
  distributor11 - DISTRIBUTOR
  truck0 - TRUCK
  truck1 - TRUCK
  truck2 - TRUCK
  truck3 - TRUCK
  truck4 - TRUCK
  truck5 - TRUCK
  truck6 - TRUCK
  truck7 - TRUCK
  truck8 - TRUCK
  truck9 - TRUCK
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
  pallet20 - PALLET
  pallet21 - PALLET
  pallet22 - PALLET
  pallet23 - PALLET
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
  crate32 - CRATE
  crate33 - CRATE
  crate34 - CRATE
  crate35 - CRATE
  crate36 - CRATE
  crate37 - CRATE
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
  hoist20 - HOIST
  hoist21 - HOIST
  hoist22 - HOIST
  hoist23 - HOIST
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_crate crate25)
  (at_pallet_depot pallet1 depot1)
  (clear_crate crate3)
  (at_pallet_depot pallet2 depot2)
  (clear_pallet pallet2)
  (at_pallet_depot pallet3 depot3)
  (clear_crate crate24)
  (at_pallet_depot pallet4 depot4)
  (clear_crate crate33)
  (at_pallet_depot pallet5 depot5)
  (clear_pallet pallet5)
  (at_pallet_depot pallet6 depot6)
  (clear_crate crate28)
  (at_pallet_depot pallet7 depot7)
  (clear_crate crate32)
  (at_pallet_depot pallet8 depot8)
  (clear_crate crate37)
  (at_pallet_depot pallet9 depot9)
  (clear_crate crate23)
  (at_pallet_depot pallet10 depot10)
  (clear_crate crate35)
  (at_pallet_depot pallet11 depot11)
  (clear_crate crate27)
  (at_pallet_distributor pallet12 distributor0)
  (clear_crate crate0)
  (at_pallet_distributor pallet13 distributor1)
  (clear_crate crate7)
  (at_pallet_distributor pallet14 distributor2)
  (clear_crate crate15)
  (at_pallet_distributor pallet15 distributor3)
  (clear_crate crate36)
  (at_pallet_distributor pallet16 distributor4)
  (clear_crate crate22)
  (at_pallet_distributor pallet17 distributor5)
  (clear_crate crate34)
  (at_pallet_distributor pallet18 distributor6)
  (clear_crate crate14)
  (at_pallet_distributor pallet19 distributor7)
  (clear_crate crate16)
  (at_pallet_distributor pallet20 distributor8)
  (clear_pallet pallet20)
  (at_pallet_distributor pallet21 distributor9)
  (clear_crate crate8)
  (at_pallet_distributor pallet22 distributor10)
  (clear_crate crate19)
  (at_pallet_distributor pallet23 distributor11)
  (clear_crate crate12)
  (at_truck_depot truck0 depot2)
  (at_truck_distributor truck1 distributor7)
  (at_truck_depot truck2 depot2)
  (at_truck_distributor truck3 distributor9)
  (at_truck_depot truck4 depot1)
  (at_truck_distributor truck5 distributor4)
  (at_truck_distributor truck6 distributor3)
  (at_truck_depot truck7 depot4)
  (at_truck_depot truck8 depot3)
  (at_truck_distributor truck9 distributor9)
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
  (at_hoist_depot hoist10 depot10)
  (available hoist10)
  (at_hoist_depot hoist11 depot11)
  (available hoist11)
  (at_hoist_distributor hoist12 distributor0)
  (available hoist12)
  (at_hoist_distributor hoist13 distributor1)
  (available hoist13)
  (at_hoist_distributor hoist14 distributor2)
  (available hoist14)
  (at_hoist_distributor hoist15 distributor3)
  (available hoist15)
  (at_hoist_distributor hoist16 distributor4)
  (available hoist16)
  (at_hoist_distributor hoist17 distributor5)
  (available hoist17)
  (at_hoist_distributor hoist18 distributor6)
  (available hoist18)
  (at_hoist_distributor hoist19 distributor7)
  (available hoist19)
  (at_hoist_distributor hoist20 distributor8)
  (available hoist20)
  (at_hoist_distributor hoist21 distributor9)
  (available hoist21)
  (at_hoist_distributor hoist22 distributor10)
  (available hoist22)
  (at_hoist_distributor hoist23 distributor11)
  (available hoist23)
  (at_crate_distributor crate0 distributor0)
  (on_pallet crate0 pallet12)
  (at_crate_distributor crate1 distributor9)
  (on_pallet crate1 pallet21)
  (at_crate_depot crate2 depot6)
  (on_pallet crate2 pallet6)
  (at_crate_depot crate3 depot1)
  (on_pallet crate3 pallet1)
  (at_crate_distributor crate4 distributor5)
  (on_pallet crate4 pallet17)
  (at_crate_distributor crate5 distributor2)
  (on_pallet crate5 pallet14)
  (at_crate_distributor crate6 distributor5)
  (on_crate crate6 crate4)
  (at_crate_distributor crate7 distributor1)
  (on_pallet crate7 pallet13)
  (at_crate_distributor crate8 distributor9)
  (on_crate crate8 crate1)
  (at_crate_distributor crate9 distributor5)
  (on_crate crate9 crate6)
  (at_crate_distributor crate10 distributor6)
  (on_pallet crate10 pallet18)
  (at_crate_depot crate11 depot6)
  (on_crate crate11 crate2)
  (at_crate_distributor crate12 distributor11)
  (on_pallet crate12 pallet23)
  (at_crate_depot crate13 depot10)
  (on_pallet crate13 pallet10)
  (at_crate_distributor crate14 distributor6)
  (on_crate crate14 crate10)
  (at_crate_distributor crate15 distributor2)
  (on_crate crate15 crate5)
  (at_crate_distributor crate16 distributor7)
  (on_pallet crate16 pallet19)
  (at_crate_depot crate17 depot4)
  (on_pallet crate17 pallet4)
  (at_crate_depot crate18 depot4)
  (on_crate crate18 crate17)
  (at_crate_distributor crate19 distributor10)
  (on_pallet crate19 pallet22)
  (at_crate_depot crate20 depot10)
  (on_crate crate20 crate13)
  (at_crate_depot crate21 depot6)
  (on_crate crate21 crate11)
  (at_crate_distributor crate22 distributor4)
  (on_pallet crate22 pallet16)
  (at_crate_depot crate23 depot9)
  (on_pallet crate23 pallet9)
  (at_crate_depot crate24 depot3)
  (on_pallet crate24 pallet3)
  (at_crate_depot crate25 depot0)
  (on_pallet crate25 pallet0)
  (at_crate_depot crate26 depot10)
  (on_crate crate26 crate20)
  (at_crate_depot crate27 depot11)
  (on_pallet crate27 pallet11)
  (at_crate_depot crate28 depot6)
  (on_crate crate28 crate21)
  (at_crate_depot crate29 depot4)
  (on_crate crate29 crate18)
  (at_crate_depot crate30 depot7)
  (on_pallet crate30 pallet7)
  (at_crate_depot crate31 depot7)
  (on_crate crate31 crate30)
  (at_crate_depot crate32 depot7)
  (on_crate crate32 crate31)
  (at_crate_depot crate33 depot4)
  (on_crate crate33 crate29)
  (at_crate_distributor crate34 distributor5)
  (on_crate crate34 crate9)
  (at_crate_depot crate35 depot10)
  (on_crate crate35 crate26)
  (at_crate_distributor crate36 distributor3)
  (on_pallet crate36 pallet15)
  (at_crate_depot crate37 depot8)
  (on_pallet crate37 pallet8)
)
(:goal   (and (on_pallet crate0 pallet15)
  (on_pallet crate1 pallet10)
  (on_crate crate2 crate9)
  (on_pallet crate4 pallet0)
  (on_crate crate6 crate31)
  (on_crate crate7 crate26)
  (on_pallet crate8 pallet18)
  (on_pallet crate9 pallet5)
  (on_crate crate10 crate12)
  (on_crate crate11 crate34)
  (on_pallet crate12 pallet12)
  (on_crate crate13 crate17)
  (on_pallet crate15 pallet9)
  (on_pallet crate16 pallet23)
  (on_pallet crate17 pallet22)
  (on_pallet crate18 pallet14)
  (on_pallet crate19 pallet17)
  (on_crate crate20 crate15)
  (on_crate crate21 crate13)
  (on_crate crate23 crate24)
  (on_pallet crate24 pallet19)
  (on_crate crate25 crate4)
  (on_pallet crate26 pallet7)
  (on_pallet crate27 pallet21)
  (on_crate crate28 crate37)
  (on_pallet crate29 pallet16)
  (on_pallet crate30 pallet8)
  (on_pallet crate31 pallet11)
  (on_pallet crate32 pallet3)
  (on_pallet crate33 pallet6)
  (on_pallet crate34 pallet13)
  (on_pallet crate35 pallet1)
  (on_crate crate36 crate32)
  (on_crate crate37 crate18)))
)
