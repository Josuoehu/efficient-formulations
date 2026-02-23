(define (problem depotprob6)
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
  depot12 - DEPOT
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
  distributor12 - DISTRIBUTOR
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
  truck10 - TRUCK
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
  pallet24 - PALLET
  pallet25 - PALLET
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
  crate38 - CRATE
  crate39 - CRATE
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
  hoist24 - HOIST
  hoist25 - HOIST
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_crate crate23)
  (at_pallet_depot pallet1 depot1)
  (clear_pallet pallet1)
  (at_pallet_depot pallet2 depot2)
  (clear_pallet pallet2)
  (at_pallet_depot pallet3 depot3)
  (clear_crate crate10)
  (at_pallet_depot pallet4 depot4)
  (clear_crate crate18)
  (at_pallet_depot pallet5 depot5)
  (clear_crate crate31)
  (at_pallet_depot pallet6 depot6)
  (clear_pallet pallet6)
  (at_pallet_depot pallet7 depot7)
  (clear_pallet pallet7)
  (at_pallet_depot pallet8 depot8)
  (clear_crate crate1)
  (at_pallet_depot pallet9 depot9)
  (clear_crate crate30)
  (at_pallet_depot pallet10 depot10)
  (clear_crate crate36)
  (at_pallet_depot pallet11 depot11)
  (clear_crate crate35)
  (at_pallet_depot pallet12 depot12)
  (clear_crate crate22)
  (at_pallet_distributor pallet13 distributor0)
  (clear_pallet pallet13)
  (at_pallet_distributor pallet14 distributor1)
  (clear_crate crate26)
  (at_pallet_distributor pallet15 distributor2)
  (clear_crate crate29)
  (at_pallet_distributor pallet16 distributor3)
  (clear_crate crate25)
  (at_pallet_distributor pallet17 distributor4)
  (clear_crate crate27)
  (at_pallet_distributor pallet18 distributor5)
  (clear_crate crate20)
  (at_pallet_distributor pallet19 distributor6)
  (clear_crate crate34)
  (at_pallet_distributor pallet20 distributor7)
  (clear_crate crate33)
  (at_pallet_distributor pallet21 distributor8)
  (clear_crate crate38)
  (at_pallet_distributor pallet22 distributor9)
  (clear_crate crate6)
  (at_pallet_distributor pallet23 distributor10)
  (clear_crate crate32)
  (at_pallet_distributor pallet24 distributor11)
  (clear_crate crate21)
  (at_pallet_distributor pallet25 distributor12)
  (clear_crate crate39)
  (at_truck_distributor truck0 distributor8)
  (at_truck_depot truck1 depot10)
  (at_truck_distributor truck2 distributor4)
  (at_truck_depot truck3 depot5)
  (at_truck_depot truck4 depot7)
  (at_truck_depot truck5 depot10)
  (at_truck_depot truck6 depot0)
  (at_truck_depot truck7 depot2)
  (at_truck_distributor truck8 distributor6)
  (at_truck_depot truck9 depot11)
  (at_truck_depot truck10 depot8)
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
  (at_hoist_depot hoist12 depot12)
  (available hoist12)
  (at_hoist_distributor hoist13 distributor0)
  (available hoist13)
  (at_hoist_distributor hoist14 distributor1)
  (available hoist14)
  (at_hoist_distributor hoist15 distributor2)
  (available hoist15)
  (at_hoist_distributor hoist16 distributor3)
  (available hoist16)
  (at_hoist_distributor hoist17 distributor4)
  (available hoist17)
  (at_hoist_distributor hoist18 distributor5)
  (available hoist18)
  (at_hoist_distributor hoist19 distributor6)
  (available hoist19)
  (at_hoist_distributor hoist20 distributor7)
  (available hoist20)
  (at_hoist_distributor hoist21 distributor8)
  (available hoist21)
  (at_hoist_distributor hoist22 distributor9)
  (available hoist22)
  (at_hoist_distributor hoist23 distributor10)
  (available hoist23)
  (at_hoist_distributor hoist24 distributor11)
  (available hoist24)
  (at_hoist_distributor hoist25 distributor12)
  (available hoist25)
  (at_crate_distributor crate0 distributor12)
  (on_pallet crate0 pallet25)
  (at_crate_depot crate1 depot8)
  (on_pallet crate1 pallet8)
  (at_crate_distributor crate2 distributor9)
  (on_pallet crate2 pallet22)
  (at_crate_depot crate3 depot3)
  (on_pallet crate3 pallet3)
  (at_crate_depot crate4 depot4)
  (on_pallet crate4 pallet4)
  (at_crate_distributor crate5 distributor10)
  (on_pallet crate5 pallet23)
  (at_crate_distributor crate6 distributor9)
  (on_crate crate6 crate2)
  (at_crate_depot crate7 depot12)
  (on_pallet crate7 pallet12)
  (at_crate_distributor crate8 distributor3)
  (on_pallet crate8 pallet16)
  (at_crate_distributor crate9 distributor8)
  (on_pallet crate9 pallet21)
  (at_crate_depot crate10 depot3)
  (on_crate crate10 crate3)
  (at_crate_distributor crate11 distributor8)
  (on_crate crate11 crate9)
  (at_crate_depot crate12 depot5)
  (on_pallet crate12 pallet5)
  (at_crate_distributor crate13 distributor8)
  (on_crate crate13 crate11)
  (at_crate_distributor crate14 distributor4)
  (on_pallet crate14 pallet17)
  (at_crate_distributor crate15 distributor12)
  (on_crate crate15 crate0)
  (at_crate_distributor crate16 distributor7)
  (on_pallet crate16 pallet20)
  (at_crate_depot crate17 depot5)
  (on_crate crate17 crate12)
  (at_crate_depot crate18 depot4)
  (on_crate crate18 crate4)
  (at_crate_depot crate19 depot9)
  (on_pallet crate19 pallet9)
  (at_crate_distributor crate20 distributor5)
  (on_pallet crate20 pallet18)
  (at_crate_distributor crate21 distributor11)
  (on_pallet crate21 pallet24)
  (at_crate_depot crate22 depot12)
  (on_crate crate22 crate7)
  (at_crate_depot crate23 depot0)
  (on_pallet crate23 pallet0)
  (at_crate_distributor crate24 distributor8)
  (on_crate crate24 crate13)
  (at_crate_distributor crate25 distributor3)
  (on_crate crate25 crate8)
  (at_crate_distributor crate26 distributor1)
  (on_pallet crate26 pallet14)
  (at_crate_distributor crate27 distributor4)
  (on_crate crate27 crate14)
  (at_crate_distributor crate28 distributor10)
  (on_crate crate28 crate5)
  (at_crate_distributor crate29 distributor2)
  (on_pallet crate29 pallet15)
  (at_crate_depot crate30 depot9)
  (on_crate crate30 crate19)
  (at_crate_depot crate31 depot5)
  (on_crate crate31 crate17)
  (at_crate_distributor crate32 distributor10)
  (on_crate crate32 crate28)
  (at_crate_distributor crate33 distributor7)
  (on_crate crate33 crate16)
  (at_crate_distributor crate34 distributor6)
  (on_pallet crate34 pallet19)
  (at_crate_depot crate35 depot11)
  (on_pallet crate35 pallet11)
  (at_crate_depot crate36 depot10)
  (on_pallet crate36 pallet10)
  (at_crate_distributor crate37 distributor12)
  (on_crate crate37 crate15)
  (at_crate_distributor crate38 distributor8)
  (on_crate crate38 crate24)
  (at_crate_distributor crate39 distributor12)
  (on_crate crate39 crate37)
)
(:goal   (and (on_pallet crate1 pallet7)
  (on_crate crate2 crate20)
  (on_pallet crate3 pallet5)
  (on_pallet crate4 pallet6)
  (on_crate crate5 crate11)
  (on_pallet crate6 pallet1)
  (on_pallet crate7 pallet15)
  (on_pallet crate8 pallet25)
  (on_crate crate9 crate5)
  (on_crate crate10 crate30)
  (on_pallet crate11 pallet8)
  (on_pallet crate12 pallet4)
  (on_pallet crate13 pallet13)
  (on_crate crate14 crate13)
  (on_pallet crate15 pallet19)
  (on_pallet crate17 pallet23)
  (on_pallet crate18 pallet2)
  (on_crate crate20 crate15)
  (on_pallet crate21 pallet3)
  (on_crate crate22 crate17)
  (on_pallet crate23 pallet11)
  (on_crate crate24 crate34)
  (on_pallet crate25 pallet22)
  (on_crate crate26 crate37)
  (on_crate crate27 crate29)
  (on_pallet crate28 pallet20)
  (on_crate crate29 crate4)
  (on_pallet crate30 pallet21)
  (on_crate crate33 crate25)
  (on_crate crate34 crate22)
  (on_pallet crate35 pallet9)
  (on_pallet crate37 pallet18)
  (on_crate crate39 crate27)))
)
