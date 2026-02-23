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
  content-0-0 - CONTENT-PORTION
  content-0-1 - CONTENT-PORTION
  content-0-2 - CONTENT-PORTION
  content-0-3 - CONTENT-PORTION
  content-0-4 - CONTENT-PORTION
  content-0-5 - CONTENT-PORTION
  content-0-6 - CONTENT-PORTION
  content-0-7 - CONTENT-PORTION
  content-0-8 - CONTENT-PORTION
  content-0-9 - CONTENT-PORTION
  content-0-10 - CONTENT-PORTION
  content-0-11 - CONTENT-PORTION
  content-0-12 - CONTENT-PORTION
  content-0-13 - CONTENT-PORTION
  content-1-0 - CONTENT-PORTION
  content-1-1 - CONTENT-PORTION
  content-1-2 - CONTENT-PORTION
  content-1-3 - CONTENT-PORTION
  content-1-4 - CONTENT-PORTION
  content-1-5 - CONTENT-PORTION
  content-1-6 - CONTENT-PORTION
  content-1-7 - CONTENT-PORTION
  content-1-8 - CONTENT-PORTION
  content-1-9 - CONTENT-PORTION
  content-1-10 - CONTENT-PORTION
  content-1-11 - CONTENT-PORTION
  content-1-12 - CONTENT-PORTION
  content-1-13 - CONTENT-PORTION
  content-1-14 - CONTENT-PORTION
  content-1-15 - CONTENT-PORTION
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
  (at_kitchen_content content-0-2)
  (at_kitchen_content content-0-3)
  (at_kitchen_content content-0-4)
  (at_kitchen_content content-0-5)
  (at_kitchen_content content-0-6)
  (at_kitchen_content content-0-7)
  (at_kitchen_content content-0-8)
  (at_kitchen_content content-0-9)
  (at_kitchen_content content-0-10)
  (at_kitchen_content content-0-11)
  (at_kitchen_content content-0-12)
  (at_kitchen_content content-0-13)
  (at_kitchen_content content-1-0)
  (at_kitchen_content content-1-1)
  (at_kitchen_content content-1-2)
  (at_kitchen_content content-1-3)
  (at_kitchen_content content-1-4)
  (at_kitchen_content content-1-5)
  (at_kitchen_content content-1-6)
  (at_kitchen_content content-1-7)
  (at_kitchen_content content-1-8)
  (at_kitchen_content content-1-9)
  (at_kitchen_content content-1-10)
  (at_kitchen_content content-1-11)
  (at_kitchen_content content-1-12)
  (at_kitchen_content content-1-13)
  (at_kitchen_content content-1-14)
  (at_kitchen_content content-1-15)
  (descr content-0-0 content-0)
  (descr content-0-1 content-0)
  (descr content-0-2 content-0)
  (descr content-0-3 content-0)
  (descr content-0-4 content-0)
  (descr content-0-5 content-0)
  (descr content-0-6 content-0)
  (descr content-0-7 content-0)
  (descr content-0-8 content-0)
  (descr content-0-9 content-0)
  (descr content-0-10 content-0)
  (descr content-0-11 content-0)
  (descr content-0-12 content-0)
  (descr content-0-13 content-0)
  (descr content-1-0 content-1)
  (descr content-1-1 content-1)
  (descr content-1-2 content-1)
  (descr content-1-3 content-1)
  (descr content-1-4 content-1)
  (descr content-1-5 content-1)
  (descr content-1-6 content-1)
  (descr content-1-7 content-1)
  (descr content-1-8 content-1)
  (descr content-1-9 content-1)
  (descr content-1-10 content-1)
  (descr content-1-11 content-1)
  (descr content-1-12 content-1)
  (descr content-1-13 content-1)
  (descr content-1-14 content-1)
  (descr content-1-15 content-1)
  (likes child2 content-1)
  (likes child1 content-0)
  (likes child0 content-0)
  (likes child2 content-0)
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
