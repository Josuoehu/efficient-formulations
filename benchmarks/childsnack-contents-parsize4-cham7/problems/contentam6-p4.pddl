(define (problem example-problem)
(:domain htg-child-snack)
(:objects 
  child0 - CHILD
  child1 - CHILD
  child2 - CHILD
  child3 - CHILD
  child4 - CHILD
  child5 - CHILD
  child6 - CHILD
  bread0 - BREAD-PORTION
  bread1 - BREAD-PORTION
  bread2 - BREAD-PORTION
  bread3 - BREAD-PORTION
  bread4 - BREAD-PORTION
  bread5 - BREAD-PORTION
  bread6 - BREAD-PORTION
  content-0 - CONTENT-DESCRIPTION
  content-1 - CONTENT-DESCRIPTION
  content-2 - CONTENT-DESCRIPTION
  content-3 - CONTENT-DESCRIPTION
  content-4 - CONTENT-DESCRIPTION
  content-5 - CONTENT-DESCRIPTION
  content-0-0 - CONTENT-PORTION
  content-0-1 - CONTENT-PORTION
  content-0-2 - CONTENT-PORTION
  content-0-3 - CONTENT-PORTION
  content-0-4 - CONTENT-PORTION
  content-0-5 - CONTENT-PORTION
  content-0-6 - CONTENT-PORTION
  content-0-7 - CONTENT-PORTION
  content-0-8 - CONTENT-PORTION
  content-1-0 - CONTENT-PORTION
  content-1-1 - CONTENT-PORTION
  content-1-2 - CONTENT-PORTION
  content-1-3 - CONTENT-PORTION
  content-1-4 - CONTENT-PORTION
  content-1-5 - CONTENT-PORTION
  content-1-6 - CONTENT-PORTION
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
  content-4-0 - CONTENT-PORTION
  content-4-1 - CONTENT-PORTION
  content-4-2 - CONTENT-PORTION
  content-4-3 - CONTENT-PORTION
  content-4-4 - CONTENT-PORTION
  content-4-5 - CONTENT-PORTION
  content-4-6 - CONTENT-PORTION
  content-4-7 - CONTENT-PORTION
  content-5-0 - CONTENT-PORTION
  content-5-1 - CONTENT-PORTION
  content-5-2 - CONTENT-PORTION
  content-5-3 - CONTENT-PORTION
  content-5-4 - CONTENT-PORTION
  content-5-5 - CONTENT-PORTION
  content-5-6 - CONTENT-PORTION
  content-5-7 - CONTENT-PORTION
  content-5-8 - CONTENT-PORTION
  content-5-9 - CONTENT-PORTION
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
  sandw5 - SANDWICH
  sandw6 - SANDWICH
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
  (at_kitchen_bread bread5)
  (at_kitchen_bread bread6)
  (at_kitchen_content content-0-0)
  (at_kitchen_content content-0-1)
  (at_kitchen_content content-0-2)
  (at_kitchen_content content-0-3)
  (at_kitchen_content content-0-4)
  (at_kitchen_content content-0-5)
  (at_kitchen_content content-0-6)
  (at_kitchen_content content-0-7)
  (at_kitchen_content content-0-8)
  (at_kitchen_content content-1-0)
  (at_kitchen_content content-1-1)
  (at_kitchen_content content-1-2)
  (at_kitchen_content content-1-3)
  (at_kitchen_content content-1-4)
  (at_kitchen_content content-1-5)
  (at_kitchen_content content-1-6)
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
  (at_kitchen_content content-4-0)
  (at_kitchen_content content-4-1)
  (at_kitchen_content content-4-2)
  (at_kitchen_content content-4-3)
  (at_kitchen_content content-4-4)
  (at_kitchen_content content-4-5)
  (at_kitchen_content content-4-6)
  (at_kitchen_content content-4-7)
  (at_kitchen_content content-5-0)
  (at_kitchen_content content-5-1)
  (at_kitchen_content content-5-2)
  (at_kitchen_content content-5-3)
  (at_kitchen_content content-5-4)
  (at_kitchen_content content-5-5)
  (at_kitchen_content content-5-6)
  (at_kitchen_content content-5-7)
  (at_kitchen_content content-5-8)
  (at_kitchen_content content-5-9)
  (descr content-0-0 content-0)
  (descr content-0-1 content-0)
  (descr content-0-2 content-0)
  (descr content-0-3 content-0)
  (descr content-0-4 content-0)
  (descr content-0-5 content-0)
  (descr content-0-6 content-0)
  (descr content-0-7 content-0)
  (descr content-0-8 content-0)
  (descr content-1-0 content-1)
  (descr content-1-1 content-1)
  (descr content-1-2 content-1)
  (descr content-1-3 content-1)
  (descr content-1-4 content-1)
  (descr content-1-5 content-1)
  (descr content-1-6 content-1)
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
  (descr content-4-0 content-4)
  (descr content-4-1 content-4)
  (descr content-4-2 content-4)
  (descr content-4-3 content-4)
  (descr content-4-4 content-4)
  (descr content-4-5 content-4)
  (descr content-4-6 content-4)
  (descr content-4-7 content-4)
  (descr content-5-0 content-5)
  (descr content-5-1 content-5)
  (descr content-5-2 content-5)
  (descr content-5-3 content-5)
  (descr content-5-4 content-5)
  (descr content-5-5 content-5)
  (descr content-5-6 content-5)
  (descr content-5-7 content-5)
  (descr content-5-8 content-5)
  (descr content-5-9 content-5)
  (likes child1 content-5)
  (likes child4 content-3)
  (likes child0 content-0)
  (likes child0 content-2)
  (likes child6 content-5)
  (likes child0 content-3)
  (likes child3 content-5)
  (likes child6 content-2)
  (likes child1 content-4)
  (likes child6 content-0)
  (likes child3 content-3)
  (likes child4 content-1)
  (likes child4 content-4)
  (likes child0 content-5)
  (likes child6 content-3)
  (likes child5 content-0)
  (likes child5 content-2)
  (likes child3 content-1)
  (likes child5 content-4)
  (likes child2 content-1)
  (likes child2 content-4)
  (likes child4 content-2)
  (likes child4 content-0)
  (likes child2 content-2)
  (likes child2 content-0)
  (likes child5 content-5)
  (likes child1 content-1)
  (likes child2 content-3)
  (likes child6 content-1)
  (likes child3 content-2)
  (likes child3 content-0)
  (likes child1 content-2)
  (likes child6 content-4)
  (likes child2 content-5)
  (likes child5 content-3)
  (likes child1 content-0)
  (likes child3 content-4)
  (likes child1 content-3)
  (likes child4 content-5)
  (likes child0 content-1)
  (likes child5 content-1)
  (likes child0 content-4)
  (waiting child0 table0)
  (waiting child1 table1)
  (waiting child2 table2)
  (waiting child3 table3)
  (waiting child4 table4)
  (waiting child5 table0)
  (waiting child6 table1)
  (notexist sandw0)
  (notexist sandw1)
  (notexist sandw2)
  (notexist sandw3)
  (notexist sandw4)
  (notexist sandw5)
  (notexist sandw6)
)
(:goal   (and (served child0)
  (served child1)
  (served child2)
  (served child3)
  (served child4)
  (served child5)
  (served child6)))
)
