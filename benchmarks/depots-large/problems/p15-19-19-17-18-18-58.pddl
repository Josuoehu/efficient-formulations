(define (problem depotprob15)
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
  depot18 - DEPOT
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
  distributor18 - DISTRIBUTOR
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
  truck16 - TRUCK
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
  pallet36 - PALLET
  pallet37 - PALLET
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
  crate54 - CRATE
  crate55 - CRATE
  crate56 - CRATE
  crate57 - CRATE
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
  hoist36 - HOIST
  hoist37 - HOIST
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_crate crate13)
  (at_pallet_depot pallet1 depot1)
  (clear_crate crate9)
  (at_pallet_depot pallet2 depot2)
  (clear_crate crate36)
  (at_pallet_depot pallet3 depot3)
  (clear_pallet pallet3)
  (at_pallet_depot pallet4 depot4)
  (clear_crate crate46)
  (at_pallet_depot pallet5 depot5)
  (clear_pallet pallet5)
  (at_pallet_depot pallet6 depot6)
  (clear_crate crate32)
  (at_pallet_depot pallet7 depot7)
  (clear_pallet pallet7)
  (at_pallet_depot pallet8 depot8)
  (clear_pallet pallet8)
  (at_pallet_depot pallet9 depot9)
  (clear_crate crate4)
  (at_pallet_depot pallet10 depot10)
  (clear_pallet pallet10)
  (at_pallet_depot pallet11 depot11)
  (clear_crate crate38)
  (at_pallet_depot pallet12 depot12)
  (clear_crate crate45)
  (at_pallet_depot pallet13 depot13)
  (clear_pallet pallet13)
  (at_pallet_depot pallet14 depot14)
  (clear_pallet pallet14)
  (at_pallet_depot pallet15 depot15)
  (clear_pallet pallet15)
  (at_pallet_depot pallet16 depot16)
  (clear_crate crate40)
  (at_pallet_depot pallet17 depot17)
  (clear_crate crate52)
  (at_pallet_depot pallet18 depot18)
  (clear_crate crate12)
  (at_pallet_distributor pallet19 distributor0)
  (clear_crate crate18)
  (at_pallet_distributor pallet20 distributor1)
  (clear_crate crate33)
  (at_pallet_distributor pallet21 distributor2)
  (clear_crate crate43)
  (at_pallet_distributor pallet22 distributor3)
  (clear_crate crate57)
  (at_pallet_distributor pallet23 distributor4)
  (clear_crate crate48)
  (at_pallet_distributor pallet24 distributor5)
  (clear_pallet pallet24)
  (at_pallet_distributor pallet25 distributor6)
  (clear_crate crate11)
  (at_pallet_distributor pallet26 distributor7)
  (clear_pallet pallet26)
  (at_pallet_distributor pallet27 distributor8)
  (clear_crate crate37)
  (at_pallet_distributor pallet28 distributor9)
  (clear_crate crate50)
  (at_pallet_distributor pallet29 distributor10)
  (clear_crate crate8)
  (at_pallet_distributor pallet30 distributor11)
  (clear_crate crate20)
  (at_pallet_distributor pallet31 distributor12)
  (clear_crate crate26)
  (at_pallet_distributor pallet32 distributor13)
  (clear_crate crate31)
  (at_pallet_distributor pallet33 distributor14)
  (clear_crate crate54)
  (at_pallet_distributor pallet34 distributor15)
  (clear_crate crate55)
  (at_pallet_distributor pallet35 distributor16)
  (clear_crate crate41)
  (at_pallet_distributor pallet36 distributor17)
  (clear_crate crate56)
  (at_pallet_distributor pallet37 distributor18)
  (clear_crate crate49)
  (at_truck_distributor truck0 distributor10)
  (at_truck_distributor truck1 distributor4)
  (at_truck_depot truck2 depot4)
  (at_truck_depot truck3 depot9)
  (at_truck_distributor truck4 distributor2)
  (at_truck_depot truck5 depot18)
  (at_truck_distributor truck6 distributor13)
  (at_truck_distributor truck7 distributor18)
  (at_truck_depot truck8 depot13)
  (at_truck_depot truck9 depot12)
  (at_truck_distributor truck10 distributor1)
  (at_truck_distributor truck11 distributor14)
  (at_truck_depot truck12 depot4)
  (at_truck_distributor truck13 distributor1)
  (at_truck_depot truck14 depot6)
  (at_truck_depot truck15 depot4)
  (at_truck_depot truck16 depot8)
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
  (at_hoist_depot hoist18 depot18)
  (available hoist18)
  (at_hoist_distributor hoist19 distributor0)
  (available hoist19)
  (at_hoist_distributor hoist20 distributor1)
  (available hoist20)
  (at_hoist_distributor hoist21 distributor2)
  (available hoist21)
  (at_hoist_distributor hoist22 distributor3)
  (available hoist22)
  (at_hoist_distributor hoist23 distributor4)
  (available hoist23)
  (at_hoist_distributor hoist24 distributor5)
  (available hoist24)
  (at_hoist_distributor hoist25 distributor6)
  (available hoist25)
  (at_hoist_distributor hoist26 distributor7)
  (available hoist26)
  (at_hoist_distributor hoist27 distributor8)
  (available hoist27)
  (at_hoist_distributor hoist28 distributor9)
  (available hoist28)
  (at_hoist_distributor hoist29 distributor10)
  (available hoist29)
  (at_hoist_distributor hoist30 distributor11)
  (available hoist30)
  (at_hoist_distributor hoist31 distributor12)
  (available hoist31)
  (at_hoist_distributor hoist32 distributor13)
  (available hoist32)
  (at_hoist_distributor hoist33 distributor14)
  (available hoist33)
  (at_hoist_distributor hoist34 distributor15)
  (available hoist34)
  (at_hoist_distributor hoist35 distributor16)
  (available hoist35)
  (at_hoist_distributor hoist36 distributor17)
  (available hoist36)
  (at_hoist_distributor hoist37 distributor18)
  (available hoist37)
  (at_crate_distributor crate0 distributor14)
  (on_pallet crate0 pallet33)
  (at_crate_distributor crate1 distributor3)
  (on_pallet crate1 pallet22)
  (at_crate_distributor crate2 distributor10)
  (on_pallet crate2 pallet29)
  (at_crate_distributor crate3 distributor3)
  (on_crate crate3 crate1)
  (at_crate_depot crate4 depot9)
  (on_pallet crate4 pallet9)
  (at_crate_distributor crate5 distributor6)
  (on_pallet crate5 pallet25)
  (at_crate_distributor crate6 distributor1)
  (on_pallet crate6 pallet20)
  (at_crate_distributor crate7 distributor9)
  (on_pallet crate7 pallet28)
  (at_crate_distributor crate8 distributor10)
  (on_crate crate8 crate2)
  (at_crate_depot crate9 depot1)
  (on_pallet crate9 pallet1)
  (at_crate_distributor crate10 distributor15)
  (on_pallet crate10 pallet34)
  (at_crate_distributor crate11 distributor6)
  (on_crate crate11 crate5)
  (at_crate_depot crate12 depot18)
  (on_pallet crate12 pallet18)
  (at_crate_depot crate13 depot0)
  (on_pallet crate13 pallet0)
  (at_crate_depot crate14 depot17)
  (on_pallet crate14 pallet17)
  (at_crate_distributor crate15 distributor13)
  (on_pallet crate15 pallet32)
  (at_crate_distributor crate16 distributor15)
  (on_crate crate16 crate10)
  (at_crate_distributor crate17 distributor2)
  (on_pallet crate17 pallet21)
  (at_crate_distributor crate18 distributor0)
  (on_pallet crate18 pallet19)
  (at_crate_distributor crate19 distributor16)
  (on_pallet crate19 pallet35)
  (at_crate_distributor crate20 distributor11)
  (on_pallet crate20 pallet30)
  (at_crate_distributor crate21 distributor1)
  (on_crate crate21 crate6)
  (at_crate_depot crate22 depot2)
  (on_pallet crate22 pallet2)
  (at_crate_distributor crate23 distributor12)
  (on_pallet crate23 pallet31)
  (at_crate_distributor crate24 distributor13)
  (on_crate crate24 crate15)
  (at_crate_depot crate25 depot2)
  (on_crate crate25 crate22)
  (at_crate_distributor crate26 distributor12)
  (on_crate crate26 crate23)
  (at_crate_depot crate27 depot17)
  (on_crate crate27 crate14)
  (at_crate_depot crate28 depot2)
  (on_crate crate28 crate25)
  (at_crate_distributor crate29 distributor13)
  (on_crate crate29 crate24)
  (at_crate_distributor crate30 distributor17)
  (on_pallet crate30 pallet36)
  (at_crate_distributor crate31 distributor13)
  (on_crate crate31 crate29)
  (at_crate_depot crate32 depot6)
  (on_pallet crate32 pallet6)
  (at_crate_distributor crate33 distributor1)
  (on_crate crate33 crate21)
  (at_crate_distributor crate34 distributor3)
  (on_crate crate34 crate3)
  (at_crate_depot crate35 depot17)
  (on_crate crate35 crate27)
  (at_crate_depot crate36 depot2)
  (on_crate crate36 crate28)
  (at_crate_distributor crate37 distributor8)
  (on_pallet crate37 pallet27)
  (at_crate_depot crate38 depot11)
  (on_pallet crate38 pallet11)
  (at_crate_distributor crate39 distributor18)
  (on_pallet crate39 pallet37)
  (at_crate_depot crate40 depot16)
  (on_pallet crate40 pallet16)
  (at_crate_distributor crate41 distributor16)
  (on_crate crate41 crate19)
  (at_crate_distributor crate42 distributor9)
  (on_crate crate42 crate7)
  (at_crate_distributor crate43 distributor2)
  (on_crate crate43 crate17)
  (at_crate_distributor crate44 distributor15)
  (on_crate crate44 crate16)
  (at_crate_depot crate45 depot12)
  (on_pallet crate45 pallet12)
  (at_crate_depot crate46 depot4)
  (on_pallet crate46 pallet4)
  (at_crate_distributor crate47 distributor9)
  (on_crate crate47 crate42)
  (at_crate_distributor crate48 distributor4)
  (on_pallet crate48 pallet23)
  (at_crate_distributor crate49 distributor18)
  (on_crate crate49 crate39)
  (at_crate_distributor crate50 distributor9)
  (on_crate crate50 crate47)
  (at_crate_distributor crate51 distributor3)
  (on_crate crate51 crate34)
  (at_crate_depot crate52 depot17)
  (on_crate crate52 crate35)
  (at_crate_distributor crate53 distributor17)
  (on_crate crate53 crate30)
  (at_crate_distributor crate54 distributor14)
  (on_crate crate54 crate0)
  (at_crate_distributor crate55 distributor15)
  (on_crate crate55 crate44)
  (at_crate_distributor crate56 distributor17)
  (on_crate crate56 crate53)
  (at_crate_distributor crate57 distributor3)
  (on_crate crate57 crate51)
)
(:goal   (and (on_crate crate0 crate8)
  (on_crate crate2 crate22)
  (on_pallet crate3 pallet9)
  (on_crate crate4 crate23)
  (on_crate crate5 crate44)
  (on_crate crate7 crate36)
  (on_pallet crate8 pallet19)
  (on_pallet crate10 pallet21)
  (on_pallet crate11 pallet26)
  (on_crate crate12 crate51)
  (on_crate crate15 crate24)
  (on_crate crate17 crate33)
  (on_pallet crate18 pallet15)
  (on_crate crate19 crate20)
  (on_pallet crate20 pallet13)
  (on_pallet crate22 pallet30)
  (on_pallet crate23 pallet17)
  (on_crate crate24 crate30)
  (on_pallet crate25 pallet7)
  (on_pallet crate26 pallet23)
  (on_crate crate27 crate37)
  (on_crate crate28 crate54)
  (on_crate crate29 crate27)
  (on_crate crate30 crate10)
  (on_crate crate32 crate18)
  (on_pallet crate33 pallet11)
  (on_pallet crate34 pallet24)
  (on_crate crate35 crate11)
  (on_crate crate36 crate52)
  (on_pallet crate37 pallet14)
  (on_pallet crate38 pallet2)
  (on_crate crate39 crate49)
  (on_crate crate40 crate46)
  (on_pallet crate41 pallet10)
  (on_crate crate42 crate55)
  (on_pallet crate44 pallet33)
  (on_pallet crate45 pallet36)
  (on_pallet crate46 pallet16)
  (on_pallet crate47 pallet22)
  (on_crate crate48 crate39)
  (on_pallet crate49 pallet1)
  (on_pallet crate50 pallet0)
  (on_pallet crate51 pallet29)
  (on_crate crate52 crate41)
  (on_pallet crate53 pallet35)
  (on_crate crate54 crate15)
  (on_pallet crate55 pallet32)
  (on_crate crate56 crate3)
  (on_pallet crate57 pallet18)))
)
