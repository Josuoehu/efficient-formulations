(define (problem depotprob11)
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
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_crate crate48)
  (at_pallet_depot pallet1 depot1)
  (clear_crate crate14)
  (at_pallet_depot pallet2 depot2)
  (clear_crate crate36)
  (at_pallet_depot pallet3 depot3)
  (clear_pallet pallet3)
  (at_pallet_depot pallet4 depot4)
  (clear_crate crate10)
  (at_pallet_depot pallet5 depot5)
  (clear_crate crate49)
  (at_pallet_depot pallet6 depot6)
  (clear_crate crate45)
  (at_pallet_depot pallet7 depot7)
  (clear_crate crate42)
  (at_pallet_depot pallet8 depot8)
  (clear_crate crate44)
  (at_pallet_depot pallet9 depot9)
  (clear_crate crate15)
  (at_pallet_depot pallet10 depot10)
  (clear_crate crate6)
  (at_pallet_depot pallet11 depot11)
  (clear_crate crate40)
  (at_pallet_depot pallet12 depot12)
  (clear_crate crate38)
  (at_pallet_depot pallet13 depot13)
  (clear_crate crate35)
  (at_pallet_depot pallet14 depot14)
  (clear_crate crate28)
  (at_pallet_depot pallet15 depot15)
  (clear_crate crate13)
  (at_pallet_distributor pallet16 distributor0)
  (clear_crate crate37)
  (at_pallet_distributor pallet17 distributor1)
  (clear_crate crate32)
  (at_pallet_distributor pallet18 distributor2)
  (clear_crate crate47)
  (at_pallet_distributor pallet19 distributor3)
  (clear_crate crate24)
  (at_pallet_distributor pallet20 distributor4)
  (clear_crate crate25)
  (at_pallet_distributor pallet21 distributor5)
  (clear_crate crate46)
  (at_pallet_distributor pallet22 distributor6)
  (clear_crate crate30)
  (at_pallet_distributor pallet23 distributor7)
  (clear_crate crate43)
  (at_pallet_distributor pallet24 distributor8)
  (clear_crate crate21)
  (at_pallet_distributor pallet25 distributor9)
  (clear_crate crate31)
  (at_pallet_distributor pallet26 distributor10)
  (clear_crate crate29)
  (at_pallet_distributor pallet27 distributor11)
  (clear_crate crate33)
  (at_pallet_distributor pallet28 distributor12)
  (clear_crate crate16)
  (at_pallet_distributor pallet29 distributor13)
  (clear_pallet pallet29)
  (at_pallet_distributor pallet30 distributor14)
  (clear_pallet pallet30)
  (at_pallet_distributor pallet31 distributor15)
  (clear_crate crate9)
  (at_truck_distributor truck0 distributor0)
  (at_truck_distributor truck1 distributor9)
  (at_truck_depot truck2 depot9)
  (at_truck_depot truck3 depot4)
  (at_truck_distributor truck4 distributor12)
  (at_truck_depot truck5 depot12)
  (at_truck_depot truck6 depot3)
  (at_truck_distributor truck7 distributor0)
  (at_truck_distributor truck8 distributor13)
  (at_truck_distributor truck9 distributor7)
  (at_truck_distributor truck10 distributor10)
  (at_truck_depot truck11 depot2)
  (at_truck_distributor truck12 distributor2)
  (at_truck_distributor truck13 distributor0)
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
  (at_hoist_distributor hoist16 distributor0)
  (available hoist16)
  (at_hoist_distributor hoist17 distributor1)
  (available hoist17)
  (at_hoist_distributor hoist18 distributor2)
  (available hoist18)
  (at_hoist_distributor hoist19 distributor3)
  (available hoist19)
  (at_hoist_distributor hoist20 distributor4)
  (available hoist20)
  (at_hoist_distributor hoist21 distributor5)
  (available hoist21)
  (at_hoist_distributor hoist22 distributor6)
  (available hoist22)
  (at_hoist_distributor hoist23 distributor7)
  (available hoist23)
  (at_hoist_distributor hoist24 distributor8)
  (available hoist24)
  (at_hoist_distributor hoist25 distributor9)
  (available hoist25)
  (at_hoist_distributor hoist26 distributor10)
  (available hoist26)
  (at_hoist_distributor hoist27 distributor11)
  (available hoist27)
  (at_hoist_distributor hoist28 distributor12)
  (available hoist28)
  (at_hoist_distributor hoist29 distributor13)
  (available hoist29)
  (at_hoist_distributor hoist30 distributor14)
  (available hoist30)
  (at_hoist_distributor hoist31 distributor15)
  (available hoist31)
  (at_crate_depot crate0 depot7)
  (on_pallet crate0 pallet7)
  (at_crate_depot crate1 depot4)
  (on_pallet crate1 pallet4)
  (at_crate_depot crate2 depot12)
  (on_pallet crate2 pallet12)
  (at_crate_depot crate3 depot5)
  (on_pallet crate3 pallet5)
  (at_crate_depot crate4 depot2)
  (on_pallet crate4 pallet2)
  (at_crate_depot crate5 depot14)
  (on_pallet crate5 pallet14)
  (at_crate_depot crate6 depot10)
  (on_pallet crate6 pallet10)
  (at_crate_depot crate7 depot13)
  (on_pallet crate7 pallet13)
  (at_crate_distributor crate8 distributor10)
  (on_pallet crate8 pallet26)
  (at_crate_distributor crate9 distributor15)
  (on_pallet crate9 pallet31)
  (at_crate_depot crate10 depot4)
  (on_crate crate10 crate1)
  (at_crate_distributor crate11 distributor7)
  (on_pallet crate11 pallet23)
  (at_crate_distributor crate12 distributor8)
  (on_pallet crate12 pallet24)
  (at_crate_depot crate13 depot15)
  (on_pallet crate13 pallet15)
  (at_crate_depot crate14 depot1)
  (on_pallet crate14 pallet1)
  (at_crate_depot crate15 depot9)
  (on_pallet crate15 pallet9)
  (at_crate_distributor crate16 distributor12)
  (on_pallet crate16 pallet28)
  (at_crate_depot crate17 depot7)
  (on_crate crate17 crate0)
  (at_crate_depot crate18 depot12)
  (on_crate crate18 crate2)
  (at_crate_depot crate19 depot12)
  (on_crate crate19 crate18)
  (at_crate_depot crate20 depot12)
  (on_crate crate20 crate19)
  (at_crate_distributor crate21 distributor8)
  (on_crate crate21 crate12)
  (at_crate_depot crate22 depot5)
  (on_crate crate22 crate3)
  (at_crate_depot crate23 depot14)
  (on_crate crate23 crate5)
  (at_crate_distributor crate24 distributor3)
  (on_pallet crate24 pallet19)
  (at_crate_distributor crate25 distributor4)
  (on_pallet crate25 pallet20)
  (at_crate_distributor crate26 distributor9)
  (on_pallet crate26 pallet25)
  (at_crate_depot crate27 depot0)
  (on_pallet crate27 pallet0)
  (at_crate_depot crate28 depot14)
  (on_crate crate28 crate23)
  (at_crate_distributor crate29 distributor10)
  (on_crate crate29 crate8)
  (at_crate_distributor crate30 distributor6)
  (on_pallet crate30 pallet22)
  (at_crate_distributor crate31 distributor9)
  (on_crate crate31 crate26)
  (at_crate_distributor crate32 distributor1)
  (on_pallet crate32 pallet17)
  (at_crate_distributor crate33 distributor11)
  (on_pallet crate33 pallet27)
  (at_crate_depot crate34 depot12)
  (on_crate crate34 crate20)
  (at_crate_depot crate35 depot13)
  (on_crate crate35 crate7)
  (at_crate_depot crate36 depot2)
  (on_crate crate36 crate4)
  (at_crate_distributor crate37 distributor0)
  (on_pallet crate37 pallet16)
  (at_crate_depot crate38 depot12)
  (on_crate crate38 crate34)
  (at_crate_depot crate39 depot7)
  (on_crate crate39 crate17)
  (at_crate_depot crate40 depot11)
  (on_pallet crate40 pallet11)
  (at_crate_distributor crate41 distributor7)
  (on_crate crate41 crate11)
  (at_crate_depot crate42 depot7)
  (on_crate crate42 crate39)
  (at_crate_distributor crate43 distributor7)
  (on_crate crate43 crate41)
  (at_crate_depot crate44 depot8)
  (on_pallet crate44 pallet8)
  (at_crate_depot crate45 depot6)
  (on_pallet crate45 pallet6)
  (at_crate_distributor crate46 distributor5)
  (on_pallet crate46 pallet21)
  (at_crate_distributor crate47 distributor2)
  (on_pallet crate47 pallet18)
  (at_crate_depot crate48 depot0)
  (on_crate crate48 crate27)
  (at_crate_depot crate49 depot5)
  (on_crate crate49 crate22)
)
(:goal   (and (on_crate crate0 crate44)
  (on_crate crate1 crate10)
  (on_pallet crate2 pallet5)
  (on_pallet crate3 pallet10)
  (on_crate crate4 crate12)
  (on_pallet crate5 pallet27)
  (on_pallet crate6 pallet30)
  (on_pallet crate7 pallet21)
  (on_crate crate8 crate18)
  (on_pallet crate9 pallet0)
  (on_pallet crate10 pallet25)
  (on_crate crate11 crate39)
  (on_crate crate12 crate34)
  (on_pallet crate13 pallet12)
  (on_pallet crate14 pallet4)
  (on_pallet crate15 pallet28)
  (on_crate crate16 crate6)
  (on_pallet crate18 pallet9)
  (on_pallet crate19 pallet19)
  (on_crate crate20 crate23)
  (on_pallet crate21 pallet22)
  (on_crate crate22 crate37)
  (on_crate crate23 crate40)
  (on_pallet crate24 pallet8)
  (on_crate crate25 crate13)
  (on_pallet crate26 pallet23)
  (on_crate crate27 crate28)
  (on_crate crate28 crate47)
  (on_pallet crate29 pallet7)
  (on_crate crate30 crate41)
  (on_pallet crate31 pallet3)
  (on_crate crate32 crate43)
  (on_pallet crate33 pallet11)
  (on_pallet crate34 pallet17)
  (on_crate crate35 crate33)
  (on_pallet crate36 pallet1)
  (on_crate crate37 crate38)
  (on_pallet crate38 pallet14)
  (on_pallet crate39 pallet24)
  (on_crate crate40 crate14)
  (on_crate crate41 crate2)
  (on_pallet crate42 pallet13)
  (on_pallet crate43 pallet6)
  (on_crate crate44 crate7)
  (on_pallet crate47 pallet2)
  (on_crate crate49 crate15)))
)
