(define (problem example-problem)
(:domain htg-child-snack)
(:objects 
  child0 - CHILD
  child1 - CHILD
  child2 - CHILD
  child3 - CHILD
  child4 - CHILD
  bread0 - BREAD-PORTION
  bread1 - BREAD-PORTION
  bread2 - BREAD-PORTION
  bread3 - BREAD-PORTION
  bread4 - BREAD-PORTION
  content-0 - CONTENT-DESCRIPTION
  content-1 - CONTENT-DESCRIPTION
  content-2 - CONTENT-DESCRIPTION
  content-3 - CONTENT-DESCRIPTION
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
  content-0-14 - CONTENT-PORTION
  content-0-15 - CONTENT-PORTION
  content-0-16 - CONTENT-PORTION
  content-0-17 - CONTENT-PORTION
  content-0-18 - CONTENT-PORTION
  content-0-19 - CONTENT-PORTION
  content-0-20 - CONTENT-PORTION
  content-0-21 - CONTENT-PORTION
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
  content-2-0 - CONTENT-PORTION
  content-2-1 - CONTENT-PORTION
  content-2-2 - CONTENT-PORTION
  content-2-3 - CONTENT-PORTION
  content-2-4 - CONTENT-PORTION
  content-2-5 - CONTENT-PORTION
  content-2-6 - CONTENT-PORTION
  content-2-7 - CONTENT-PORTION
  content-2-8 - CONTENT-PORTION
  content-2-9 - CONTENT-PORTION
  content-2-10 - CONTENT-PORTION
  content-2-11 - CONTENT-PORTION
  content-2-12 - CONTENT-PORTION
  content-3-0 - CONTENT-PORTION
  content-3-1 - CONTENT-PORTION
  content-3-2 - CONTENT-PORTION
  content-3-3 - CONTENT-PORTION
  content-3-4 - CONTENT-PORTION
  content-3-5 - CONTENT-PORTION
  content-3-6 - CONTENT-PORTION
  content-3-7 - CONTENT-PORTION
  content-3-8 - CONTENT-PORTION
  content-3-9 - CONTENT-PORTION
  content-3-10 - CONTENT-PORTION
  content-3-11 - CONTENT-PORTION
  content-3-12 - CONTENT-PORTION
  content-3-13 - CONTENT-PORTION
  content-3-14 - CONTENT-PORTION
  content-3-15 - CONTENT-PORTION
  content-3-16 - CONTENT-PORTION
  content-3-17 - CONTENT-PORTION
  content-3-18 - CONTENT-PORTION
  content-3-19 - CONTENT-PORTION
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
  sandw3 - SANDWICH
  sandw4 - SANDWICH
)
(:init
  (at tray0 kitchen)
  (at tray1 kitchen)
  (at tray2 kitchen)
  (at_kitchen_bread bread0)
  (at_kitchen_bread bread1)
  (at_kitchen_bread bread2)
  (at_kitchen_bread bread3)
  (at_kitchen_bread bread4)
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
  (at_kitchen_content content-0-14)
  (at_kitchen_content content-0-15)
  (at_kitchen_content content-0-16)
  (at_kitchen_content content-0-17)
  (at_kitchen_content content-0-18)
  (at_kitchen_content content-0-19)
  (at_kitchen_content content-0-20)
  (at_kitchen_content content-0-21)
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
  (at_kitchen_content content-2-0)
  (at_kitchen_content content-2-1)
  (at_kitchen_content content-2-2)
  (at_kitchen_content content-2-3)
  (at_kitchen_content content-2-4)
  (at_kitchen_content content-2-5)
  (at_kitchen_content content-2-6)
  (at_kitchen_content content-2-7)
  (at_kitchen_content content-2-8)
  (at_kitchen_content content-2-9)
  (at_kitchen_content content-2-10)
  (at_kitchen_content content-2-11)
  (at_kitchen_content content-2-12)
  (at_kitchen_content content-3-0)
  (at_kitchen_content content-3-1)
  (at_kitchen_content content-3-2)
  (at_kitchen_content content-3-3)
  (at_kitchen_content content-3-4)
  (at_kitchen_content content-3-5)
  (at_kitchen_content content-3-6)
  (at_kitchen_content content-3-7)
  (at_kitchen_content content-3-8)
  (at_kitchen_content content-3-9)
  (at_kitchen_content content-3-10)
  (at_kitchen_content content-3-11)
  (at_kitchen_content content-3-12)
  (at_kitchen_content content-3-13)
  (at_kitchen_content content-3-14)
  (at_kitchen_content content-3-15)
  (at_kitchen_content content-3-16)
  (at_kitchen_content content-3-17)
  (at_kitchen_content content-3-18)
  (at_kitchen_content content-3-19)
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
  (descr content-0-14 content-0)
  (descr content-0-15 content-0)
  (descr content-0-16 content-0)
  (descr content-0-17 content-0)
  (descr content-0-18 content-0)
  (descr content-0-19 content-0)
  (descr content-0-20 content-0)
  (descr content-0-21 content-0)
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
  (descr content-2-0 content-2)
  (descr content-2-1 content-2)
  (descr content-2-2 content-2)
  (descr content-2-3 content-2)
  (descr content-2-4 content-2)
  (descr content-2-5 content-2)
  (descr content-2-6 content-2)
  (descr content-2-7 content-2)
  (descr content-2-8 content-2)
  (descr content-2-9 content-2)
  (descr content-2-10 content-2)
  (descr content-2-11 content-2)
  (descr content-2-12 content-2)
  (descr content-3-0 content-3)
  (descr content-3-1 content-3)
  (descr content-3-2 content-3)
  (descr content-3-3 content-3)
  (descr content-3-4 content-3)
  (descr content-3-5 content-3)
  (descr content-3-6 content-3)
  (descr content-3-7 content-3)
  (descr content-3-8 content-3)
  (descr content-3-9 content-3)
  (descr content-3-10 content-3)
  (descr content-3-11 content-3)
  (descr content-3-12 content-3)
  (descr content-3-13 content-3)
  (descr content-3-14 content-3)
  (descr content-3-15 content-3)
  (descr content-3-16 content-3)
  (descr content-3-17 content-3)
  (descr content-3-18 content-3)
  (descr content-3-19 content-3)
  (likes child4 content-3)
  (likes child0 content-0)
  (likes child0 content-2)
  (likes child0 content-3)
  (likes child3 content-3)
  (likes child4 content-1)
  (likes child3 content-1)
  (likes child2 content-1)
  (likes child4 content-0)
  (likes child4 content-2)
  (likes child2 content-2)
  (likes child2 content-0)
  (likes child1 content-1)
  (likes child2 content-3)
  (likes child3 content-2)
  (likes child3 content-0)
  (likes child1 content-0)
  (likes child1 content-2)
  (likes child1 content-3)
  (likes child0 content-1)
  (waiting child0 table0)
  (waiting child1 table1)
  (waiting child2 table2)
  (waiting child3 table3)
  (waiting child4 table4)
  (notexist sandw0)
  (notexist sandw1)
  (notexist sandw2)
  (notexist sandw3)
  (notexist sandw4)
)
(:goal   (and (served child0)
  (served child1)
  (served child2)
  (served child3)
  (served child4)))
)
