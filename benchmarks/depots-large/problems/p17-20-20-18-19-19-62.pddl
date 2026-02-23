(define (problem depotprob17)
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
  depot19 - DEPOT
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
  distributor19 - DISTRIBUTOR
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
  truck17 - TRUCK
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
  pallet38 - PALLET
  pallet39 - PALLET
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
  crate58 - CRATE
  crate59 - CRATE
  crate60 - CRATE
  crate61 - CRATE
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
  hoist38 - HOIST
  hoist39 - HOIST
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_pallet pallet0)
  (at_pallet_depot pallet1 depot1)
  (clear_pallet pallet1)
  (at_pallet_depot pallet2 depot2)
  (clear_pallet pallet2)
  (at_pallet_depot pallet3 depot3)
  (clear_crate crate55)
  (at_pallet_depot pallet4 depot4)
  (clear_crate crate14)
  (at_pallet_depot pallet5 depot5)
  (clear_crate crate20)
  (at_pallet_depot pallet6 depot6)
  (clear_crate crate27)
  (at_pallet_depot pallet7 depot7)
  (clear_crate crate47)
  (at_pallet_depot pallet8 depot8)
  (clear_crate crate30)
  (at_pallet_depot pallet9 depot9)
  (clear_crate crate46)
  (at_pallet_depot pallet10 depot10)
  (clear_crate crate32)
  (at_pallet_depot pallet11 depot11)
  (clear_pallet pallet11)
  (at_pallet_depot pallet12 depot12)
  (clear_crate crate54)
  (at_pallet_depot pallet13 depot13)
  (clear_crate crate35)
  (at_pallet_depot pallet14 depot14)
  (clear_crate crate22)
  (at_pallet_depot pallet15 depot15)
  (clear_crate crate13)
  (at_pallet_depot pallet16 depot16)
  (clear_pallet pallet16)
  (at_pallet_depot pallet17 depot17)
  (clear_crate crate56)
  (at_pallet_depot pallet18 depot18)
  (clear_crate crate34)
  (at_pallet_depot pallet19 depot19)
  (clear_crate crate60)
  (at_pallet_distributor pallet20 distributor0)
  (clear_pallet pallet20)
  (at_pallet_distributor pallet21 distributor1)
  (clear_crate crate59)
  (at_pallet_distributor pallet22 distributor2)
  (clear_crate crate10)
  (at_pallet_distributor pallet23 distributor3)
  (clear_pallet pallet23)
  (at_pallet_distributor pallet24 distributor4)
  (clear_crate crate51)
  (at_pallet_distributor pallet25 distributor5)
  (clear_crate crate45)
  (at_pallet_distributor pallet26 distributor6)
  (clear_pallet pallet26)
  (at_pallet_distributor pallet27 distributor7)
  (clear_crate crate26)
  (at_pallet_distributor pallet28 distributor8)
  (clear_crate crate29)
  (at_pallet_distributor pallet29 distributor9)
  (clear_crate crate58)
  (at_pallet_distributor pallet30 distributor10)
  (clear_pallet pallet30)
  (at_pallet_distributor pallet31 distributor11)
  (clear_crate crate38)
  (at_pallet_distributor pallet32 distributor12)
  (clear_pallet pallet32)
  (at_pallet_distributor pallet33 distributor13)
  (clear_crate crate19)
  (at_pallet_distributor pallet34 distributor14)
  (clear_crate crate39)
  (at_pallet_distributor pallet35 distributor15)
  (clear_crate crate57)
  (at_pallet_distributor pallet36 distributor16)
  (clear_crate crate61)
  (at_pallet_distributor pallet37 distributor17)
  (clear_pallet pallet37)
  (at_pallet_distributor pallet38 distributor18)
  (clear_crate crate18)
  (at_pallet_distributor pallet39 distributor19)
  (clear_crate crate31)
  (at_truck_depot truck0 depot8)
  (at_truck_distributor truck1 distributor2)
  (at_truck_distributor truck2 distributor11)
  (at_truck_distributor truck3 distributor19)
  (at_truck_depot truck4 depot0)
  (at_truck_depot truck5 depot1)
  (at_truck_depot truck6 depot0)
  (at_truck_depot truck7 depot14)
  (at_truck_distributor truck8 distributor6)
  (at_truck_depot truck9 depot2)
  (at_truck_distributor truck10 distributor10)
  (at_truck_depot truck11 depot4)
  (at_truck_distributor truck12 distributor16)
  (at_truck_distributor truck13 distributor12)
  (at_truck_depot truck14 depot8)
  (at_truck_depot truck15 depot4)
  (at_truck_distributor truck16 distributor3)
  (at_truck_distributor truck17 distributor10)
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
  (at_hoist_depot hoist19 depot19)
  (available hoist19)
  (at_hoist_distributor hoist20 distributor0)
  (available hoist20)
  (at_hoist_distributor hoist21 distributor1)
  (available hoist21)
  (at_hoist_distributor hoist22 distributor2)
  (available hoist22)
  (at_hoist_distributor hoist23 distributor3)
  (available hoist23)
  (at_hoist_distributor hoist24 distributor4)
  (available hoist24)
  (at_hoist_distributor hoist25 distributor5)
  (available hoist25)
  (at_hoist_distributor hoist26 distributor6)
  (available hoist26)
  (at_hoist_distributor hoist27 distributor7)
  (available hoist27)
  (at_hoist_distributor hoist28 distributor8)
  (available hoist28)
  (at_hoist_distributor hoist29 distributor9)
  (available hoist29)
  (at_hoist_distributor hoist30 distributor10)
  (available hoist30)
  (at_hoist_distributor hoist31 distributor11)
  (available hoist31)
  (at_hoist_distributor hoist32 distributor12)
  (available hoist32)
  (at_hoist_distributor hoist33 distributor13)
  (available hoist33)
  (at_hoist_distributor hoist34 distributor14)
  (available hoist34)
  (at_hoist_distributor hoist35 distributor15)
  (available hoist35)
  (at_hoist_distributor hoist36 distributor16)
  (available hoist36)
  (at_hoist_distributor hoist37 distributor17)
  (available hoist37)
  (at_hoist_distributor hoist38 distributor18)
  (available hoist38)
  (at_hoist_distributor hoist39 distributor19)
  (available hoist39)
  (at_crate_depot crate0 depot17)
  (on_pallet crate0 pallet17)
  (at_crate_distributor crate1 distributor13)
  (on_pallet crate1 pallet33)
  (at_crate_distributor crate2 distributor15)
  (on_pallet crate2 pallet35)
  (at_crate_distributor crate3 distributor5)
  (on_pallet crate3 pallet25)
  (at_crate_depot crate4 depot6)
  (on_pallet crate4 pallet6)
  (at_crate_depot crate5 depot7)
  (on_pallet crate5 pallet7)
  (at_crate_distributor crate6 distributor19)
  (on_pallet crate6 pallet39)
  (at_crate_distributor crate7 distributor5)
  (on_crate crate7 crate3)
  (at_crate_distributor crate8 distributor4)
  (on_pallet crate8 pallet24)
  (at_crate_depot crate9 depot9)
  (on_pallet crate9 pallet9)
  (at_crate_distributor crate10 distributor2)
  (on_pallet crate10 pallet22)
  (at_crate_depot crate11 depot3)
  (on_pallet crate11 pallet3)
  (at_crate_distributor crate12 distributor5)
  (on_crate crate12 crate7)
  (at_crate_depot crate13 depot15)
  (on_pallet crate13 pallet15)
  (at_crate_depot crate14 depot4)
  (on_pallet crate14 pallet4)
  (at_crate_depot crate15 depot14)
  (on_pallet crate15 pallet14)
  (at_crate_depot crate16 depot10)
  (on_pallet crate16 pallet10)
  (at_crate_distributor crate17 distributor16)
  (on_pallet crate17 pallet36)
  (at_crate_distributor crate18 distributor18)
  (on_pallet crate18 pallet38)
  (at_crate_distributor crate19 distributor13)
  (on_crate crate19 crate1)
  (at_crate_depot crate20 depot5)
  (on_pallet crate20 pallet5)
  (at_crate_distributor crate21 distributor16)
  (on_crate crate21 crate17)
  (at_crate_depot crate22 depot14)
  (on_crate crate22 crate15)
  (at_crate_depot crate23 depot9)
  (on_crate crate23 crate9)
  (at_crate_depot crate24 depot7)
  (on_crate crate24 crate5)
  (at_crate_distributor crate25 distributor19)
  (on_crate crate25 crate6)
  (at_crate_distributor crate26 distributor7)
  (on_pallet crate26 pallet27)
  (at_crate_depot crate27 depot6)
  (on_crate crate27 crate4)
  (at_crate_depot crate28 depot12)
  (on_pallet crate28 pallet12)
  (at_crate_distributor crate29 distributor8)
  (on_pallet crate29 pallet28)
  (at_crate_depot crate30 depot8)
  (on_pallet crate30 pallet8)
  (at_crate_distributor crate31 distributor19)
  (on_crate crate31 crate25)
  (at_crate_depot crate32 depot10)
  (on_crate crate32 crate16)
  (at_crate_distributor crate33 distributor5)
  (on_crate crate33 crate12)
  (at_crate_depot crate34 depot18)
  (on_pallet crate34 pallet18)
  (at_crate_depot crate35 depot13)
  (on_pallet crate35 pallet13)
  (at_crate_distributor crate36 distributor1)
  (on_pallet crate36 pallet21)
  (at_crate_distributor crate37 distributor9)
  (on_pallet crate37 pallet29)
  (at_crate_distributor crate38 distributor11)
  (on_pallet crate38 pallet31)
  (at_crate_distributor crate39 distributor14)
  (on_pallet crate39 pallet34)
  (at_crate_depot crate40 depot17)
  (on_crate crate40 crate0)
  (at_crate_distributor crate41 distributor9)
  (on_crate crate41 crate37)
  (at_crate_distributor crate42 distributor16)
  (on_crate crate42 crate21)
  (at_crate_depot crate43 depot17)
  (on_crate crate43 crate40)
  (at_crate_depot crate44 depot19)
  (on_pallet crate44 pallet19)
  (at_crate_distributor crate45 distributor5)
  (on_crate crate45 crate33)
  (at_crate_depot crate46 depot9)
  (on_crate crate46 crate23)
  (at_crate_depot crate47 depot7)
  (on_crate crate47 crate24)
  (at_crate_distributor crate48 distributor1)
  (on_crate crate48 crate36)
  (at_crate_distributor crate49 distributor9)
  (on_crate crate49 crate41)
  (at_crate_depot crate50 depot12)
  (on_crate crate50 crate28)
  (at_crate_distributor crate51 distributor4)
  (on_crate crate51 crate8)
  (at_crate_depot crate52 depot12)
  (on_crate crate52 crate50)
  (at_crate_distributor crate53 distributor9)
  (on_crate crate53 crate49)
  (at_crate_depot crate54 depot12)
  (on_crate crate54 crate52)
  (at_crate_depot crate55 depot3)
  (on_crate crate55 crate11)
  (at_crate_depot crate56 depot17)
  (on_crate crate56 crate43)
  (at_crate_distributor crate57 distributor15)
  (on_crate crate57 crate2)
  (at_crate_distributor crate58 distributor9)
  (on_crate crate58 crate53)
  (at_crate_distributor crate59 distributor1)
  (on_crate crate59 crate48)
  (at_crate_depot crate60 depot19)
  (on_crate crate60 crate44)
  (at_crate_distributor crate61 distributor16)
  (on_crate crate61 crate42)
)
(:goal   (and (on_pallet crate0 pallet6)
  (on_crate crate1 crate0)
  (on_pallet crate2 pallet32)
  (on_crate crate3 crate5)
  (on_pallet crate5 pallet9)
  (on_crate crate6 crate34)
  (on_crate crate7 crate41)
  (on_pallet crate8 pallet26)
  (on_crate crate9 crate10)
  (on_crate crate10 crate57)
  (on_pallet crate13 pallet1)
  (on_pallet crate15 pallet14)
  (on_pallet crate16 pallet39)
  (on_crate crate17 crate13)
  (on_crate crate18 crate36)
  (on_pallet crate20 pallet36)
  (on_pallet crate21 pallet10)
  (on_crate crate22 crate51)
  (on_crate crate24 crate16)
  (on_crate crate25 crate17)
  (on_crate crate27 crate28)
  (on_pallet crate28 pallet12)
  (on_pallet crate29 pallet19)
  (on_pallet crate30 pallet25)
  (on_crate crate31 crate15)
  (on_crate crate32 crate59)
  (on_crate crate33 crate21)
  (on_pallet crate34 pallet28)
  (on_crate crate35 crate45)
  (on_pallet crate36 pallet15)
  (on_pallet crate37 pallet22)
  (on_crate crate38 crate47)
  (on_crate crate40 crate38)
  (on_pallet crate41 pallet34)
  (on_crate crate42 crate3)
  (on_pallet crate43 pallet11)
  (on_pallet crate44 pallet31)
  (on_pallet crate45 pallet0)
  (on_crate crate46 crate9)
  (on_pallet crate47 pallet27)
  (on_crate crate48 crate27)
  (on_pallet crate49 pallet17)
  (on_crate crate50 crate8)
  (on_crate crate51 crate32)
  (on_pallet crate52 pallet38)
  (on_pallet crate54 pallet7)
  (on_pallet crate56 pallet35)
  (on_pallet crate57 pallet2)
  (on_pallet crate58 pallet23)
  (on_pallet crate59 pallet13)
  (on_crate crate60 crate24)
  (on_pallet crate61 pallet21)))
)
