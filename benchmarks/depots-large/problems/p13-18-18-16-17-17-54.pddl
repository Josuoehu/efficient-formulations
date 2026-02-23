(define (problem depotprob13)
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
  depot17 - DEPOT
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
  distributor17 - DISTRIBUTOR
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
  truck15 - TRUCK
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
  pallet34 - PALLET
  pallet35 - PALLET
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
  crate52 - CRATE
  crate53 - CRATE
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
  hoist34 - HOIST
  hoist35 - HOIST
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_crate crate21)
  (at_pallet_depot pallet1 depot1)
  (clear_crate crate47)
  (at_pallet_depot pallet2 depot2)
  (clear_crate crate15)
  (at_pallet_depot pallet3 depot3)
  (clear_pallet pallet3)
  (at_pallet_depot pallet4 depot4)
  (clear_crate crate38)
  (at_pallet_depot pallet5 depot5)
  (clear_pallet pallet5)
  (at_pallet_depot pallet6 depot6)
  (clear_crate crate2)
  (at_pallet_depot pallet7 depot7)
  (clear_crate crate44)
  (at_pallet_depot pallet8 depot8)
  (clear_crate crate42)
  (at_pallet_depot pallet9 depot9)
  (clear_crate crate46)
  (at_pallet_depot pallet10 depot10)
  (clear_crate crate52)
  (at_pallet_depot pallet11 depot11)
  (clear_crate crate25)
  (at_pallet_depot pallet12 depot12)
  (clear_pallet pallet12)
  (at_pallet_depot pallet13 depot13)
  (clear_pallet pallet13)
  (at_pallet_depot pallet14 depot14)
  (clear_pallet pallet14)
  (at_pallet_depot pallet15 depot15)
  (clear_crate crate36)
  (at_pallet_depot pallet16 depot16)
  (clear_crate crate37)
  (at_pallet_depot pallet17 depot17)
  (clear_crate crate51)
  (at_pallet_distributor pallet18 distributor0)
  (clear_crate crate1)
  (at_pallet_distributor pallet19 distributor1)
  (clear_pallet pallet19)
  (at_pallet_distributor pallet20 distributor2)
  (clear_crate crate50)
  (at_pallet_distributor pallet21 distributor3)
  (clear_crate crate26)
  (at_pallet_distributor pallet22 distributor4)
  (clear_crate crate40)
  (at_pallet_distributor pallet23 distributor5)
  (clear_crate crate53)
  (at_pallet_distributor pallet24 distributor6)
  (clear_pallet pallet24)
  (at_pallet_distributor pallet25 distributor7)
  (clear_crate crate49)
  (at_pallet_distributor pallet26 distributor8)
  (clear_pallet pallet26)
  (at_pallet_distributor pallet27 distributor9)
  (clear_crate crate48)
  (at_pallet_distributor pallet28 distributor10)
  (clear_crate crate35)
  (at_pallet_distributor pallet29 distributor11)
  (clear_pallet pallet29)
  (at_pallet_distributor pallet30 distributor12)
  (clear_crate crate28)
  (at_pallet_distributor pallet31 distributor13)
  (clear_pallet pallet31)
  (at_pallet_distributor pallet32 distributor14)
  (clear_crate crate12)
  (at_pallet_distributor pallet33 distributor15)
  (clear_crate crate32)
  (at_pallet_distributor pallet34 distributor16)
  (clear_crate crate16)
  (at_pallet_distributor pallet35 distributor17)
  (clear_pallet pallet35)
  (at_truck_distributor truck0 distributor14)
  (at_truck_distributor truck1 distributor12)
  (at_truck_distributor truck2 distributor14)
  (at_truck_depot truck3 depot9)
  (at_truck_depot truck4 depot4)
  (at_truck_distributor truck5 distributor0)
  (at_truck_depot truck6 depot4)
  (at_truck_distributor truck7 distributor14)
  (at_truck_depot truck8 depot16)
  (at_truck_depot truck9 depot2)
  (at_truck_distributor truck10 distributor12)
  (at_truck_distributor truck11 distributor16)
  (at_truck_distributor truck12 distributor7)
  (at_truck_distributor truck13 distributor2)
  (at_truck_depot truck14 depot17)
  (at_truck_depot truck15 depot0)
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
  (at_hoist_depot hoist17 depot17)
  (available hoist17)
  (at_hoist_distributor hoist18 distributor0)
  (available hoist18)
  (at_hoist_distributor hoist19 distributor1)
  (available hoist19)
  (at_hoist_distributor hoist20 distributor2)
  (available hoist20)
  (at_hoist_distributor hoist21 distributor3)
  (available hoist21)
  (at_hoist_distributor hoist22 distributor4)
  (available hoist22)
  (at_hoist_distributor hoist23 distributor5)
  (available hoist23)
  (at_hoist_distributor hoist24 distributor6)
  (available hoist24)
  (at_hoist_distributor hoist25 distributor7)
  (available hoist25)
  (at_hoist_distributor hoist26 distributor8)
  (available hoist26)
  (at_hoist_distributor hoist27 distributor9)
  (available hoist27)
  (at_hoist_distributor hoist28 distributor10)
  (available hoist28)
  (at_hoist_distributor hoist29 distributor11)
  (available hoist29)
  (at_hoist_distributor hoist30 distributor12)
  (available hoist30)
  (at_hoist_distributor hoist31 distributor13)
  (available hoist31)
  (at_hoist_distributor hoist32 distributor14)
  (available hoist32)
  (at_hoist_distributor hoist33 distributor15)
  (available hoist33)
  (at_hoist_distributor hoist34 distributor16)
  (available hoist34)
  (at_hoist_distributor hoist35 distributor17)
  (available hoist35)
  (at_crate_distributor crate0 distributor3)
  (on_pallet crate0 pallet21)
  (at_crate_distributor crate1 distributor0)
  (on_pallet crate1 pallet18)
  (at_crate_depot crate2 depot6)
  (on_pallet crate2 pallet6)
  (at_crate_distributor crate3 distributor14)
  (on_pallet crate3 pallet32)
  (at_crate_distributor crate4 distributor7)
  (on_pallet crate4 pallet25)
  (at_crate_depot crate5 depot17)
  (on_pallet crate5 pallet17)
  (at_crate_depot crate6 depot15)
  (on_pallet crate6 pallet15)
  (at_crate_depot crate7 depot10)
  (on_pallet crate7 pallet10)
  (at_crate_depot crate8 depot15)
  (on_crate crate8 crate6)
  (at_crate_depot crate9 depot10)
  (on_crate crate9 crate7)
  (at_crate_distributor crate10 distributor10)
  (on_pallet crate10 pallet28)
  (at_crate_depot crate11 depot11)
  (on_pallet crate11 pallet11)
  (at_crate_distributor crate12 distributor14)
  (on_crate crate12 crate3)
  (at_crate_depot crate13 depot2)
  (on_pallet crate13 pallet2)
  (at_crate_distributor crate14 distributor4)
  (on_pallet crate14 pallet22)
  (at_crate_depot crate15 depot2)
  (on_crate crate15 crate13)
  (at_crate_distributor crate16 distributor16)
  (on_pallet crate16 pallet34)
  (at_crate_distributor crate17 distributor9)
  (on_pallet crate17 pallet27)
  (at_crate_distributor crate18 distributor3)
  (on_crate crate18 crate0)
  (at_crate_depot crate19 depot16)
  (on_pallet crate19 pallet16)
  (at_crate_depot crate20 depot16)
  (on_crate crate20 crate19)
  (at_crate_depot crate21 depot0)
  (on_pallet crate21 pallet0)
  (at_crate_depot crate22 depot7)
  (on_pallet crate22 pallet7)
  (at_crate_depot crate23 depot15)
  (on_crate crate23 crate8)
  (at_crate_distributor crate24 distributor5)
  (on_pallet crate24 pallet23)
  (at_crate_depot crate25 depot11)
  (on_crate crate25 crate11)
  (at_crate_distributor crate26 distributor3)
  (on_crate crate26 crate18)
  (at_crate_depot crate27 depot15)
  (on_crate crate27 crate23)
  (at_crate_distributor crate28 distributor12)
  (on_pallet crate28 pallet30)
  (at_crate_depot crate29 depot8)
  (on_pallet crate29 pallet8)
  (at_crate_distributor crate30 distributor15)
  (on_pallet crate30 pallet33)
  (at_crate_distributor crate31 distributor7)
  (on_crate crate31 crate4)
  (at_crate_distributor crate32 distributor15)
  (on_crate crate32 crate30)
  (at_crate_depot crate33 depot1)
  (on_pallet crate33 pallet1)
  (at_crate_depot crate34 depot4)
  (on_pallet crate34 pallet4)
  (at_crate_distributor crate35 distributor10)
  (on_crate crate35 crate10)
  (at_crate_depot crate36 depot15)
  (on_crate crate36 crate27)
  (at_crate_depot crate37 depot16)
  (on_crate crate37 crate20)
  (at_crate_depot crate38 depot4)
  (on_crate crate38 crate34)
  (at_crate_depot crate39 depot10)
  (on_crate crate39 crate9)
  (at_crate_distributor crate40 distributor4)
  (on_crate crate40 crate14)
  (at_crate_depot crate41 depot9)
  (on_pallet crate41 pallet9)
  (at_crate_depot crate42 depot8)
  (on_crate crate42 crate29)
  (at_crate_distributor crate43 distributor7)
  (on_crate crate43 crate31)
  (at_crate_depot crate44 depot7)
  (on_crate crate44 crate22)
  (at_crate_distributor crate45 distributor2)
  (on_pallet crate45 pallet20)
  (at_crate_depot crate46 depot9)
  (on_crate crate46 crate41)
  (at_crate_depot crate47 depot1)
  (on_crate crate47 crate33)
  (at_crate_distributor crate48 distributor9)
  (on_crate crate48 crate17)
  (at_crate_distributor crate49 distributor7)
  (on_crate crate49 crate43)
  (at_crate_distributor crate50 distributor2)
  (on_crate crate50 crate45)
  (at_crate_depot crate51 depot17)
  (on_crate crate51 crate5)
  (at_crate_depot crate52 depot10)
  (on_crate crate52 crate39)
  (at_crate_distributor crate53 distributor5)
  (on_crate crate53 crate24)
)
(:goal   (and (on_pallet crate0 pallet29)
  (on_pallet crate1 pallet35)
  (on_pallet crate3 pallet26)
  (on_pallet crate4 pallet21)
  (on_pallet crate5 pallet11)
  (on_crate crate6 crate18)
  (on_crate crate7 crate51)
  (on_pallet crate8 pallet14)
  (on_pallet crate9 pallet33)
  (on_pallet crate11 pallet10)
  (on_crate crate13 crate43)
  (on_pallet crate15 pallet24)
  (on_pallet crate16 pallet15)
  (on_crate crate17 crate35)
  (on_crate crate18 crate50)
  (on_crate crate19 crate8)
  (on_pallet crate20 pallet28)
  (on_crate crate21 crate7)
  (on_crate crate22 crate36)
  (on_pallet crate23 pallet30)
  (on_pallet crate24 pallet5)
  (on_pallet crate25 pallet18)
  (on_pallet crate26 pallet22)
  (on_pallet crate28 pallet8)
  (on_crate crate29 crate47)
  (on_pallet crate30 pallet9)
  (on_crate crate31 crate15)
  (on_crate crate33 crate25)
  (on_crate crate34 crate29)
  (on_pallet crate35 pallet1)
  (on_pallet crate36 pallet27)
  (on_pallet crate37 pallet19)
  (on_crate crate38 crate19)
  (on_crate crate39 crate26)
  (on_pallet crate40 pallet12)
  (on_pallet crate41 pallet31)
  (on_pallet crate43 pallet34)
  (on_pallet crate44 pallet16)
  (on_pallet crate45 pallet13)
  (on_crate crate46 crate28)
  (on_crate crate47 crate17)
  (on_crate crate48 crate22)
  (on_crate crate49 crate37)
  (on_pallet crate50 pallet7)
  (on_crate crate51 crate33)
  (on_pallet crate52 pallet17)
  (on_crate crate53 crate21)))
)
