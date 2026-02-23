(define (problem depotprob18)
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
  depot20 - DEPOT
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
  distributor20 - DISTRIBUTOR
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
  truck18 - TRUCK
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
  pallet40 - PALLET
  pallet41 - PALLET
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
  crate62 - CRATE
  crate63 - CRATE
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
  hoist40 - HOIST
  hoist41 - HOIST
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_crate crate28)
  (at_pallet_depot pallet1 depot1)
  (clear_crate crate21)
  (at_pallet_depot pallet2 depot2)
  (clear_crate crate12)
  (at_pallet_depot pallet3 depot3)
  (clear_crate crate63)
  (at_pallet_depot pallet4 depot4)
  (clear_crate crate49)
  (at_pallet_depot pallet5 depot5)
  (clear_crate crate43)
  (at_pallet_depot pallet6 depot6)
  (clear_pallet pallet6)
  (at_pallet_depot pallet7 depot7)
  (clear_crate crate8)
  (at_pallet_depot pallet8 depot8)
  (clear_crate crate34)
  (at_pallet_depot pallet9 depot9)
  (clear_crate crate37)
  (at_pallet_depot pallet10 depot10)
  (clear_crate crate62)
  (at_pallet_depot pallet11 depot11)
  (clear_crate crate18)
  (at_pallet_depot pallet12 depot12)
  (clear_crate crate46)
  (at_pallet_depot pallet13 depot13)
  (clear_crate crate39)
  (at_pallet_depot pallet14 depot14)
  (clear_pallet pallet14)
  (at_pallet_depot pallet15 depot15)
  (clear_crate crate23)
  (at_pallet_depot pallet16 depot16)
  (clear_crate crate61)
  (at_pallet_depot pallet17 depot17)
  (clear_crate crate40)
  (at_pallet_depot pallet18 depot18)
  (clear_crate crate9)
  (at_pallet_depot pallet19 depot19)
  (clear_pallet pallet19)
  (at_pallet_depot pallet20 depot20)
  (clear_crate crate54)
  (at_pallet_distributor pallet21 distributor0)
  (clear_crate crate13)
  (at_pallet_distributor pallet22 distributor1)
  (clear_crate crate48)
  (at_pallet_distributor pallet23 distributor2)
  (clear_pallet pallet23)
  (at_pallet_distributor pallet24 distributor3)
  (clear_crate crate52)
  (at_pallet_distributor pallet25 distributor4)
  (clear_crate crate6)
  (at_pallet_distributor pallet26 distributor5)
  (clear_crate crate51)
  (at_pallet_distributor pallet27 distributor6)
  (clear_crate crate16)
  (at_pallet_distributor pallet28 distributor7)
  (clear_crate crate59)
  (at_pallet_distributor pallet29 distributor8)
  (clear_crate crate11)
  (at_pallet_distributor pallet30 distributor9)
  (clear_crate crate60)
  (at_pallet_distributor pallet31 distributor10)
  (clear_crate crate58)
  (at_pallet_distributor pallet32 distributor11)
  (clear_crate crate33)
  (at_pallet_distributor pallet33 distributor12)
  (clear_crate crate55)
  (at_pallet_distributor pallet34 distributor13)
  (clear_pallet pallet34)
  (at_pallet_distributor pallet35 distributor14)
  (clear_crate crate42)
  (at_pallet_distributor pallet36 distributor15)
  (clear_crate crate30)
  (at_pallet_distributor pallet37 distributor16)
  (clear_crate crate45)
  (at_pallet_distributor pallet38 distributor17)
  (clear_crate crate4)
  (at_pallet_distributor pallet39 distributor18)
  (clear_crate crate53)
  (at_pallet_distributor pallet40 distributor19)
  (clear_pallet pallet40)
  (at_pallet_distributor pallet41 distributor20)
  (clear_crate crate56)
  (at_truck_distributor truck0 distributor16)
  (at_truck_depot truck1 depot7)
  (at_truck_depot truck2 depot9)
  (at_truck_depot truck3 depot13)
  (at_truck_distributor truck4 distributor7)
  (at_truck_depot truck5 depot2)
  (at_truck_depot truck6 depot1)
  (at_truck_distributor truck7 distributor3)
  (at_truck_depot truck8 depot18)
  (at_truck_distributor truck9 distributor10)
  (at_truck_depot truck10 depot12)
  (at_truck_depot truck11 depot16)
  (at_truck_depot truck12 depot6)
  (at_truck_depot truck13 depot1)
  (at_truck_distributor truck14 distributor18)
  (at_truck_distributor truck15 distributor11)
  (at_truck_depot truck16 depot2)
  (at_truck_distributor truck17 distributor20)
  (at_truck_distributor truck18 distributor2)
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
  (at_hoist_depot hoist20 depot20)
  (available hoist20)
  (at_hoist_distributor hoist21 distributor0)
  (available hoist21)
  (at_hoist_distributor hoist22 distributor1)
  (available hoist22)
  (at_hoist_distributor hoist23 distributor2)
  (available hoist23)
  (at_hoist_distributor hoist24 distributor3)
  (available hoist24)
  (at_hoist_distributor hoist25 distributor4)
  (available hoist25)
  (at_hoist_distributor hoist26 distributor5)
  (available hoist26)
  (at_hoist_distributor hoist27 distributor6)
  (available hoist27)
  (at_hoist_distributor hoist28 distributor7)
  (available hoist28)
  (at_hoist_distributor hoist29 distributor8)
  (available hoist29)
  (at_hoist_distributor hoist30 distributor9)
  (available hoist30)
  (at_hoist_distributor hoist31 distributor10)
  (available hoist31)
  (at_hoist_distributor hoist32 distributor11)
  (available hoist32)
  (at_hoist_distributor hoist33 distributor12)
  (available hoist33)
  (at_hoist_distributor hoist34 distributor13)
  (available hoist34)
  (at_hoist_distributor hoist35 distributor14)
  (available hoist35)
  (at_hoist_distributor hoist36 distributor15)
  (available hoist36)
  (at_hoist_distributor hoist37 distributor16)
  (available hoist37)
  (at_hoist_distributor hoist38 distributor17)
  (available hoist38)
  (at_hoist_distributor hoist39 distributor18)
  (available hoist39)
  (at_hoist_distributor hoist40 distributor19)
  (available hoist40)
  (at_hoist_distributor hoist41 distributor20)
  (available hoist41)
  (at_crate_distributor crate0 distributor9)
  (on_pallet crate0 pallet30)
  (at_crate_distributor crate1 distributor14)
  (on_pallet crate1 pallet35)
  (at_crate_distributor crate2 distributor3)
  (on_pallet crate2 pallet24)
  (at_crate_depot crate3 depot10)
  (on_pallet crate3 pallet10)
  (at_crate_distributor crate4 distributor17)
  (on_pallet crate4 pallet38)
  (at_crate_depot crate5 depot16)
  (on_pallet crate5 pallet16)
  (at_crate_distributor crate6 distributor4)
  (on_pallet crate6 pallet25)
  (at_crate_depot crate7 depot15)
  (on_pallet crate7 pallet15)
  (at_crate_depot crate8 depot7)
  (on_pallet crate8 pallet7)
  (at_crate_depot crate9 depot18)
  (on_pallet crate9 pallet18)
  (at_crate_depot crate10 depot12)
  (on_pallet crate10 pallet12)
  (at_crate_distributor crate11 distributor8)
  (on_pallet crate11 pallet29)
  (at_crate_depot crate12 depot2)
  (on_pallet crate12 pallet2)
  (at_crate_distributor crate13 distributor0)
  (on_pallet crate13 pallet21)
  (at_crate_depot crate14 depot1)
  (on_pallet crate14 pallet1)
  (at_crate_distributor crate15 distributor3)
  (on_crate crate15 crate2)
  (at_crate_distributor crate16 distributor6)
  (on_pallet crate16 pallet27)
  (at_crate_depot crate17 depot3)
  (on_pallet crate17 pallet3)
  (at_crate_depot crate18 depot11)
  (on_pallet crate18 pallet11)
  (at_crate_depot crate19 depot13)
  (on_pallet crate19 pallet13)
  (at_crate_distributor crate20 distributor9)
  (on_crate crate20 crate0)
  (at_crate_depot crate21 depot1)
  (on_crate crate21 crate14)
  (at_crate_distributor crate22 distributor7)
  (on_pallet crate22 pallet28)
  (at_crate_depot crate23 depot15)
  (on_crate crate23 crate7)
  (at_crate_distributor crate24 distributor15)
  (on_pallet crate24 pallet36)
  (at_crate_depot crate25 depot17)
  (on_pallet crate25 pallet17)
  (at_crate_depot crate26 depot13)
  (on_crate crate26 crate19)
  (at_crate_distributor crate27 distributor3)
  (on_crate crate27 crate15)
  (at_crate_depot crate28 depot0)
  (on_pallet crate28 pallet0)
  (at_crate_distributor crate29 distributor12)
  (on_pallet crate29 pallet33)
  (at_crate_distributor crate30 distributor15)
  (on_crate crate30 crate24)
  (at_crate_distributor crate31 distributor11)
  (on_pallet crate31 pallet32)
  (at_crate_distributor crate32 distributor11)
  (on_crate crate32 crate31)
  (at_crate_distributor crate33 distributor11)
  (on_crate crate33 crate32)
  (at_crate_depot crate34 depot8)
  (on_pallet crate34 pallet8)
  (at_crate_depot crate35 depot9)
  (on_pallet crate35 pallet9)
  (at_crate_distributor crate36 distributor12)
  (on_crate crate36 crate29)
  (at_crate_depot crate37 depot9)
  (on_crate crate37 crate35)
  (at_crate_distributor crate38 distributor7)
  (on_crate crate38 crate22)
  (at_crate_depot crate39 depot13)
  (on_crate crate39 crate26)
  (at_crate_depot crate40 depot17)
  (on_crate crate40 crate25)
  (at_crate_distributor crate41 distributor7)
  (on_crate crate41 crate38)
  (at_crate_distributor crate42 distributor14)
  (on_crate crate42 crate1)
  (at_crate_depot crate43 depot5)
  (on_pallet crate43 pallet5)
  (at_crate_depot crate44 depot16)
  (on_crate crate44 crate5)
  (at_crate_distributor crate45 distributor16)
  (on_pallet crate45 pallet37)
  (at_crate_depot crate46 depot12)
  (on_crate crate46 crate10)
  (at_crate_distributor crate47 distributor12)
  (on_crate crate47 crate36)
  (at_crate_distributor crate48 distributor1)
  (on_pallet crate48 pallet22)
  (at_crate_depot crate49 depot4)
  (on_pallet crate49 pallet4)
  (at_crate_distributor crate50 distributor7)
  (on_crate crate50 crate41)
  (at_crate_distributor crate51 distributor5)
  (on_pallet crate51 pallet26)
  (at_crate_distributor crate52 distributor3)
  (on_crate crate52 crate27)
  (at_crate_distributor crate53 distributor18)
  (on_pallet crate53 pallet39)
  (at_crate_depot crate54 depot20)
  (on_pallet crate54 pallet20)
  (at_crate_distributor crate55 distributor12)
  (on_crate crate55 crate47)
  (at_crate_distributor crate56 distributor20)
  (on_pallet crate56 pallet41)
  (at_crate_distributor crate57 distributor7)
  (on_crate crate57 crate50)
  (at_crate_distributor crate58 distributor10)
  (on_pallet crate58 pallet31)
  (at_crate_distributor crate59 distributor7)
  (on_crate crate59 crate57)
  (at_crate_distributor crate60 distributor9)
  (on_crate crate60 crate20)
  (at_crate_depot crate61 depot16)
  (on_crate crate61 crate44)
  (at_crate_depot crate62 depot10)
  (on_crate crate62 crate3)
  (at_crate_depot crate63 depot3)
  (on_crate crate63 crate17)
)
(:goal   (and (on_crate crate0 crate14)
  (on_crate crate1 crate5)
  (on_pallet crate2 pallet18)
  (on_crate crate3 crate34)
  (on_pallet crate5 pallet27)
  (on_crate crate6 crate51)
  (on_pallet crate7 pallet0)
  (on_pallet crate8 pallet30)
  (on_pallet crate9 pallet38)
  (on_crate crate10 crate50)
  (on_pallet crate11 pallet17)
  (on_pallet crate12 pallet21)
  (on_crate crate13 crate52)
  (on_crate crate14 crate9)
  (on_pallet crate16 pallet23)
  (on_pallet crate17 pallet31)
  (on_crate crate19 crate38)
  (on_crate crate20 crate45)
  (on_crate crate21 crate24)
  (on_pallet crate22 pallet19)
  (on_pallet crate24 pallet9)
  (on_crate crate26 crate27)
  (on_pallet crate27 pallet2)
  (on_crate crate28 crate12)
  (on_pallet crate30 pallet33)
  (on_pallet crate31 pallet4)
  (on_pallet crate33 pallet34)
  (on_crate crate34 crate56)
  (on_pallet crate37 pallet40)
  (on_pallet crate38 pallet24)
  (on_pallet crate39 pallet6)
  (on_crate crate40 crate41)
  (on_crate crate41 crate8)
  (on_pallet crate42 pallet1)
  (on_crate crate43 crate61)
  (on_crate crate44 crate43)
  (on_crate crate45 crate1)
  (on_pallet crate46 pallet14)
  (on_crate crate47 crate53)
  (on_pallet crate49 pallet36)
  (on_pallet crate50 pallet32)
  (on_pallet crate51 pallet12)
  (on_crate crate52 crate3)
  (on_pallet crate53 pallet29)
  (on_pallet crate54 pallet16)
  (on_pallet crate56 pallet25)
  (on_crate crate58 crate54)
  (on_crate crate59 crate33)
  (on_pallet crate60 pallet26)
  (on_pallet crate61 pallet20)
  (on_pallet crate63 pallet39)))
)
