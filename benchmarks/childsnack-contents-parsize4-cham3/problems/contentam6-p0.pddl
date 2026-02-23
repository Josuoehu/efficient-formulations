(define (problem example-problem)
(:domain htg-child-snack)
(:objects 
  child0 - CHILD
  child1 - CHILD
  child2 - CHILD
  bread0 - BREAD-PORTION
  bread1 - BREAD-PORTION
  bread2 - BREAD-PORTION
  content-0 - CONTENT-DESCRIPTION
  content-1 - CONTENT-DESCRIPTION
  content-2 - CONTENT-DESCRIPTION
  content-3 - CONTENT-DESCRIPTION
  content-4 - CONTENT-DESCRIPTION
  content-5 - CONTENT-DESCRIPTION
  content-0-0 - CONTENT-PORTION
  content-0-1 - CONTENT-PORTION
  content-1-0 - CONTENT-PORTION
  content-1-1 - CONTENT-PORTION
  content-2-0 - CONTENT-PORTION
  content-2-1 - CONTENT-PORTION
  content-3-0 - CONTENT-PORTION
  content-3-1 - CONTENT-PORTION
  content-4-0 - CONTENT-PORTION
  content-4-1 - CONTENT-PORTION
  content-5-0 - CONTENT-PORTION
  content-5-1 - CONTENT-PORTION
  tray0 - TRAY
  tray1 - TRAY
  tray2 - TRAY
  table0 - PLACE
  table1 - PLACE
  table2 - PLACE
  table3 - PLACE
  table4 - PLACE
  sandw0 - SANDWICH
  sandw1 - SANDWICH
  sandw2 - SANDWICH
)
(:init
  (at tray0 kitchen)
  (at tray1 kitchen)
  (at tray2 kitchen)
  (at_kitchen_bread bread0)
  (at_kitchen_bread bread1)
  (at_kitchen_bread bread2)
  (at_kitchen_content content-0-0)
  (at_kitchen_content content-0-1)
  (at_kitchen_content content-1-0)
  (at_kitchen_content content-1-1)
  (at_kitchen_content content-2-0)
  (at_kitchen_content content-2-1)
  (at_kitchen_content content-3-0)
  (at_kitchen_content content-3-1)
  (at_kitchen_content content-4-0)
  (at_kitchen_content content-4-1)
  (at_kitchen_content content-5-0)
  (at_kitchen_content content-5-1)
  (descr content-0-0 content-0)
  (descr content-0-1 content-0)
  (descr content-1-0 content-1)
  (descr content-1-1 content-1)
  (descr content-2-0 content-2)
  (descr content-2-1 content-2)
  (descr content-3-0 content-3)
  (descr content-3-1 content-3)
  (descr content-4-0 content-4)
  (descr content-4-1 content-4)
  (descr content-5-0 content-5)
  (descr content-5-1 content-5)
  (likes child2 content-3)
  (likes child0 content-5)
  (likes child2 content-4)
  (likes child1 content-0)
  (likes child2 content-5)
  (likes child1 content-2)
  (likes child0 content-0)
  (likes child0 content-3)
  (likes child2 content-2)
  (likes child1 content-4)
  (likes child1 content-1)
  (likes child0 content-1)
  (waiting child0 table0)
  (waiting child1 table1)
  (waiting child2 table2)
  (notexist sandw0)
  (notexist sandw1)
  (notexist sandw2)
)
(:goal   (and (served child0)
  (served child1)
  (served child2)))
)
