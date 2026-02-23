(define (problem depotprob12)
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
  depot15 - DEPOT
  depot16 - DEPOT
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
  distributor15 - DISTRIBUTOR
  distributor16 - DISTRIBUTOR
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
  truck13 - TRUCK
  truck14 - TRUCK
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
  pallet30 - PALLET
  pallet31 - PALLET
  pallet32 - PALLET
  pallet33 - PALLET
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
  crate46 - CRATE
  crate47 - CRATE
  crate48 - CRATE
  crate49 - CRATE
  crate50 - CRATE
  crate51 - CRATE
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
  hoist30 - HOIST
  hoist31 - HOIST
  hoist32 - HOIST
  hoist33 - HOIST
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_pallet pallet0)
  (at_pallet_depot pallet1 depot1)
  (clear_crate crate11)
  (at_pallet_depot pallet2 depot2)
  (clear_pallet pallet2)
  (at_pallet_depot pallet3 depot3)
  (clear_pallet pallet3)
  (at_pallet_depot pallet4 depot4)
  (clear_pallet pallet4)
  (at_pallet_depot pallet5 depot5)
  (clear_crate crate22)
  (at_pallet_depot pallet6 depot6)
  (clear_pallet pallet6)
  (at_pallet_depot pallet7 depot7)
  (clear_crate crate42)
  (at_pallet_depot pallet8 depot8)
  (clear_crate crate37)
  (at_pallet_depot pallet9 depot9)
  (clear_crate crate32)
  (at_pallet_depot pallet10 depot10)
  (clear_pallet pallet10)
  (at_pallet_depot pallet11 depot11)
  (clear_crate crate50)
  (at_pallet_depot pallet12 depot12)
  (clear_crate crate16)
  (at_pallet_depot pallet13 depot13)
  (clear_pallet pallet13)
  (at_pallet_depot pallet14 depot14)
  (clear_pallet pallet14)
  (at_pallet_depot pallet15 depot15)
  (clear_crate crate7)
  (at_pallet_depot pallet16 depot16)
  (clear_crate crate15)
  (at_pallet_distributor pallet17 distributor0)
  (clear_crate crate18)
  (at_pallet_distributor pallet18 distributor1)
  (clear_crate crate46)
  (at_pallet_distributor pallet19 distributor2)
  (clear_crate crate47)
  (at_pallet_distributor pallet20 distributor3)
  (clear_crate crate36)
  (at_pallet_distributor pallet21 distributor4)
  (clear_crate crate49)
  (at_pallet_distributor pallet22 distributor5)
  (clear_crate crate29)
  (at_pallet_distributor pallet23 distributor6)
  (clear_pallet pallet23)
  (at_pallet_distributor pallet24 distributor7)
  (clear_crate crate23)
  (at_pallet_distributor pallet25 distributor8)
  (clear_crate crate43)
  (at_pallet_distributor pallet26 distributor9)
  (clear_crate crate44)
  (at_pallet_distributor pallet27 distributor10)
  (clear_crate crate26)
  (at_pallet_distributor pallet28 distributor11)
  (clear_crate crate48)
  (at_pallet_distributor pallet29 distributor12)
  (clear_pallet pallet29)
  (at_pallet_distributor pallet30 distributor13)
  (clear_crate crate28)
  (at_pallet_distributor pallet31 distributor14)
  (clear_pallet pallet31)
  (at_pallet_distributor pallet32 distributor15)
  (clear_pallet pallet32)
  (at_pallet_distributor pallet33 distributor16)
  (clear_crate crate51)
  (at_truck_depot truck0 depot13)
  (at_truck_distributor truck1 distributor10)
  (at_truck_depot truck2 depot6)
  (at_truck_distributor truck3 distributor0)
  (at_truck_distributor truck4 distributor7)
  (at_truck_depot truck5 depot3)
  (at_truck_distributor truck6 distributor14)
  (at_truck_distributor truck7 distributor11)
  (at_truck_depot truck8 depot6)
  (at_truck_depot truck9 depot4)
  (at_truck_distributor truck10 distributor7)
  (at_truck_distributor truck11 distributor3)
  (at_truck_distributor truck12 distributor3)
  (at_truck_distributor truck13 distributor16)
  (at_truck_distributor truck14 distributor8)
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
  (at_hoist_depot hoist15 depot15)
  (available hoist15)
  (at_hoist_depot hoist16 depot16)
  (available hoist16)
  (at_hoist_distributor hoist17 distributor0)
  (available hoist17)
  (at_hoist_distributor hoist18 distributor1)
  (available hoist18)
  (at_hoist_distributor hoist19 distributor2)
  (available hoist19)
  (at_hoist_distributor hoist20 distributor3)
  (available hoist20)
  (at_hoist_distributor hoist21 distributor4)
  (available hoist21)
  (at_hoist_distributor hoist22 distributor5)
  (available hoist22)
  (at_hoist_distributor hoist23 distributor6)
  (available hoist23)
  (at_hoist_distributor hoist24 distributor7)
  (available hoist24)
  (at_hoist_distributor hoist25 distributor8)
  (available hoist25)
  (at_hoist_distributor hoist26 distributor9)
  (available hoist26)
  (at_hoist_distributor hoist27 distributor10)
  (available hoist27)
  (at_hoist_distributor hoist28 distributor11)
  (available hoist28)
  (at_hoist_distributor hoist29 distributor12)
  (available hoist29)
  (at_hoist_distributor hoist30 distributor13)
  (available hoist30)
  (at_hoist_distributor hoist31 distributor14)
  (available hoist31)
  (at_hoist_distributor hoist32 distributor15)
  (available hoist32)
  (at_hoist_distributor hoist33 distributor16)
  (available hoist33)
  (at_crate_distributor crate0 distributor7)
  (on_pallet crate0 pallet24)
  (at_crate_distributor crate1 distributor5)
  (on_pallet crate1 pallet22)
  (at_crate_distributor crate2 distributor10)
  (on_pallet crate2 pallet27)
  (at_crate_distributor crate3 distributor13)
  (on_pallet crate3 pallet30)
  (at_crate_depot crate4 depot7)
  (on_pallet crate4 pallet7)
  (at_crate_depot crate5 depot11)
  (on_pallet crate5 pallet11)
  (at_crate_distributor crate6 distributor4)
  (on_pallet crate6 pallet21)
  (at_crate_depot crate7 depot15)
  (on_pallet crate7 pallet15)
  (at_crate_distributor crate8 distributor7)
  (on_crate crate8 crate0)
  (at_crate_distributor crate9 distributor11)
  (on_pallet crate9 pallet28)
  (at_crate_depot crate10 depot9)
  (on_pallet crate10 pallet9)
  (at_crate_depot crate11 depot1)
  (on_pallet crate11 pallet1)
  (at_crate_distributor crate12 distributor3)
  (on_pallet crate12 pallet20)
  (at_crate_distributor crate13 distributor9)
  (on_pallet crate13 pallet26)
  (at_crate_distributor crate14 distributor2)
  (on_pallet crate14 pallet19)
  (at_crate_depot crate15 depot16)
  (on_pallet crate15 pallet16)
  (at_crate_depot crate16 depot12)
  (on_pallet crate16 pallet12)
  (at_crate_distributor crate17 distributor9)
  (on_crate crate17 crate13)
  (at_crate_distributor crate18 distributor0)
  (on_pallet crate18 pallet17)
  (at_crate_depot crate19 depot8)
  (on_pallet crate19 pallet8)
  (at_crate_distributor crate20 distributor7)
  (on_crate crate20 crate8)
  (at_crate_distributor crate21 distributor13)
  (on_crate crate21 crate3)
  (at_crate_depot crate22 depot5)
  (on_pallet crate22 pallet5)
  (at_crate_distributor crate23 distributor7)
  (on_crate crate23 crate20)
  (at_crate_distributor crate24 distributor2)
  (on_crate crate24 crate14)
  (at_crate_depot crate25 depot9)
  (on_crate crate25 crate10)
  (at_crate_distributor crate26 distributor10)
  (on_crate crate26 crate2)
  (at_crate_distributor crate27 distributor13)
  (on_crate crate27 crate21)
  (at_crate_distributor crate28 distributor13)
  (on_crate crate28 crate27)
  (at_crate_distributor crate29 distributor5)
  (on_crate crate29 crate1)
  (at_crate_depot crate30 depot7)
  (on_crate crate30 crate4)
  (at_crate_distributor crate31 distributor8)
  (on_pallet crate31 pallet25)
  (at_crate_depot crate32 depot9)
  (on_crate crate32 crate25)
  (at_crate_distributor crate33 distributor8)
  (on_crate crate33 crate31)
  (at_crate_depot crate34 depot7)
  (on_crate crate34 crate30)
  (at_crate_distributor crate35 distributor1)
  (on_pallet crate35 pallet18)
  (at_crate_distributor crate36 distributor3)
  (on_crate crate36 crate12)
  (at_crate_depot crate37 depot8)
  (on_crate crate37 crate19)
  (at_crate_distributor crate38 distributor9)
  (on_crate crate38 crate17)
  (at_crate_distributor crate39 distributor4)
  (on_crate crate39 crate6)
  (at_crate_distributor crate40 distributor1)
  (on_crate crate40 crate35)
  (at_crate_depot crate41 depot7)
  (on_crate crate41 crate34)
  (at_crate_depot crate42 depot7)
  (on_crate crate42 crate41)
  (at_crate_distributor crate43 distributor8)
  (on_crate crate43 crate33)
  (at_crate_distributor crate44 distributor9)
  (on_crate crate44 crate38)
  (at_crate_distributor crate45 distributor2)
  (on_crate crate45 crate24)
  (at_crate_distributor crate46 distributor1)
  (on_crate crate46 crate40)
  (at_crate_distributor crate47 distributor2)
  (on_crate crate47 crate45)
  (at_crate_distributor crate48 distributor11)
  (on_crate crate48 crate9)
  (at_crate_distributor crate49 distributor4)
  (on_crate crate49 crate39)
  (at_crate_depot crate50 depot11)
  (on_crate crate50 crate5)
  (at_crate_distributor crate51 distributor16)
  (on_pallet crate51 pallet33)
)
(:goal   (and (on_pallet crate0 pallet3)
  (on_crate crate1 crate0)
  (on_pallet crate2 pallet18)
  (on_crate crate3 crate20)
  (on_pallet crate4 pallet17)
  (on_pallet crate6 pallet8)
  (on_pallet crate9 pallet14)
  (on_crate crate10 crate14)
  (on_pallet crate11 pallet23)
  (on_pallet crate12 pallet12)
  (on_pallet crate13 pallet5)
  (on_pallet crate14 pallet29)
  (on_pallet crate15 pallet28)
  (on_pallet crate16 pallet26)
  (on_crate crate17 crate23)
  (on_crate crate19 crate9)
  (on_pallet crate20 pallet10)
  (on_pallet crate21 pallet6)
  (on_pallet crate22 pallet30)
  (on_pallet crate23 pallet4)
  (on_crate crate24 crate47)
  (on_crate crate25 crate12)
  (on_pallet crate26 pallet20)
  (on_crate crate27 crate34)
  (on_pallet crate28 pallet24)
  (on_pallet crate29 pallet27)
  (on_crate crate31 crate3)
  (on_pallet crate32 pallet0)
  (on_crate crate33 crate25)
  (on_crate crate34 crate2)
  (on_crate crate35 crate17)
  (on_crate crate36 crate31)
  (on_pallet crate37 pallet11)
  (on_pallet crate38 pallet7)
  (on_crate crate39 crate19)
  (on_crate crate40 crate42)
  (on_pallet crate41 pallet15)
  (on_crate crate42 crate41)
  (on_pallet crate43 pallet19)
  (on_crate crate44 crate26)
  (on_pallet crate45 pallet32)
  (on_crate crate46 crate22)
  (on_crate crate47 crate16)
  (on_pallet crate48 pallet21)
  (on_crate crate49 crate6)
  (on_pallet crate50 pallet22)
  (on_pallet crate51 pallet25)))
)
