(define (problem depotprob9)
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
  depot13 - DEPOT
  depot14 - DEPOT
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
  distributor13 - DISTRIBUTOR
  distributor14 - DISTRIBUTOR
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
  truck11 - TRUCK
  truck12 - TRUCK
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
  pallet26 - PALLET
  pallet27 - PALLET
  pallet28 - PALLET
  pallet29 - PALLET
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
  crate40 - CRATE
  crate41 - CRATE
  crate42 - CRATE
  crate43 - CRATE
  crate44 - CRATE
  crate45 - CRATE
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
  hoist26 - HOIST
  hoist27 - HOIST
  hoist28 - HOIST
  hoist29 - HOIST
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_crate crate33)
  (at_pallet_depot pallet1 depot1)
  (clear_crate crate29)
  (at_pallet_depot pallet2 depot2)
  (clear_crate crate22)
  (at_pallet_depot pallet3 depot3)
  (clear_crate crate41)
  (at_pallet_depot pallet4 depot4)
  (clear_pallet pallet4)
  (at_pallet_depot pallet5 depot5)
  (clear_crate crate25)
  (at_pallet_depot pallet6 depot6)
  (clear_crate crate38)
  (at_pallet_depot pallet7 depot7)
  (clear_crate crate37)
  (at_pallet_depot pallet8 depot8)
  (clear_crate crate39)
  (at_pallet_depot pallet9 depot9)
  (clear_crate crate31)
  (at_pallet_depot pallet10 depot10)
  (clear_crate crate27)
  (at_pallet_depot pallet11 depot11)
  (clear_crate crate45)
  (at_pallet_depot pallet12 depot12)
  (clear_crate crate35)
  (at_pallet_depot pallet13 depot13)
  (clear_crate crate26)
  (at_pallet_depot pallet14 depot14)
  (clear_pallet pallet14)
  (at_pallet_distributor pallet15 distributor0)
  (clear_pallet pallet15)
  (at_pallet_distributor pallet16 distributor1)
  (clear_crate crate43)
  (at_pallet_distributor pallet17 distributor2)
  (clear_crate crate30)
  (at_pallet_distributor pallet18 distributor3)
  (clear_crate crate14)
  (at_pallet_distributor pallet19 distributor4)
  (clear_crate crate24)
  (at_pallet_distributor pallet20 distributor5)
  (clear_crate crate4)
  (at_pallet_distributor pallet21 distributor6)
  (clear_crate crate34)
  (at_pallet_distributor pallet22 distributor7)
  (clear_crate crate11)
  (at_pallet_distributor pallet23 distributor8)
  (clear_crate crate23)
  (at_pallet_distributor pallet24 distributor9)
  (clear_crate crate16)
  (at_pallet_distributor pallet25 distributor10)
  (clear_crate crate36)
  (at_pallet_distributor pallet26 distributor11)
  (clear_crate crate7)
  (at_pallet_distributor pallet27 distributor12)
  (clear_crate crate40)
  (at_pallet_distributor pallet28 distributor13)
  (clear_crate crate44)
  (at_pallet_distributor pallet29 distributor14)
  (clear_crate crate6)
  (at_truck_distributor truck0 distributor8)
  (at_truck_depot truck1 depot12)
  (at_truck_depot truck2 depot11)
  (at_truck_distributor truck3 distributor12)
  (at_truck_depot truck4 depot9)
  (at_truck_depot truck5 depot12)
  (at_truck_depot truck6 depot5)
  (at_truck_depot truck7 depot1)
  (at_truck_distributor truck8 distributor6)
  (at_truck_depot truck9 depot3)
  (at_truck_distributor truck10 distributor10)
  (at_truck_distributor truck11 distributor2)
  (at_truck_distributor truck12 distributor13)
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
  (at_hoist_depot hoist13 depot13)
  (available hoist13)
  (at_hoist_depot hoist14 depot14)
  (available hoist14)
  (at_hoist_distributor hoist15 distributor0)
  (available hoist15)
  (at_hoist_distributor hoist16 distributor1)
  (available hoist16)
  (at_hoist_distributor hoist17 distributor2)
  (available hoist17)
  (at_hoist_distributor hoist18 distributor3)
  (available hoist18)
  (at_hoist_distributor hoist19 distributor4)
  (available hoist19)
  (at_hoist_distributor hoist20 distributor5)
  (available hoist20)
  (at_hoist_distributor hoist21 distributor6)
  (available hoist21)
  (at_hoist_distributor hoist22 distributor7)
  (available hoist22)
  (at_hoist_distributor hoist23 distributor8)
  (available hoist23)
  (at_hoist_distributor hoist24 distributor9)
  (available hoist24)
  (at_hoist_distributor hoist25 distributor10)
  (available hoist25)
  (at_hoist_distributor hoist26 distributor11)
  (available hoist26)
  (at_hoist_distributor hoist27 distributor12)
  (available hoist27)
  (at_hoist_distributor hoist28 distributor13)
  (available hoist28)
  (at_hoist_distributor hoist29 distributor14)
  (available hoist29)
  (at_crate_depot crate0 depot11)
  (on_pallet crate0 pallet11)
  (at_crate_depot crate1 depot9)
  (on_pallet crate1 pallet9)
  (at_crate_distributor crate2 distributor9)
  (on_pallet crate2 pallet24)
  (at_crate_distributor crate3 distributor5)
  (on_pallet crate3 pallet20)
  (at_crate_distributor crate4 distributor5)
  (on_crate crate4 crate3)
  (at_crate_depot crate5 depot3)
  (on_pallet crate5 pallet3)
  (at_crate_distributor crate6 distributor14)
  (on_pallet crate6 pallet29)
  (at_crate_distributor crate7 distributor11)
  (on_pallet crate7 pallet26)
  (at_crate_depot crate8 depot7)
  (on_pallet crate8 pallet7)
  (at_crate_depot crate9 depot2)
  (on_pallet crate9 pallet2)
  (at_crate_distributor crate10 distributor3)
  (on_pallet crate10 pallet18)
  (at_crate_distributor crate11 distributor7)
  (on_pallet crate11 pallet22)
  (at_crate_distributor crate12 distributor6)
  (on_pallet crate12 pallet21)
  (at_crate_depot crate13 depot3)
  (on_crate crate13 crate5)
  (at_crate_distributor crate14 distributor3)
  (on_crate crate14 crate10)
  (at_crate_depot crate15 depot8)
  (on_pallet crate15 pallet8)
  (at_crate_distributor crate16 distributor9)
  (on_crate crate16 crate2)
  (at_crate_distributor crate17 distributor10)
  (on_pallet crate17 pallet25)
  (at_crate_depot crate18 depot12)
  (on_pallet crate18 pallet12)
  (at_crate_depot crate19 depot10)
  (on_pallet crate19 pallet10)
  (at_crate_depot crate20 depot8)
  (on_crate crate20 crate15)
  (at_crate_distributor crate21 distributor13)
  (on_pallet crate21 pallet28)
  (at_crate_depot crate22 depot2)
  (on_crate crate22 crate9)
  (at_crate_distributor crate23 distributor8)
  (on_pallet crate23 pallet23)
  (at_crate_distributor crate24 distributor4)
  (on_pallet crate24 pallet19)
  (at_crate_depot crate25 depot5)
  (on_pallet crate25 pallet5)
  (at_crate_depot crate26 depot13)
  (on_pallet crate26 pallet13)
  (at_crate_depot crate27 depot10)
  (on_crate crate27 crate19)
  (at_crate_distributor crate28 distributor6)
  (on_crate crate28 crate12)
  (at_crate_depot crate29 depot1)
  (on_pallet crate29 pallet1)
  (at_crate_distributor crate30 distributor2)
  (on_pallet crate30 pallet17)
  (at_crate_depot crate31 depot9)
  (on_crate crate31 crate1)
  (at_crate_distributor crate32 distributor12)
  (on_pallet crate32 pallet27)
  (at_crate_depot crate33 depot0)
  (on_pallet crate33 pallet0)
  (at_crate_distributor crate34 distributor6)
  (on_crate crate34 crate28)
  (at_crate_depot crate35 depot12)
  (on_crate crate35 crate18)
  (at_crate_distributor crate36 distributor10)
  (on_crate crate36 crate17)
  (at_crate_depot crate37 depot7)
  (on_crate crate37 crate8)
  (at_crate_depot crate38 depot6)
  (on_pallet crate38 pallet6)
  (at_crate_depot crate39 depot8)
  (on_crate crate39 crate20)
  (at_crate_distributor crate40 distributor12)
  (on_crate crate40 crate32)
  (at_crate_depot crate41 depot3)
  (on_crate crate41 crate13)
  (at_crate_depot crate42 depot11)
  (on_crate crate42 crate0)
  (at_crate_distributor crate43 distributor1)
  (on_pallet crate43 pallet16)
  (at_crate_distributor crate44 distributor13)
  (on_crate crate44 crate21)
  (at_crate_depot crate45 depot11)
  (on_crate crate45 crate42)
)
(:goal   (and (on_crate crate1 crate15)
  (on_pallet crate3 pallet6)
  (on_pallet crate6 pallet29)
  (on_pallet crate7 pallet4)
  (on_crate crate8 crate39)
  (on_pallet crate9 pallet19)
  (on_pallet crate10 pallet12)
  (on_pallet crate12 pallet20)
  (on_pallet crate13 pallet17)
  (on_pallet crate14 pallet10)
  (on_crate crate15 crate28)
  (on_pallet crate16 pallet18)
  (on_pallet crate17 pallet1)
  (on_pallet crate18 pallet11)
  (on_pallet crate19 pallet0)
  (on_crate crate20 crate31)
  (on_pallet crate23 pallet27)
  (on_pallet crate24 pallet3)
  (on_pallet crate25 pallet8)
  (on_pallet crate27 pallet16)
  (on_crate crate28 crate38)
  (on_crate crate29 crate3)
  (on_pallet crate31 pallet26)
  (on_crate crate33 crate40)
  (on_crate crate34 crate35)
  (on_crate crate35 crate8)
  (on_crate crate36 crate17)
  (on_pallet crate37 pallet2)
  (on_crate crate38 crate7)
  (on_pallet crate39 pallet25)
  (on_crate crate40 crate12)
  (on_pallet crate41 pallet7)
  (on_pallet crate42 pallet5)
  (on_pallet crate43 pallet24)
  (on_pallet crate44 pallet22)
  (on_crate crate45 crate37)))
)
