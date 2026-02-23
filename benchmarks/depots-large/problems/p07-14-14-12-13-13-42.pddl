(define (problem depotprob7)
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
)
(:init
  (at_pallet_depot pallet0 depot0)
  (clear_crate crate37)
  (at_pallet_depot pallet1 depot1)
  (clear_crate crate41)
  (at_pallet_depot pallet2 depot2)
  (clear_pallet pallet2)
  (at_pallet_depot pallet3 depot3)
  (clear_crate crate31)
  (at_pallet_depot pallet4 depot4)
  (clear_crate crate14)
  (at_pallet_depot pallet5 depot5)
  (clear_pallet pallet5)
  (at_pallet_depot pallet6 depot6)
  (clear_crate crate28)
  (at_pallet_depot pallet7 depot7)
  (clear_crate crate32)
  (at_pallet_depot pallet8 depot8)
  (clear_crate crate34)
  (at_pallet_depot pallet9 depot9)
  (clear_pallet pallet9)
  (at_pallet_depot pallet10 depot10)
  (clear_crate crate26)
  (at_pallet_depot pallet11 depot11)
  (clear_crate crate33)
  (at_pallet_depot pallet12 depot12)
  (clear_crate crate12)
  (at_pallet_depot pallet13 depot13)
  (clear_pallet pallet13)
  (at_pallet_distributor pallet14 distributor0)
  (clear_crate crate29)
  (at_pallet_distributor pallet15 distributor1)
  (clear_crate crate16)
  (at_pallet_distributor pallet16 distributor2)
  (clear_crate crate24)
  (at_pallet_distributor pallet17 distributor3)
  (clear_crate crate35)
  (at_pallet_distributor pallet18 distributor4)
  (clear_crate crate6)
  (at_pallet_distributor pallet19 distributor5)
  (clear_crate crate39)
  (at_pallet_distributor pallet20 distributor6)
  (clear_pallet pallet20)
  (at_pallet_distributor pallet21 distributor7)
  (clear_pallet pallet21)
  (at_pallet_distributor pallet22 distributor8)
  (clear_crate crate10)
  (at_pallet_distributor pallet23 distributor9)
  (clear_crate crate36)
  (at_pallet_distributor pallet24 distributor10)
  (clear_pallet pallet24)
  (at_pallet_distributor pallet25 distributor11)
  (clear_crate crate17)
  (at_pallet_distributor pallet26 distributor12)
  (clear_crate crate27)
  (at_pallet_distributor pallet27 distributor13)
  (clear_crate crate40)
  (at_truck_depot truck0 depot4)
  (at_truck_distributor truck1 distributor5)
  (at_truck_distributor truck2 distributor8)
  (at_truck_distributor truck3 distributor10)
  (at_truck_distributor truck4 distributor4)
  (at_truck_distributor truck5 distributor2)
  (at_truck_depot truck6 depot10)
  (at_truck_distributor truck7 distributor0)
  (at_truck_distributor truck8 distributor5)
  (at_truck_depot truck9 depot10)
  (at_truck_depot truck10 depot0)
  (at_truck_distributor truck11 distributor1)
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
  (at_hoist_distributor hoist14 distributor0)
  (available hoist14)
  (at_hoist_distributor hoist15 distributor1)
  (available hoist15)
  (at_hoist_distributor hoist16 distributor2)
  (available hoist16)
  (at_hoist_distributor hoist17 distributor3)
  (available hoist17)
  (at_hoist_distributor hoist18 distributor4)
  (available hoist18)
  (at_hoist_distributor hoist19 distributor5)
  (available hoist19)
  (at_hoist_distributor hoist20 distributor6)
  (available hoist20)
  (at_hoist_distributor hoist21 distributor7)
  (available hoist21)
  (at_hoist_distributor hoist22 distributor8)
  (available hoist22)
  (at_hoist_distributor hoist23 distributor9)
  (available hoist23)
  (at_hoist_distributor hoist24 distributor10)
  (available hoist24)
  (at_hoist_distributor hoist25 distributor11)
  (available hoist25)
  (at_hoist_distributor hoist26 distributor12)
  (available hoist26)
  (at_hoist_distributor hoist27 distributor13)
  (available hoist27)
  (at_crate_distributor crate0 distributor1)
  (on_pallet crate0 pallet15)
  (at_crate_depot crate1 depot10)
  (on_pallet crate1 pallet10)
  (at_crate_distributor crate2 distributor11)
  (on_pallet crate2 pallet25)
  (at_crate_depot crate3 depot10)
  (on_crate crate3 crate1)
  (at_crate_depot crate4 depot11)
  (on_pallet crate4 pallet11)
  (at_crate_depot crate5 depot7)
  (on_pallet crate5 pallet7)
  (at_crate_distributor crate6 distributor4)
  (on_pallet crate6 pallet18)
  (at_crate_depot crate7 depot10)
  (on_crate crate7 crate3)
  (at_crate_distributor crate8 distributor9)
  (on_pallet crate8 pallet23)
  (at_crate_depot crate9 depot3)
  (on_pallet crate9 pallet3)
  (at_crate_distributor crate10 distributor8)
  (on_pallet crate10 pallet22)
  (at_crate_distributor crate11 distributor2)
  (on_pallet crate11 pallet16)
  (at_crate_depot crate12 depot12)
  (on_pallet crate12 pallet12)
  (at_crate_distributor crate13 distributor1)
  (on_crate crate13 crate0)
  (at_crate_depot crate14 depot4)
  (on_pallet crate14 pallet4)
  (at_crate_distributor crate15 distributor5)
  (on_pallet crate15 pallet19)
  (at_crate_distributor crate16 distributor1)
  (on_crate crate16 crate13)
  (at_crate_distributor crate17 distributor11)
  (on_crate crate17 crate2)
  (at_crate_distributor crate18 distributor13)
  (on_pallet crate18 pallet27)
  (at_crate_distributor crate19 distributor2)
  (on_crate crate19 crate11)
  (at_crate_depot crate20 depot0)
  (on_pallet crate20 pallet0)
  (at_crate_distributor crate21 distributor0)
  (on_pallet crate21 pallet14)
  (at_crate_distributor crate22 distributor0)
  (on_crate crate22 crate21)
  (at_crate_distributor crate23 distributor12)
  (on_pallet crate23 pallet26)
  (at_crate_distributor crate24 distributor2)
  (on_crate crate24 crate19)
  (at_crate_depot crate25 depot6)
  (on_pallet crate25 pallet6)
  (at_crate_depot crate26 depot10)
  (on_crate crate26 crate7)
  (at_crate_distributor crate27 distributor12)
  (on_crate crate27 crate23)
  (at_crate_depot crate28 depot6)
  (on_crate crate28 crate25)
  (at_crate_distributor crate29 distributor0)
  (on_crate crate29 crate22)
  (at_crate_depot crate30 depot11)
  (on_crate crate30 crate4)
  (at_crate_depot crate31 depot3)
  (on_crate crate31 crate9)
  (at_crate_depot crate32 depot7)
  (on_crate crate32 crate5)
  (at_crate_depot crate33 depot11)
  (on_crate crate33 crate30)
  (at_crate_depot crate34 depot8)
  (on_pallet crate34 pallet8)
  (at_crate_distributor crate35 distributor3)
  (on_pallet crate35 pallet17)
  (at_crate_distributor crate36 distributor9)
  (on_crate crate36 crate8)
  (at_crate_depot crate37 depot0)
  (on_crate crate37 crate20)
  (at_crate_depot crate38 depot1)
  (on_pallet crate38 pallet1)
  (at_crate_distributor crate39 distributor5)
  (on_crate crate39 crate15)
  (at_crate_distributor crate40 distributor13)
  (on_crate crate40 crate18)
  (at_crate_depot crate41 depot1)
  (on_crate crate41 crate38)
)
(:goal   (and (on_pallet crate0 pallet4)
  (on_crate crate1 crate31)
  (on_pallet crate2 pallet1)
  (on_pallet crate3 pallet12)
  (on_pallet crate4 pallet6)
  (on_pallet crate5 pallet26)
  (on_crate crate6 crate41)
  (on_crate crate7 crate40)
  (on_crate crate8 crate10)
  (on_crate crate10 crate34)
  (on_pallet crate11 pallet11)
  (on_pallet crate12 pallet14)
  (on_crate crate13 crate20)
  (on_pallet crate14 pallet22)
  (on_pallet crate15 pallet20)
  (on_pallet crate16 pallet2)
  (on_crate crate17 crate22)
  (on_crate crate19 crate37)
  (on_pallet crate20 pallet5)
  (on_crate crate21 crate15)
  (on_crate crate22 crate4)
  (on_pallet crate23 pallet10)
  (on_pallet crate25 pallet21)
  (on_pallet crate27 pallet27)
  (on_pallet crate28 pallet9)
  (on_pallet crate29 pallet8)
  (on_crate crate30 crate13)
  (on_pallet crate31 pallet7)
  (on_crate crate32 crate14)
  (on_pallet crate34 pallet25)
  (on_crate crate35 crate23)
  (on_crate crate36 crate27)
  (on_pallet crate37 pallet24)
  (on_crate crate38 crate28)
  (on_pallet crate39 pallet19)
  (on_pallet crate40 pallet13)
  (on_crate crate41 crate2)))
)
