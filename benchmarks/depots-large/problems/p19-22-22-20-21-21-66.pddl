(define (problem depotprob19)
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
  depot21 - DEPOT
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
  distributor21 - DISTRIBUTOR
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
  truck19 - TRUCK
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
  pallet42 - PALLET
  pallet43 - PALLET
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
  crate64 - CRATE
  crate65 - CRATE
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
  hoist42 - HOIST
  hoist43 - HOIST
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_crate crate47)
  (at_pallet_depot pallet1 depot1)
  (clear_pallet pallet1)
  (at_pallet_depot pallet2 depot2)
  (clear_crate crate10)
  (at_pallet_depot pallet3 depot3)
  (clear_pallet pallet3)
  (at_pallet_depot pallet4 depot4)
  (clear_pallet pallet4)
  (at_pallet_depot pallet5 depot5)
  (clear_crate crate22)
  (at_pallet_depot pallet6 depot6)
  (clear_crate crate60)
  (at_pallet_depot pallet7 depot7)
  (clear_crate crate51)
  (at_pallet_depot pallet8 depot8)
  (clear_crate crate64)
  (at_pallet_depot pallet9 depot9)
  (clear_crate crate2)
  (at_pallet_depot pallet10 depot10)
  (clear_crate crate49)
  (at_pallet_depot pallet11 depot11)
  (clear_crate crate54)
  (at_pallet_depot pallet12 depot12)
  (clear_crate crate50)
  (at_pallet_depot pallet13 depot13)
  (clear_crate crate44)
  (at_pallet_depot pallet14 depot14)
  (clear_crate crate53)
  (at_pallet_depot pallet15 depot15)
  (clear_crate crate34)
  (at_pallet_depot pallet16 depot16)
  (clear_crate crate7)
  (at_pallet_depot pallet17 depot17)
  (clear_pallet pallet17)
  (at_pallet_depot pallet18 depot18)
  (clear_crate crate40)
  (at_pallet_depot pallet19 depot19)
  (clear_crate crate6)
  (at_pallet_depot pallet20 depot20)
  (clear_crate crate36)
  (at_pallet_depot pallet21 depot21)
  (clear_crate crate58)
  (at_pallet_distributor pallet22 distributor0)
  (clear_crate crate27)
  (at_pallet_distributor pallet23 distributor1)
  (clear_crate crate46)
  (at_pallet_distributor pallet24 distributor2)
  (clear_crate crate20)
  (at_pallet_distributor pallet25 distributor3)
  (clear_crate crate45)
  (at_pallet_distributor pallet26 distributor4)
  (clear_crate crate41)
  (at_pallet_distributor pallet27 distributor5)
  (clear_crate crate29)
  (at_pallet_distributor pallet28 distributor6)
  (clear_pallet pallet28)
  (at_pallet_distributor pallet29 distributor7)
  (clear_crate crate19)
  (at_pallet_distributor pallet30 distributor8)
  (clear_pallet pallet30)
  (at_pallet_distributor pallet31 distributor9)
  (clear_crate crate13)
  (at_pallet_distributor pallet32 distributor10)
  (clear_crate crate26)
  (at_pallet_distributor pallet33 distributor11)
  (clear_crate crate35)
  (at_pallet_distributor pallet34 distributor12)
  (clear_crate crate62)
  (at_pallet_distributor pallet35 distributor13)
  (clear_crate crate17)
  (at_pallet_distributor pallet36 distributor14)
  (clear_pallet pallet36)
  (at_pallet_distributor pallet37 distributor15)
  (clear_pallet pallet37)
  (at_pallet_distributor pallet38 distributor16)
  (clear_crate crate61)
  (at_pallet_distributor pallet39 distributor17)
  (clear_crate crate48)
  (at_pallet_distributor pallet40 distributor18)
  (clear_crate crate9)
  (at_pallet_distributor pallet41 distributor19)
  (clear_crate crate65)
  (at_pallet_distributor pallet42 distributor20)
  (clear_pallet pallet42)
  (at_pallet_distributor pallet43 distributor21)
  (clear_crate crate32)
  (at_truck_depot truck0 depot20)
  (at_truck_depot truck1 depot3)
  (at_truck_depot truck2 depot12)
  (at_truck_distributor truck3 distributor14)
  (at_truck_distributor truck4 distributor14)
  (at_truck_distributor truck5 distributor18)
  (at_truck_depot truck6 depot16)
  (at_truck_distributor truck7 distributor6)
  (at_truck_depot truck8 depot4)
  (at_truck_depot truck9 depot18)
  (at_truck_distributor truck10 distributor11)
  (at_truck_depot truck11 depot18)
  (at_truck_distributor truck12 distributor0)
  (at_truck_distributor truck13 distributor9)
  (at_truck_depot truck14 depot20)
  (at_truck_distributor truck15 distributor16)
  (at_truck_depot truck16 depot5)
  (at_truck_distributor truck17 distributor10)
  (at_truck_distributor truck18 distributor16)
  (at_truck_depot truck19 depot8)
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
  (at_hoist_depot hoist21 depot21)
  (available hoist21)
  (at_hoist_distributor hoist22 distributor0)
  (available hoist22)
  (at_hoist_distributor hoist23 distributor1)
  (available hoist23)
  (at_hoist_distributor hoist24 distributor2)
  (available hoist24)
  (at_hoist_distributor hoist25 distributor3)
  (available hoist25)
  (at_hoist_distributor hoist26 distributor4)
  (available hoist26)
  (at_hoist_distributor hoist27 distributor5)
  (available hoist27)
  (at_hoist_distributor hoist28 distributor6)
  (available hoist28)
  (at_hoist_distributor hoist29 distributor7)
  (available hoist29)
  (at_hoist_distributor hoist30 distributor8)
  (available hoist30)
  (at_hoist_distributor hoist31 distributor9)
  (available hoist31)
  (at_hoist_distributor hoist32 distributor10)
  (available hoist32)
  (at_hoist_distributor hoist33 distributor11)
  (available hoist33)
  (at_hoist_distributor hoist34 distributor12)
  (available hoist34)
  (at_hoist_distributor hoist35 distributor13)
  (available hoist35)
  (at_hoist_distributor hoist36 distributor14)
  (available hoist36)
  (at_hoist_distributor hoist37 distributor15)
  (available hoist37)
  (at_hoist_distributor hoist38 distributor16)
  (available hoist38)
  (at_hoist_distributor hoist39 distributor17)
  (available hoist39)
  (at_hoist_distributor hoist40 distributor18)
  (available hoist40)
  (at_hoist_distributor hoist41 distributor19)
  (available hoist41)
  (at_hoist_distributor hoist42 distributor20)
  (available hoist42)
  (at_hoist_distributor hoist43 distributor21)
  (available hoist43)
  (at_crate_distributor crate0 distributor19)
  (on_pallet crate0 pallet41)
  (at_crate_depot crate1 depot20)
  (on_pallet crate1 pallet20)
  (at_crate_depot crate2 depot9)
  (on_pallet crate2 pallet9)
  (at_crate_distributor crate3 distributor21)
  (on_pallet crate3 pallet43)
  (at_crate_depot crate4 depot11)
  (on_pallet crate4 pallet11)
  (at_crate_distributor crate5 distributor13)
  (on_pallet crate5 pallet35)
  (at_crate_depot crate6 depot19)
  (on_pallet crate6 pallet19)
  (at_crate_depot crate7 depot16)
  (on_pallet crate7 pallet16)
  (at_crate_distributor crate8 distributor4)
  (on_pallet crate8 pallet26)
  (at_crate_distributor crate9 distributor18)
  (on_pallet crate9 pallet40)
  (at_crate_depot crate10 depot2)
  (on_pallet crate10 pallet2)
  (at_crate_depot crate11 depot15)
  (on_pallet crate11 pallet15)
  (at_crate_depot crate12 depot18)
  (on_pallet crate12 pallet18)
  (at_crate_distributor crate13 distributor9)
  (on_pallet crate13 pallet31)
  (at_crate_distributor crate14 distributor11)
  (on_pallet crate14 pallet33)
  (at_crate_distributor crate15 distributor19)
  (on_crate crate15 crate0)
  (at_crate_depot crate16 depot6)
  (on_pallet crate16 pallet6)
  (at_crate_distributor crate17 distributor13)
  (on_crate crate17 crate5)
  (at_crate_distributor crate18 distributor11)
  (on_crate crate18 crate14)
  (at_crate_distributor crate19 distributor7)
  (on_pallet crate19 pallet29)
  (at_crate_distributor crate20 distributor2)
  (on_pallet crate20 pallet24)
  (at_crate_distributor crate21 distributor1)
  (on_pallet crate21 pallet23)
  (at_crate_depot crate22 depot5)
  (on_pallet crate22 pallet5)
  (at_crate_depot crate23 depot13)
  (on_pallet crate23 pallet13)
  (at_crate_depot crate24 depot7)
  (on_pallet crate24 pallet7)
  (at_crate_depot crate25 depot11)
  (on_crate crate25 crate4)
  (at_crate_distributor crate26 distributor10)
  (on_pallet crate26 pallet32)
  (at_crate_distributor crate27 distributor0)
  (on_pallet crate27 pallet22)
  (at_crate_depot crate28 depot14)
  (on_pallet crate28 pallet14)
  (at_crate_distributor crate29 distributor5)
  (on_pallet crate29 pallet27)
  (at_crate_distributor crate30 distributor11)
  (on_crate crate30 crate18)
  (at_crate_distributor crate31 distributor11)
  (on_crate crate31 crate30)
  (at_crate_distributor crate32 distributor21)
  (on_crate crate32 crate3)
  (at_crate_depot crate33 depot13)
  (on_crate crate33 crate23)
  (at_crate_depot crate34 depot15)
  (on_crate crate34 crate11)
  (at_crate_distributor crate35 distributor11)
  (on_crate crate35 crate31)
  (at_crate_depot crate36 depot20)
  (on_crate crate36 crate1)
  (at_crate_distributor crate37 distributor17)
  (on_pallet crate37 pallet39)
  (at_crate_depot crate38 depot7)
  (on_crate crate38 crate24)
  (at_crate_depot crate39 depot13)
  (on_crate crate39 crate33)
  (at_crate_depot crate40 depot18)
  (on_crate crate40 crate12)
  (at_crate_distributor crate41 distributor4)
  (on_crate crate41 crate8)
  (at_crate_depot crate42 depot8)
  (on_pallet crate42 pallet8)
  (at_crate_depot crate43 depot14)
  (on_crate crate43 crate28)
  (at_crate_depot crate44 depot13)
  (on_crate crate44 crate39)
  (at_crate_distributor crate45 distributor3)
  (on_pallet crate45 pallet25)
  (at_crate_distributor crate46 distributor1)
  (on_crate crate46 crate21)
  (at_crate_depot crate47 depot0)
  (on_pallet crate47 pallet0)
  (at_crate_distributor crate48 distributor17)
  (on_crate crate48 crate37)
  (at_crate_depot crate49 depot10)
  (on_pallet crate49 pallet10)
  (at_crate_depot crate50 depot12)
  (on_pallet crate50 pallet12)
  (at_crate_depot crate51 depot7)
  (on_crate crate51 crate38)
  (at_crate_depot crate52 depot11)
  (on_crate crate52 crate25)
  (at_crate_depot crate53 depot14)
  (on_crate crate53 crate43)
  (at_crate_depot crate54 depot11)
  (on_crate crate54 crate52)
  (at_crate_distributor crate55 distributor12)
  (on_pallet crate55 pallet34)
  (at_crate_depot crate56 depot8)
  (on_crate crate56 crate42)
  (at_crate_distributor crate57 distributor16)
  (on_pallet crate57 pallet38)
  (at_crate_depot crate58 depot21)
  (on_pallet crate58 pallet21)
  (at_crate_distributor crate59 distributor16)
  (on_crate crate59 crate57)
  (at_crate_depot crate60 depot6)
  (on_crate crate60 crate16)
  (at_crate_distributor crate61 distributor16)
  (on_crate crate61 crate59)
  (at_crate_distributor crate62 distributor12)
  (on_crate crate62 crate55)
  (at_crate_depot crate63 depot8)
  (on_crate crate63 crate56)
  (at_crate_depot crate64 depot8)
  (on_crate crate64 crate63)
  (at_crate_distributor crate65 distributor19)
  (on_crate crate65 crate15)
)
(:goal   (and (on_pallet crate0 pallet33)
  (on_pallet crate1 pallet37)
  (on_pallet crate3 pallet38)
  (on_pallet crate5 pallet19)
  (on_pallet crate6 pallet9)
  (on_pallet crate7 pallet31)
  (on_crate crate8 crate9)
  (on_pallet crate9 pallet30)
  (on_pallet crate10 pallet4)
  (on_pallet crate11 pallet39)
  (on_pallet crate12 pallet8)
  (on_pallet crate13 pallet36)
  (on_crate crate15 crate19)
  (on_crate crate17 crate29)
  (on_crate crate18 crate48)
  (on_pallet crate19 pallet40)
  (on_pallet crate20 pallet11)
  (on_pallet crate21 pallet10)
  (on_crate crate22 crate27)
  (on_pallet crate23 pallet15)
  (on_pallet crate24 pallet12)
  (on_crate crate25 crate32)
  (on_crate crate26 crate62)
  (on_crate crate27 crate11)
  (on_crate crate28 crate44)
  (on_pallet crate29 pallet16)
  (on_pallet crate30 pallet18)
  (on_pallet crate31 pallet42)
  (on_pallet crate32 pallet6)
  (on_pallet crate33 pallet34)
  (on_pallet crate34 pallet28)
  (on_pallet crate35 pallet5)
  (on_pallet crate36 pallet22)
  (on_crate crate38 crate28)
  (on_crate crate39 crate59)
  (on_crate crate40 crate61)
  (on_pallet crate41 pallet25)
  (on_pallet crate42 pallet23)
  (on_crate crate43 crate31)
  (on_pallet crate44 pallet7)
  (on_crate crate45 crate41)
  (on_pallet crate46 pallet20)
  (on_crate crate47 crate3)
  (on_crate crate48 crate47)
  (on_crate crate49 crate0)
  (on_pallet crate50 pallet32)
  (on_crate crate51 crate6)
  (on_pallet crate52 pallet13)
  (on_crate crate53 crate42)
  (on_crate crate54 crate12)
  (on_crate crate55 crate38)
  (on_pallet crate56 pallet21)
  (on_pallet crate57 pallet27)
  (on_crate crate58 crate43)
  (on_crate crate59 crate35)
  (on_crate crate60 crate21)
  (on_crate crate61 crate17)
  (on_pallet crate62 pallet26)
  (on_crate crate63 crate53)
  (on_crate crate64 crate1)
  (on_crate crate65 crate52)))
)
