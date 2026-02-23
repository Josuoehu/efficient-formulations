(define (problem p154-microban-sequential)
(:domain sokoban-sequential)
(:objects 
  dir-down - DIRECTION
  dir-left - DIRECTION
  dir-right - DIRECTION
  dir-up - DIRECTION
  player-01 - PLAYER
  pos-01-01 - LOCATION
  pos-01-02 - LOCATION
  pos-01-03 - LOCATION
  pos-01-04 - LOCATION
  pos-01-05 - LOCATION
  pos-01-06 - LOCATION
  pos-01-07 - LOCATION
  pos-01-08 - LOCATION
  pos-01-09 - LOCATION
  pos-01-10 - LOCATION
  pos-01-11 - LOCATION
  pos-01-12 - LOCATION
  pos-01-13 - LOCATION
  pos-01-14 - LOCATION
  pos-01-15 - LOCATION
  pos-01-16 - LOCATION
  pos-01-17 - LOCATION
  pos-02-01 - LOCATION
  pos-02-02 - LOCATION
  pos-02-03 - LOCATION
  pos-02-04 - LOCATION
  pos-02-05 - LOCATION
  pos-02-06 - LOCATION
  pos-02-07 - LOCATION
  pos-02-08 - LOCATION
  pos-02-09 - LOCATION
  pos-02-10 - LOCATION
  pos-02-11 - LOCATION
  pos-02-12 - LOCATION
  pos-02-13 - LOCATION
  pos-02-14 - LOCATION
  pos-02-15 - LOCATION
  pos-02-16 - LOCATION
  pos-02-17 - LOCATION
  pos-03-01 - LOCATION
  pos-03-02 - LOCATION
  pos-03-03 - LOCATION
  pos-03-04 - LOCATION
  pos-03-05 - LOCATION
  pos-03-06 - LOCATION
  pos-03-07 - LOCATION
  pos-03-08 - LOCATION
  pos-03-09 - LOCATION
  pos-03-10 - LOCATION
  pos-03-11 - LOCATION
  pos-03-12 - LOCATION
  pos-03-13 - LOCATION
  pos-03-14 - LOCATION
  pos-03-15 - LOCATION
  pos-03-16 - LOCATION
  pos-03-17 - LOCATION
  pos-04-01 - LOCATION
  pos-04-02 - LOCATION
  pos-04-03 - LOCATION
  pos-04-04 - LOCATION
  pos-04-05 - LOCATION
  pos-04-06 - LOCATION
  pos-04-07 - LOCATION
  pos-04-08 - LOCATION
  pos-04-09 - LOCATION
  pos-04-10 - LOCATION
  pos-04-11 - LOCATION
  pos-04-12 - LOCATION
  pos-04-13 - LOCATION
  pos-04-14 - LOCATION
  pos-04-15 - LOCATION
  pos-04-16 - LOCATION
  pos-04-17 - LOCATION
  pos-05-01 - LOCATION
  pos-05-02 - LOCATION
  pos-05-03 - LOCATION
  pos-05-04 - LOCATION
  pos-05-05 - LOCATION
  pos-05-06 - LOCATION
  pos-05-07 - LOCATION
  pos-05-08 - LOCATION
  pos-05-09 - LOCATION
  pos-05-10 - LOCATION
  pos-05-11 - LOCATION
  pos-05-12 - LOCATION
  pos-05-13 - LOCATION
  pos-05-14 - LOCATION
  pos-05-15 - LOCATION
  pos-05-16 - LOCATION
  pos-05-17 - LOCATION
  pos-06-01 - LOCATION
  pos-06-02 - LOCATION
  pos-06-03 - LOCATION
  pos-06-04 - LOCATION
  pos-06-05 - LOCATION
  pos-06-06 - LOCATION
  pos-06-07 - LOCATION
  pos-06-08 - LOCATION
  pos-06-09 - LOCATION
  pos-06-10 - LOCATION
  pos-06-11 - LOCATION
  pos-06-12 - LOCATION
  pos-06-13 - LOCATION
  pos-06-14 - LOCATION
  pos-06-15 - LOCATION
  pos-06-16 - LOCATION
  pos-06-17 - LOCATION
  pos-07-01 - LOCATION
  pos-07-02 - LOCATION
  pos-07-03 - LOCATION
  pos-07-04 - LOCATION
  pos-07-05 - LOCATION
  pos-07-06 - LOCATION
  pos-07-07 - LOCATION
  pos-07-08 - LOCATION
  pos-07-09 - LOCATION
  pos-07-10 - LOCATION
  pos-07-11 - LOCATION
  pos-07-12 - LOCATION
  pos-07-13 - LOCATION
  pos-07-14 - LOCATION
  pos-07-15 - LOCATION
  pos-07-16 - LOCATION
  pos-07-17 - LOCATION
  pos-08-01 - LOCATION
  pos-08-02 - LOCATION
  pos-08-03 - LOCATION
  pos-08-04 - LOCATION
  pos-08-05 - LOCATION
  pos-08-06 - LOCATION
  pos-08-07 - LOCATION
  pos-08-08 - LOCATION
  pos-08-09 - LOCATION
  pos-08-10 - LOCATION
  pos-08-11 - LOCATION
  pos-08-12 - LOCATION
  pos-08-13 - LOCATION
  pos-08-14 - LOCATION
  pos-08-15 - LOCATION
  pos-08-16 - LOCATION
  pos-08-17 - LOCATION
  pos-09-01 - LOCATION
  pos-09-02 - LOCATION
  pos-09-03 - LOCATION
  pos-09-04 - LOCATION
  pos-09-05 - LOCATION
  pos-09-06 - LOCATION
  pos-09-07 - LOCATION
  pos-09-08 - LOCATION
  pos-09-09 - LOCATION
  pos-09-10 - LOCATION
  pos-09-11 - LOCATION
  pos-09-12 - LOCATION
  pos-09-13 - LOCATION
  pos-09-14 - LOCATION
  pos-09-15 - LOCATION
  pos-09-16 - LOCATION
  pos-09-17 - LOCATION
  pos-10-01 - LOCATION
  pos-10-02 - LOCATION
  pos-10-03 - LOCATION
  pos-10-04 - LOCATION
  pos-10-05 - LOCATION
  pos-10-06 - LOCATION
  pos-10-07 - LOCATION
  pos-10-08 - LOCATION
  pos-10-09 - LOCATION
  pos-10-10 - LOCATION
  pos-10-11 - LOCATION
  pos-10-12 - LOCATION
  pos-10-13 - LOCATION
  pos-10-14 - LOCATION
  pos-10-15 - LOCATION
  pos-10-16 - LOCATION
  pos-10-17 - LOCATION
  pos-11-01 - LOCATION
  pos-11-02 - LOCATION
  pos-11-03 - LOCATION
  pos-11-04 - LOCATION
  pos-11-05 - LOCATION
  pos-11-06 - LOCATION
  pos-11-07 - LOCATION
  pos-11-08 - LOCATION
  pos-11-09 - LOCATION
  pos-11-10 - LOCATION
  pos-11-11 - LOCATION
  pos-11-12 - LOCATION
  pos-11-13 - LOCATION
  pos-11-14 - LOCATION
  pos-11-15 - LOCATION
  pos-11-16 - LOCATION
  pos-11-17 - LOCATION
  pos-12-01 - LOCATION
  pos-12-02 - LOCATION
  pos-12-03 - LOCATION
  pos-12-04 - LOCATION
  pos-12-05 - LOCATION
  pos-12-06 - LOCATION
  pos-12-07 - LOCATION
  pos-12-08 - LOCATION
  pos-12-09 - LOCATION
  pos-12-10 - LOCATION
  pos-12-11 - LOCATION
  pos-12-12 - LOCATION
  pos-12-13 - LOCATION
  pos-12-14 - LOCATION
  pos-12-15 - LOCATION
  pos-12-16 - LOCATION
  pos-12-17 - LOCATION
  pos-13-01 - LOCATION
  pos-13-02 - LOCATION
  pos-13-03 - LOCATION
  pos-13-04 - LOCATION
  pos-13-05 - LOCATION
  pos-13-06 - LOCATION
  pos-13-07 - LOCATION
  pos-13-08 - LOCATION
  pos-13-09 - LOCATION
  pos-13-10 - LOCATION
  pos-13-11 - LOCATION
  pos-13-12 - LOCATION
  pos-13-13 - LOCATION
  pos-13-14 - LOCATION
  pos-13-15 - LOCATION
  pos-13-16 - LOCATION
  pos-13-17 - LOCATION
  pos-14-01 - LOCATION
  pos-14-02 - LOCATION
  pos-14-03 - LOCATION
  pos-14-04 - LOCATION
  pos-14-05 - LOCATION
  pos-14-06 - LOCATION
  pos-14-07 - LOCATION
  pos-14-08 - LOCATION
  pos-14-09 - LOCATION
  pos-14-10 - LOCATION
  pos-14-11 - LOCATION
  pos-14-12 - LOCATION
  pos-14-13 - LOCATION
  pos-14-14 - LOCATION
  pos-14-15 - LOCATION
  pos-14-16 - LOCATION
  pos-14-17 - LOCATION
  pos-15-01 - LOCATION
  pos-15-02 - LOCATION
  pos-15-03 - LOCATION
  pos-15-04 - LOCATION
  pos-15-05 - LOCATION
  pos-15-06 - LOCATION
  pos-15-07 - LOCATION
  pos-15-08 - LOCATION
  pos-15-09 - LOCATION
  pos-15-10 - LOCATION
  pos-15-11 - LOCATION
  pos-15-12 - LOCATION
  pos-15-13 - LOCATION
  pos-15-14 - LOCATION
  pos-15-15 - LOCATION
  pos-15-16 - LOCATION
  pos-15-17 - LOCATION
  pos-16-01 - LOCATION
  pos-16-02 - LOCATION
  pos-16-03 - LOCATION
  pos-16-04 - LOCATION
  pos-16-05 - LOCATION
  pos-16-06 - LOCATION
  pos-16-07 - LOCATION
  pos-16-08 - LOCATION
  pos-16-09 - LOCATION
  pos-16-10 - LOCATION
  pos-16-11 - LOCATION
  pos-16-12 - LOCATION
  pos-16-13 - LOCATION
  pos-16-14 - LOCATION
  pos-16-15 - LOCATION
  pos-16-16 - LOCATION
  pos-16-17 - LOCATION
  pos-17-01 - LOCATION
  pos-17-02 - LOCATION
  pos-17-03 - LOCATION
  pos-17-04 - LOCATION
  pos-17-05 - LOCATION
  pos-17-06 - LOCATION
  pos-17-07 - LOCATION
  pos-17-08 - LOCATION
  pos-17-09 - LOCATION
  pos-17-10 - LOCATION
  pos-17-11 - LOCATION
  pos-17-12 - LOCATION
  pos-17-13 - LOCATION
  pos-17-14 - LOCATION
  pos-17-15 - LOCATION
  pos-17-16 - LOCATION
  pos-17-17 - LOCATION
  pos-18-01 - LOCATION
  pos-18-02 - LOCATION
  pos-18-03 - LOCATION
  pos-18-04 - LOCATION
  pos-18-05 - LOCATION
  pos-18-06 - LOCATION
  pos-18-07 - LOCATION
  pos-18-08 - LOCATION
  pos-18-09 - LOCATION
  pos-18-10 - LOCATION
  pos-18-11 - LOCATION
  pos-18-12 - LOCATION
  pos-18-13 - LOCATION
  pos-18-14 - LOCATION
  pos-18-15 - LOCATION
  pos-18-16 - LOCATION
  pos-18-17 - LOCATION
  pos-19-01 - LOCATION
  pos-19-02 - LOCATION
  pos-19-03 - LOCATION
  pos-19-04 - LOCATION
  pos-19-05 - LOCATION
  pos-19-06 - LOCATION
  pos-19-07 - LOCATION
  pos-19-08 - LOCATION
  pos-19-09 - LOCATION
  pos-19-10 - LOCATION
  pos-19-11 - LOCATION
  pos-19-12 - LOCATION
  pos-19-13 - LOCATION
  pos-19-14 - LOCATION
  pos-19-15 - LOCATION
  pos-19-16 - LOCATION
  pos-19-17 - LOCATION
  pos-20-01 - LOCATION
  pos-20-02 - LOCATION
  pos-20-03 - LOCATION
  pos-20-04 - LOCATION
  pos-20-05 - LOCATION
  pos-20-06 - LOCATION
  pos-20-07 - LOCATION
  pos-20-08 - LOCATION
  pos-20-09 - LOCATION
  pos-20-10 - LOCATION
  pos-20-11 - LOCATION
  pos-20-12 - LOCATION
  pos-20-13 - LOCATION
  pos-20-14 - LOCATION
  pos-20-15 - LOCATION
  pos-20-16 - LOCATION
  pos-20-17 - LOCATION
  pos-21-01 - LOCATION
  pos-21-02 - LOCATION
  pos-21-03 - LOCATION
  pos-21-04 - LOCATION
  pos-21-05 - LOCATION
  pos-21-06 - LOCATION
  pos-21-07 - LOCATION
  pos-21-08 - LOCATION
  pos-21-09 - LOCATION
  pos-21-10 - LOCATION
  pos-21-11 - LOCATION
  pos-21-12 - LOCATION
  pos-21-13 - LOCATION
  pos-21-14 - LOCATION
  pos-21-15 - LOCATION
  pos-21-16 - LOCATION
  pos-21-17 - LOCATION
  pos-22-01 - LOCATION
  pos-22-02 - LOCATION
  pos-22-03 - LOCATION
  pos-22-04 - LOCATION
  pos-22-05 - LOCATION
  pos-22-06 - LOCATION
  pos-22-07 - LOCATION
  pos-22-08 - LOCATION
  pos-22-09 - LOCATION
  pos-22-10 - LOCATION
  pos-22-11 - LOCATION
  pos-22-12 - LOCATION
  pos-22-13 - LOCATION
  pos-22-14 - LOCATION
  pos-22-15 - LOCATION
  pos-22-16 - LOCATION
  pos-22-17 - LOCATION
  pos-23-01 - LOCATION
  pos-23-02 - LOCATION
  pos-23-03 - LOCATION
  pos-23-04 - LOCATION
  pos-23-05 - LOCATION
  pos-23-06 - LOCATION
  pos-23-07 - LOCATION
  pos-23-08 - LOCATION
  pos-23-09 - LOCATION
  pos-23-10 - LOCATION
  pos-23-11 - LOCATION
  pos-23-12 - LOCATION
  pos-23-13 - LOCATION
  pos-23-14 - LOCATION
  pos-23-15 - LOCATION
  pos-23-16 - LOCATION
  pos-23-17 - LOCATION
  pos-24-01 - LOCATION
  pos-24-02 - LOCATION
  pos-24-03 - LOCATION
  pos-24-04 - LOCATION
  pos-24-05 - LOCATION
  pos-24-06 - LOCATION
  pos-24-07 - LOCATION
  pos-24-08 - LOCATION
  pos-24-09 - LOCATION
  pos-24-10 - LOCATION
  pos-24-11 - LOCATION
  pos-24-12 - LOCATION
  pos-24-13 - LOCATION
  pos-24-14 - LOCATION
  pos-24-15 - LOCATION
  pos-24-16 - LOCATION
  pos-24-17 - LOCATION
  pos-25-01 - LOCATION
  pos-25-02 - LOCATION
  pos-25-03 - LOCATION
  pos-25-04 - LOCATION
  pos-25-05 - LOCATION
  pos-25-06 - LOCATION
  pos-25-07 - LOCATION
  pos-25-08 - LOCATION
  pos-25-09 - LOCATION
  pos-25-10 - LOCATION
  pos-25-11 - LOCATION
  pos-25-12 - LOCATION
  pos-25-13 - LOCATION
  pos-25-14 - LOCATION
  pos-25-15 - LOCATION
  pos-25-16 - LOCATION
  pos-25-17 - LOCATION
  pos-26-01 - LOCATION
  pos-26-02 - LOCATION
  pos-26-03 - LOCATION
  pos-26-04 - LOCATION
  pos-26-05 - LOCATION
  pos-26-06 - LOCATION
  pos-26-07 - LOCATION
  pos-26-08 - LOCATION
  pos-26-09 - LOCATION
  pos-26-10 - LOCATION
  pos-26-11 - LOCATION
  pos-26-12 - LOCATION
  pos-26-13 - LOCATION
  pos-26-14 - LOCATION
  pos-26-15 - LOCATION
  pos-26-16 - LOCATION
  pos-26-17 - LOCATION
  pos-27-01 - LOCATION
  pos-27-02 - LOCATION
  pos-27-03 - LOCATION
  pos-27-04 - LOCATION
  pos-27-05 - LOCATION
  pos-27-06 - LOCATION
  pos-27-07 - LOCATION
  pos-27-08 - LOCATION
  pos-27-09 - LOCATION
  pos-27-10 - LOCATION
  pos-27-11 - LOCATION
  pos-27-12 - LOCATION
  pos-27-13 - LOCATION
  pos-27-14 - LOCATION
  pos-27-15 - LOCATION
  pos-27-16 - LOCATION
  pos-27-17 - LOCATION
  pos-28-01 - LOCATION
  pos-28-02 - LOCATION
  pos-28-03 - LOCATION
  pos-28-04 - LOCATION
  pos-28-05 - LOCATION
  pos-28-06 - LOCATION
  pos-28-07 - LOCATION
  pos-28-08 - LOCATION
  pos-28-09 - LOCATION
  pos-28-10 - LOCATION
  pos-28-11 - LOCATION
  pos-28-12 - LOCATION
  pos-28-13 - LOCATION
  pos-28-14 - LOCATION
  pos-28-15 - LOCATION
  pos-28-16 - LOCATION
  pos-28-17 - LOCATION
  pos-29-01 - LOCATION
  pos-29-02 - LOCATION
  pos-29-03 - LOCATION
  pos-29-04 - LOCATION
  pos-29-05 - LOCATION
  pos-29-06 - LOCATION
  pos-29-07 - LOCATION
  pos-29-08 - LOCATION
  pos-29-09 - LOCATION
  pos-29-10 - LOCATION
  pos-29-11 - LOCATION
  pos-29-12 - LOCATION
  pos-29-13 - LOCATION
  pos-29-14 - LOCATION
  pos-29-15 - LOCATION
  pos-29-16 - LOCATION
  pos-29-17 - LOCATION
  stone-01 - STONE
)
(:init
  (is-goal pos-02-16)
  (is-nongoal pos-01-01)
  (is-nongoal pos-01-02)
  (is-nongoal pos-01-03)
  (is-nongoal pos-01-04)
  (is-nongoal pos-01-05)
  (is-nongoal pos-01-06)
  (is-nongoal pos-01-07)
  (is-nongoal pos-01-08)
  (is-nongoal pos-01-09)
  (is-nongoal pos-01-10)
  (is-nongoal pos-01-11)
  (is-nongoal pos-01-12)
  (is-nongoal pos-01-13)
  (is-nongoal pos-01-14)
  (is-nongoal pos-01-15)
  (is-nongoal pos-01-16)
  (is-nongoal pos-01-17)
  (is-nongoal pos-02-01)
  (is-nongoal pos-02-02)
  (is-nongoal pos-02-03)
  (is-nongoal pos-02-04)
  (is-nongoal pos-02-05)
  (is-nongoal pos-02-06)
  (is-nongoal pos-02-07)
  (is-nongoal pos-02-08)
  (is-nongoal pos-02-09)
  (is-nongoal pos-02-10)
  (is-nongoal pos-02-11)
  (is-nongoal pos-02-12)
  (is-nongoal pos-02-13)
  (is-nongoal pos-02-14)
  (is-nongoal pos-02-15)
  (is-nongoal pos-02-17)
  (is-nongoal pos-03-01)
  (is-nongoal pos-03-02)
  (is-nongoal pos-03-03)
  (is-nongoal pos-03-04)
  (is-nongoal pos-03-05)
  (is-nongoal pos-03-06)
  (is-nongoal pos-03-07)
  (is-nongoal pos-03-08)
  (is-nongoal pos-03-09)
  (is-nongoal pos-03-10)
  (is-nongoal pos-03-11)
  (is-nongoal pos-03-12)
  (is-nongoal pos-03-13)
  (is-nongoal pos-03-14)
  (is-nongoal pos-03-15)
  (is-nongoal pos-03-16)
  (is-nongoal pos-03-17)
  (is-nongoal pos-04-01)
  (is-nongoal pos-04-02)
  (is-nongoal pos-04-03)
  (is-nongoal pos-04-04)
  (is-nongoal pos-04-05)
  (is-nongoal pos-04-06)
  (is-nongoal pos-04-07)
  (is-nongoal pos-04-08)
  (is-nongoal pos-04-09)
  (is-nongoal pos-04-10)
  (is-nongoal pos-04-11)
  (is-nongoal pos-04-12)
  (is-nongoal pos-04-13)
  (is-nongoal pos-04-14)
  (is-nongoal pos-04-15)
  (is-nongoal pos-04-16)
  (is-nongoal pos-04-17)
  (is-nongoal pos-05-01)
  (is-nongoal pos-05-02)
  (is-nongoal pos-05-03)
  (is-nongoal pos-05-04)
  (is-nongoal pos-05-05)
  (is-nongoal pos-05-06)
  (is-nongoal pos-05-07)
  (is-nongoal pos-05-08)
  (is-nongoal pos-05-09)
  (is-nongoal pos-05-10)
  (is-nongoal pos-05-11)
  (is-nongoal pos-05-12)
  (is-nongoal pos-05-13)
  (is-nongoal pos-05-14)
  (is-nongoal pos-05-15)
  (is-nongoal pos-05-16)
  (is-nongoal pos-05-17)
  (is-nongoal pos-06-01)
  (is-nongoal pos-06-02)
  (is-nongoal pos-06-03)
  (is-nongoal pos-06-04)
  (is-nongoal pos-06-05)
  (is-nongoal pos-06-06)
  (is-nongoal pos-06-07)
  (is-nongoal pos-06-08)
  (is-nongoal pos-06-09)
  (is-nongoal pos-06-10)
  (is-nongoal pos-06-11)
  (is-nongoal pos-06-12)
  (is-nongoal pos-06-13)
  (is-nongoal pos-06-14)
  (is-nongoal pos-06-15)
  (is-nongoal pos-06-16)
  (is-nongoal pos-06-17)
  (is-nongoal pos-07-01)
  (is-nongoal pos-07-02)
  (is-nongoal pos-07-03)
  (is-nongoal pos-07-04)
  (is-nongoal pos-07-05)
  (is-nongoal pos-07-06)
  (is-nongoal pos-07-07)
  (is-nongoal pos-07-08)
  (is-nongoal pos-07-09)
  (is-nongoal pos-07-10)
  (is-nongoal pos-07-11)
  (is-nongoal pos-07-12)
  (is-nongoal pos-07-13)
  (is-nongoal pos-07-14)
  (is-nongoal pos-07-15)
  (is-nongoal pos-07-16)
  (is-nongoal pos-07-17)
  (is-nongoal pos-08-01)
  (is-nongoal pos-08-02)
  (is-nongoal pos-08-03)
  (is-nongoal pos-08-04)
  (is-nongoal pos-08-05)
  (is-nongoal pos-08-06)
  (is-nongoal pos-08-07)
  (is-nongoal pos-08-08)
  (is-nongoal pos-08-09)
  (is-nongoal pos-08-10)
  (is-nongoal pos-08-11)
  (is-nongoal pos-08-12)
  (is-nongoal pos-08-13)
  (is-nongoal pos-08-14)
  (is-nongoal pos-08-15)
  (is-nongoal pos-08-16)
  (is-nongoal pos-08-17)
  (is-nongoal pos-09-01)
  (is-nongoal pos-09-02)
  (is-nongoal pos-09-03)
  (is-nongoal pos-09-04)
  (is-nongoal pos-09-05)
  (is-nongoal pos-09-06)
  (is-nongoal pos-09-07)
  (is-nongoal pos-09-08)
  (is-nongoal pos-09-09)
  (is-nongoal pos-09-10)
  (is-nongoal pos-09-11)
  (is-nongoal pos-09-12)
  (is-nongoal pos-09-13)
  (is-nongoal pos-09-14)
  (is-nongoal pos-09-15)
  (is-nongoal pos-09-16)
  (is-nongoal pos-09-17)
  (is-nongoal pos-10-01)
  (is-nongoal pos-10-02)
  (is-nongoal pos-10-03)
  (is-nongoal pos-10-04)
  (is-nongoal pos-10-05)
  (is-nongoal pos-10-06)
  (is-nongoal pos-10-07)
  (is-nongoal pos-10-08)
  (is-nongoal pos-10-09)
  (is-nongoal pos-10-10)
  (is-nongoal pos-10-11)
  (is-nongoal pos-10-12)
  (is-nongoal pos-10-13)
  (is-nongoal pos-10-14)
  (is-nongoal pos-10-15)
  (is-nongoal pos-10-16)
  (is-nongoal pos-10-17)
  (is-nongoal pos-11-01)
  (is-nongoal pos-11-02)
  (is-nongoal pos-11-03)
  (is-nongoal pos-11-04)
  (is-nongoal pos-11-05)
  (is-nongoal pos-11-06)
  (is-nongoal pos-11-07)
  (is-nongoal pos-11-08)
  (is-nongoal pos-11-09)
  (is-nongoal pos-11-10)
  (is-nongoal pos-11-11)
  (is-nongoal pos-11-12)
  (is-nongoal pos-11-13)
  (is-nongoal pos-11-14)
  (is-nongoal pos-11-15)
  (is-nongoal pos-11-16)
  (is-nongoal pos-11-17)
  (is-nongoal pos-12-01)
  (is-nongoal pos-12-02)
  (is-nongoal pos-12-03)
  (is-nongoal pos-12-04)
  (is-nongoal pos-12-05)
  (is-nongoal pos-12-06)
  (is-nongoal pos-12-07)
  (is-nongoal pos-12-08)
  (is-nongoal pos-12-09)
  (is-nongoal pos-12-10)
  (is-nongoal pos-12-11)
  (is-nongoal pos-12-12)
  (is-nongoal pos-12-13)
  (is-nongoal pos-12-14)
  (is-nongoal pos-12-15)
  (is-nongoal pos-12-16)
  (is-nongoal pos-12-17)
  (is-nongoal pos-13-01)
  (is-nongoal pos-13-02)
  (is-nongoal pos-13-03)
  (is-nongoal pos-13-04)
  (is-nongoal pos-13-05)
  (is-nongoal pos-13-06)
  (is-nongoal pos-13-07)
  (is-nongoal pos-13-08)
  (is-nongoal pos-13-09)
  (is-nongoal pos-13-10)
  (is-nongoal pos-13-11)
  (is-nongoal pos-13-12)
  (is-nongoal pos-13-13)
  (is-nongoal pos-13-14)
  (is-nongoal pos-13-15)
  (is-nongoal pos-13-16)
  (is-nongoal pos-13-17)
  (is-nongoal pos-14-01)
  (is-nongoal pos-14-02)
  (is-nongoal pos-14-03)
  (is-nongoal pos-14-04)
  (is-nongoal pos-14-05)
  (is-nongoal pos-14-06)
  (is-nongoal pos-14-07)
  (is-nongoal pos-14-08)
  (is-nongoal pos-14-09)
  (is-nongoal pos-14-10)
  (is-nongoal pos-14-11)
  (is-nongoal pos-14-12)
  (is-nongoal pos-14-13)
  (is-nongoal pos-14-14)
  (is-nongoal pos-14-15)
  (is-nongoal pos-14-16)
  (is-nongoal pos-14-17)
  (is-nongoal pos-15-01)
  (is-nongoal pos-15-02)
  (is-nongoal pos-15-03)
  (is-nongoal pos-15-04)
  (is-nongoal pos-15-05)
  (is-nongoal pos-15-06)
  (is-nongoal pos-15-07)
  (is-nongoal pos-15-08)
  (is-nongoal pos-15-09)
  (is-nongoal pos-15-10)
  (is-nongoal pos-15-11)
  (is-nongoal pos-15-12)
  (is-nongoal pos-15-13)
  (is-nongoal pos-15-14)
  (is-nongoal pos-15-15)
  (is-nongoal pos-15-16)
  (is-nongoal pos-15-17)
  (is-nongoal pos-16-01)
  (is-nongoal pos-16-02)
  (is-nongoal pos-16-03)
  (is-nongoal pos-16-04)
  (is-nongoal pos-16-05)
  (is-nongoal pos-16-06)
  (is-nongoal pos-16-07)
  (is-nongoal pos-16-08)
  (is-nongoal pos-16-09)
  (is-nongoal pos-16-10)
  (is-nongoal pos-16-11)
  (is-nongoal pos-16-12)
  (is-nongoal pos-16-13)
  (is-nongoal pos-16-14)
  (is-nongoal pos-16-15)
  (is-nongoal pos-16-16)
  (is-nongoal pos-16-17)
  (is-nongoal pos-17-01)
  (is-nongoal pos-17-02)
  (is-nongoal pos-17-03)
  (is-nongoal pos-17-04)
  (is-nongoal pos-17-05)
  (is-nongoal pos-17-06)
  (is-nongoal pos-17-07)
  (is-nongoal pos-17-08)
  (is-nongoal pos-17-09)
  (is-nongoal pos-17-10)
  (is-nongoal pos-17-11)
  (is-nongoal pos-17-12)
  (is-nongoal pos-17-13)
  (is-nongoal pos-17-14)
  (is-nongoal pos-17-15)
  (is-nongoal pos-17-16)
  (is-nongoal pos-17-17)
  (is-nongoal pos-18-01)
  (is-nongoal pos-18-02)
  (is-nongoal pos-18-03)
  (is-nongoal pos-18-04)
  (is-nongoal pos-18-05)
  (is-nongoal pos-18-06)
  (is-nongoal pos-18-07)
  (is-nongoal pos-18-08)
  (is-nongoal pos-18-09)
  (is-nongoal pos-18-10)
  (is-nongoal pos-18-11)
  (is-nongoal pos-18-12)
  (is-nongoal pos-18-13)
  (is-nongoal pos-18-14)
  (is-nongoal pos-18-15)
  (is-nongoal pos-18-16)
  (is-nongoal pos-18-17)
  (is-nongoal pos-19-01)
  (is-nongoal pos-19-02)
  (is-nongoal pos-19-03)
  (is-nongoal pos-19-04)
  (is-nongoal pos-19-05)
  (is-nongoal pos-19-06)
  (is-nongoal pos-19-07)
  (is-nongoal pos-19-08)
  (is-nongoal pos-19-09)
  (is-nongoal pos-19-10)
  (is-nongoal pos-19-11)
  (is-nongoal pos-19-12)
  (is-nongoal pos-19-13)
  (is-nongoal pos-19-14)
  (is-nongoal pos-19-15)
  (is-nongoal pos-19-16)
  (is-nongoal pos-19-17)
  (is-nongoal pos-20-01)
  (is-nongoal pos-20-02)
  (is-nongoal pos-20-03)
  (is-nongoal pos-20-04)
  (is-nongoal pos-20-05)
  (is-nongoal pos-20-06)
  (is-nongoal pos-20-07)
  (is-nongoal pos-20-08)
  (is-nongoal pos-20-09)
  (is-nongoal pos-20-10)
  (is-nongoal pos-20-11)
  (is-nongoal pos-20-12)
  (is-nongoal pos-20-13)
  (is-nongoal pos-20-14)
  (is-nongoal pos-20-15)
  (is-nongoal pos-20-16)
  (is-nongoal pos-20-17)
  (is-nongoal pos-21-01)
  (is-nongoal pos-21-02)
  (is-nongoal pos-21-03)
  (is-nongoal pos-21-04)
  (is-nongoal pos-21-05)
  (is-nongoal pos-21-06)
  (is-nongoal pos-21-07)
  (is-nongoal pos-21-08)
  (is-nongoal pos-21-09)
  (is-nongoal pos-21-10)
  (is-nongoal pos-21-11)
  (is-nongoal pos-21-12)
  (is-nongoal pos-21-13)
  (is-nongoal pos-21-14)
  (is-nongoal pos-21-15)
  (is-nongoal pos-21-16)
  (is-nongoal pos-21-17)
  (is-nongoal pos-22-01)
  (is-nongoal pos-22-02)
  (is-nongoal pos-22-03)
  (is-nongoal pos-22-04)
  (is-nongoal pos-22-05)
  (is-nongoal pos-22-06)
  (is-nongoal pos-22-07)
  (is-nongoal pos-22-08)
  (is-nongoal pos-22-09)
  (is-nongoal pos-22-10)
  (is-nongoal pos-22-11)
  (is-nongoal pos-22-12)
  (is-nongoal pos-22-13)
  (is-nongoal pos-22-14)
  (is-nongoal pos-22-15)
  (is-nongoal pos-22-16)
  (is-nongoal pos-22-17)
  (is-nongoal pos-23-01)
  (is-nongoal pos-23-02)
  (is-nongoal pos-23-03)
  (is-nongoal pos-23-04)
  (is-nongoal pos-23-05)
  (is-nongoal pos-23-06)
  (is-nongoal pos-23-07)
  (is-nongoal pos-23-08)
  (is-nongoal pos-23-09)
  (is-nongoal pos-23-10)
  (is-nongoal pos-23-11)
  (is-nongoal pos-23-12)
  (is-nongoal pos-23-13)
  (is-nongoal pos-23-14)
  (is-nongoal pos-23-15)
  (is-nongoal pos-23-16)
  (is-nongoal pos-23-17)
  (is-nongoal pos-24-01)
  (is-nongoal pos-24-02)
  (is-nongoal pos-24-03)
  (is-nongoal pos-24-04)
  (is-nongoal pos-24-05)
  (is-nongoal pos-24-06)
  (is-nongoal pos-24-07)
  (is-nongoal pos-24-08)
  (is-nongoal pos-24-09)
  (is-nongoal pos-24-10)
  (is-nongoal pos-24-11)
  (is-nongoal pos-24-12)
  (is-nongoal pos-24-13)
  (is-nongoal pos-24-14)
  (is-nongoal pos-24-15)
  (is-nongoal pos-24-16)
  (is-nongoal pos-24-17)
  (is-nongoal pos-25-01)
  (is-nongoal pos-25-02)
  (is-nongoal pos-25-03)
  (is-nongoal pos-25-04)
  (is-nongoal pos-25-05)
  (is-nongoal pos-25-06)
  (is-nongoal pos-25-07)
  (is-nongoal pos-25-08)
  (is-nongoal pos-25-09)
  (is-nongoal pos-25-10)
  (is-nongoal pos-25-11)
  (is-nongoal pos-25-12)
  (is-nongoal pos-25-13)
  (is-nongoal pos-25-14)
  (is-nongoal pos-25-15)
  (is-nongoal pos-25-16)
  (is-nongoal pos-25-17)
  (is-nongoal pos-26-01)
  (is-nongoal pos-26-02)
  (is-nongoal pos-26-03)
  (is-nongoal pos-26-04)
  (is-nongoal pos-26-05)
  (is-nongoal pos-26-06)
  (is-nongoal pos-26-07)
  (is-nongoal pos-26-08)
  (is-nongoal pos-26-09)
  (is-nongoal pos-26-10)
  (is-nongoal pos-26-11)
  (is-nongoal pos-26-12)
  (is-nongoal pos-26-13)
  (is-nongoal pos-26-14)
  (is-nongoal pos-26-15)
  (is-nongoal pos-26-16)
  (is-nongoal pos-26-17)
  (is-nongoal pos-27-01)
  (is-nongoal pos-27-02)
  (is-nongoal pos-27-03)
  (is-nongoal pos-27-04)
  (is-nongoal pos-27-05)
  (is-nongoal pos-27-06)
  (is-nongoal pos-27-07)
  (is-nongoal pos-27-08)
  (is-nongoal pos-27-09)
  (is-nongoal pos-27-10)
  (is-nongoal pos-27-11)
  (is-nongoal pos-27-12)
  (is-nongoal pos-27-13)
  (is-nongoal pos-27-14)
  (is-nongoal pos-27-15)
  (is-nongoal pos-27-16)
  (is-nongoal pos-27-17)
  (is-nongoal pos-28-01)
  (is-nongoal pos-28-02)
  (is-nongoal pos-28-03)
  (is-nongoal pos-28-04)
  (is-nongoal pos-28-05)
  (is-nongoal pos-28-06)
  (is-nongoal pos-28-07)
  (is-nongoal pos-28-08)
  (is-nongoal pos-28-09)
  (is-nongoal pos-28-10)
  (is-nongoal pos-28-11)
  (is-nongoal pos-28-12)
  (is-nongoal pos-28-13)
  (is-nongoal pos-28-14)
  (is-nongoal pos-28-15)
  (is-nongoal pos-28-16)
  (is-nongoal pos-28-17)
  (is-nongoal pos-29-01)
  (is-nongoal pos-29-02)
  (is-nongoal pos-29-03)
  (is-nongoal pos-29-04)
  (is-nongoal pos-29-05)
  (is-nongoal pos-29-06)
  (is-nongoal pos-29-07)
  (is-nongoal pos-29-08)
  (is-nongoal pos-29-09)
  (is-nongoal pos-29-10)
  (is-nongoal pos-29-11)
  (is-nongoal pos-29-12)
  (is-nongoal pos-29-13)
  (is-nongoal pos-29-14)
  (is-nongoal pos-29-15)
  (is-nongoal pos-29-16)
  (is-nongoal pos-29-17)
  (move-dir pos-01-01 pos-01-02 dir-down)
  (move-dir pos-01-02 pos-01-01 dir-up)
  (move-dir pos-01-02 pos-01-03 dir-down)
  (move-dir pos-01-03 pos-01-02 dir-up)
  (move-dir pos-01-03 pos-01-04 dir-down)
  (move-dir pos-01-04 pos-01-03 dir-up)
  (move-dir pos-01-04 pos-01-05 dir-down)
  (move-dir pos-01-05 pos-01-04 dir-up)
  (move-dir pos-01-05 pos-01-06 dir-down)
  (move-dir pos-01-06 pos-01-05 dir-up)
  (move-dir pos-01-06 pos-01-07 dir-down)
  (move-dir pos-01-07 pos-01-06 dir-up)
  (move-dir pos-01-07 pos-01-08 dir-down)
  (move-dir pos-01-08 pos-01-07 dir-up)
  (move-dir pos-01-08 pos-01-09 dir-down)
  (move-dir pos-01-09 pos-01-08 dir-up)
  (move-dir pos-01-09 pos-01-10 dir-down)
  (move-dir pos-01-10 pos-01-09 dir-up)
  (move-dir pos-01-10 pos-01-11 dir-down)
  (move-dir pos-01-11 pos-01-10 dir-up)
  (move-dir pos-01-11 pos-01-12 dir-down)
  (move-dir pos-01-12 pos-01-11 dir-up)
  (move-dir pos-01-12 pos-01-13 dir-down)
  (move-dir pos-01-13 pos-01-12 dir-up)
  (move-dir pos-01-13 pos-01-14 dir-down)
  (move-dir pos-01-14 pos-01-13 dir-up)
  (move-dir pos-02-16 pos-03-16 dir-right)
  (move-dir pos-03-02 pos-03-03 dir-down)
  (move-dir pos-03-02 pos-04-02 dir-right)
  (move-dir pos-03-03 pos-03-02 dir-up)
  (move-dir pos-03-03 pos-03-04 dir-down)
  (move-dir pos-03-04 pos-03-03 dir-up)
  (move-dir pos-03-04 pos-03-05 dir-down)
  (move-dir pos-03-05 pos-03-04 dir-up)
  (move-dir pos-03-05 pos-03-06 dir-down)
  (move-dir pos-03-06 pos-03-05 dir-up)
  (move-dir pos-03-06 pos-03-07 dir-down)
  (move-dir pos-03-07 pos-03-06 dir-up)
  (move-dir pos-03-07 pos-03-08 dir-down)
  (move-dir pos-03-08 pos-03-07 dir-up)
  (move-dir pos-03-08 pos-03-09 dir-down)
  (move-dir pos-03-09 pos-03-08 dir-up)
  (move-dir pos-03-09 pos-03-10 dir-down)
  (move-dir pos-03-10 pos-03-09 dir-up)
  (move-dir pos-03-10 pos-03-11 dir-down)
  (move-dir pos-03-11 pos-03-10 dir-up)
  (move-dir pos-03-11 pos-03-12 dir-down)
  (move-dir pos-03-12 pos-03-11 dir-up)
  (move-dir pos-03-12 pos-03-13 dir-down)
  (move-dir pos-03-13 pos-03-12 dir-up)
  (move-dir pos-03-13 pos-03-14 dir-down)
  (move-dir pos-03-14 pos-03-13 dir-up)
  (move-dir pos-03-14 pos-03-15 dir-down)
  (move-dir pos-03-15 pos-03-14 dir-up)
  (move-dir pos-03-15 pos-03-16 dir-down)
  (move-dir pos-03-16 pos-02-16 dir-left)
  (move-dir pos-03-16 pos-03-15 dir-up)
  (move-dir pos-03-16 pos-04-16 dir-right)
  (move-dir pos-04-02 pos-03-02 dir-left)
  (move-dir pos-04-02 pos-05-02 dir-right)
  (move-dir pos-04-16 pos-03-16 dir-left)
  (move-dir pos-04-16 pos-05-16 dir-right)
  (move-dir pos-05-02 pos-04-02 dir-left)
  (move-dir pos-05-02 pos-06-02 dir-right)
  (move-dir pos-05-04 pos-05-05 dir-down)
  (move-dir pos-05-04 pos-06-04 dir-right)
  (move-dir pos-05-05 pos-05-04 dir-up)
  (move-dir pos-05-05 pos-05-06 dir-down)
  (move-dir pos-05-06 pos-05-05 dir-up)
  (move-dir pos-05-06 pos-05-07 dir-down)
  (move-dir pos-05-07 pos-05-06 dir-up)
  (move-dir pos-05-07 pos-05-08 dir-down)
  (move-dir pos-05-08 pos-05-07 dir-up)
  (move-dir pos-05-08 pos-05-09 dir-down)
  (move-dir pos-05-09 pos-05-08 dir-up)
  (move-dir pos-05-09 pos-05-10 dir-down)
  (move-dir pos-05-10 pos-05-09 dir-up)
  (move-dir pos-05-10 pos-05-11 dir-down)
  (move-dir pos-05-11 pos-05-10 dir-up)
  (move-dir pos-05-11 pos-05-12 dir-down)
  (move-dir pos-05-12 pos-05-11 dir-up)
  (move-dir pos-05-12 pos-05-13 dir-down)
  (move-dir pos-05-13 pos-05-12 dir-up)
  (move-dir pos-05-13 pos-05-14 dir-down)
  (move-dir pos-05-14 pos-05-13 dir-up)
  (move-dir pos-05-14 pos-05-15 dir-down)
  (move-dir pos-05-15 pos-05-14 dir-up)
  (move-dir pos-05-15 pos-05-16 dir-down)
  (move-dir pos-05-16 pos-04-16 dir-left)
  (move-dir pos-05-16 pos-05-15 dir-up)
  (move-dir pos-06-02 pos-05-02 dir-left)
  (move-dir pos-06-02 pos-07-02 dir-right)
  (move-dir pos-06-04 pos-05-04 dir-left)
  (move-dir pos-06-04 pos-07-04 dir-right)
  (move-dir pos-07-02 pos-06-02 dir-left)
  (move-dir pos-07-02 pos-08-02 dir-right)
  (move-dir pos-07-04 pos-06-04 dir-left)
  (move-dir pos-07-04 pos-08-04 dir-right)
  (move-dir pos-07-06 pos-07-07 dir-down)
  (move-dir pos-07-06 pos-08-06 dir-right)
  (move-dir pos-07-07 pos-07-06 dir-up)
  (move-dir pos-07-07 pos-07-08 dir-down)
  (move-dir pos-07-08 pos-07-07 dir-up)
  (move-dir pos-07-08 pos-07-09 dir-down)
  (move-dir pos-07-09 pos-07-08 dir-up)
  (move-dir pos-07-09 pos-07-10 dir-down)
  (move-dir pos-07-10 pos-07-09 dir-up)
  (move-dir pos-07-10 pos-07-11 dir-down)
  (move-dir pos-07-11 pos-07-10 dir-up)
  (move-dir pos-07-11 pos-07-12 dir-down)
  (move-dir pos-07-12 pos-07-11 dir-up)
  (move-dir pos-07-12 pos-07-13 dir-down)
  (move-dir pos-07-13 pos-07-12 dir-up)
  (move-dir pos-07-13 pos-07-14 dir-down)
  (move-dir pos-07-14 pos-07-13 dir-up)
  (move-dir pos-07-14 pos-07-15 dir-down)
  (move-dir pos-07-15 pos-07-14 dir-up)
  (move-dir pos-07-15 pos-07-16 dir-down)
  (move-dir pos-07-16 pos-07-15 dir-up)
  (move-dir pos-07-16 pos-08-16 dir-right)
  (move-dir pos-08-02 pos-07-02 dir-left)
  (move-dir pos-08-02 pos-09-02 dir-right)
  (move-dir pos-08-04 pos-07-04 dir-left)
  (move-dir pos-08-04 pos-09-04 dir-right)
  (move-dir pos-08-06 pos-07-06 dir-left)
  (move-dir pos-08-06 pos-09-06 dir-right)
  (move-dir pos-08-16 pos-07-16 dir-left)
  (move-dir pos-08-16 pos-09-16 dir-right)
  (move-dir pos-09-02 pos-08-02 dir-left)
  (move-dir pos-09-02 pos-10-02 dir-right)
  (move-dir pos-09-04 pos-08-04 dir-left)
  (move-dir pos-09-04 pos-10-04 dir-right)
  (move-dir pos-09-06 pos-08-06 dir-left)
  (move-dir pos-09-06 pos-10-06 dir-right)
  (move-dir pos-09-08 pos-09-09 dir-down)
  (move-dir pos-09-08 pos-10-08 dir-right)
  (move-dir pos-09-09 pos-09-08 dir-up)
  (move-dir pos-09-09 pos-09-10 dir-down)
  (move-dir pos-09-10 pos-09-09 dir-up)
  (move-dir pos-09-10 pos-09-11 dir-down)
  (move-dir pos-09-11 pos-09-10 dir-up)
  (move-dir pos-09-11 pos-09-12 dir-down)
  (move-dir pos-09-12 pos-09-11 dir-up)
  (move-dir pos-09-12 pos-09-13 dir-down)
  (move-dir pos-09-13 pos-09-12 dir-up)
  (move-dir pos-09-13 pos-09-14 dir-down)
  (move-dir pos-09-14 pos-09-13 dir-up)
  (move-dir pos-09-14 pos-10-14 dir-right)
  (move-dir pos-09-16 pos-08-16 dir-left)
  (move-dir pos-09-16 pos-10-16 dir-right)
  (move-dir pos-10-02 pos-09-02 dir-left)
  (move-dir pos-10-02 pos-11-02 dir-right)
  (move-dir pos-10-04 pos-09-04 dir-left)
  (move-dir pos-10-04 pos-11-04 dir-right)
  (move-dir pos-10-06 pos-09-06 dir-left)
  (move-dir pos-10-06 pos-11-06 dir-right)
  (move-dir pos-10-08 pos-09-08 dir-left)
  (move-dir pos-10-08 pos-11-08 dir-right)
  (move-dir pos-10-14 pos-09-14 dir-left)
  (move-dir pos-10-14 pos-11-14 dir-right)
  (move-dir pos-10-16 pos-09-16 dir-left)
  (move-dir pos-10-16 pos-11-16 dir-right)
  (move-dir pos-11-02 pos-10-02 dir-left)
  (move-dir pos-11-02 pos-12-02 dir-right)
  (move-dir pos-11-04 pos-10-04 dir-left)
  (move-dir pos-11-04 pos-12-04 dir-right)
  (move-dir pos-11-06 pos-10-06 dir-left)
  (move-dir pos-11-06 pos-12-06 dir-right)
  (move-dir pos-11-08 pos-10-08 dir-left)
  (move-dir pos-11-08 pos-12-08 dir-right)
  (move-dir pos-11-10 pos-11-11 dir-down)
  (move-dir pos-11-10 pos-12-10 dir-right)
  (move-dir pos-11-11 pos-11-10 dir-up)
  (move-dir pos-11-11 pos-11-12 dir-down)
  (move-dir pos-11-12 pos-11-11 dir-up)
  (move-dir pos-11-12 pos-12-12 dir-right)
  (move-dir pos-11-14 pos-10-14 dir-left)
  (move-dir pos-11-14 pos-12-14 dir-right)
  (move-dir pos-11-16 pos-10-16 dir-left)
  (move-dir pos-11-16 pos-12-16 dir-right)
  (move-dir pos-12-02 pos-11-02 dir-left)
  (move-dir pos-12-02 pos-13-02 dir-right)
  (move-dir pos-12-04 pos-11-04 dir-left)
  (move-dir pos-12-04 pos-13-04 dir-right)
  (move-dir pos-12-06 pos-11-06 dir-left)
  (move-dir pos-12-06 pos-13-06 dir-right)
  (move-dir pos-12-08 pos-11-08 dir-left)
  (move-dir pos-12-08 pos-13-08 dir-right)
  (move-dir pos-12-10 pos-11-10 dir-left)
  (move-dir pos-12-10 pos-13-10 dir-right)
  (move-dir pos-12-12 pos-11-12 dir-left)
  (move-dir pos-12-12 pos-13-12 dir-right)
  (move-dir pos-12-14 pos-11-14 dir-left)
  (move-dir pos-12-14 pos-13-14 dir-right)
  (move-dir pos-12-16 pos-11-16 dir-left)
  (move-dir pos-12-16 pos-13-16 dir-right)
  (move-dir pos-13-02 pos-12-02 dir-left)
  (move-dir pos-13-02 pos-14-02 dir-right)
  (move-dir pos-13-04 pos-12-04 dir-left)
  (move-dir pos-13-04 pos-14-04 dir-right)
  (move-dir pos-13-06 pos-12-06 dir-left)
  (move-dir pos-13-06 pos-14-06 dir-right)
  (move-dir pos-13-08 pos-12-08 dir-left)
  (move-dir pos-13-08 pos-14-08 dir-right)
  (move-dir pos-13-10 pos-12-10 dir-left)
  (move-dir pos-13-10 pos-14-10 dir-right)
  (move-dir pos-13-12 pos-12-12 dir-left)
  (move-dir pos-13-12 pos-14-12 dir-right)
  (move-dir pos-13-14 pos-12-14 dir-left)
  (move-dir pos-13-14 pos-14-14 dir-right)
  (move-dir pos-13-16 pos-12-16 dir-left)
  (move-dir pos-13-16 pos-14-16 dir-right)
  (move-dir pos-14-02 pos-13-02 dir-left)
  (move-dir pos-14-02 pos-15-02 dir-right)
  (move-dir pos-14-04 pos-13-04 dir-left)
  (move-dir pos-14-04 pos-15-04 dir-right)
  (move-dir pos-14-06 pos-13-06 dir-left)
  (move-dir pos-14-06 pos-15-06 dir-right)
  (move-dir pos-14-08 pos-13-08 dir-left)
  (move-dir pos-14-08 pos-15-08 dir-right)
  (move-dir pos-14-10 pos-13-10 dir-left)
  (move-dir pos-14-10 pos-15-10 dir-right)
  (move-dir pos-14-12 pos-13-12 dir-left)
  (move-dir pos-14-12 pos-15-12 dir-right)
  (move-dir pos-14-14 pos-13-14 dir-left)
  (move-dir pos-14-14 pos-15-14 dir-right)
  (move-dir pos-14-16 pos-13-16 dir-left)
  (move-dir pos-14-16 pos-15-16 dir-right)
  (move-dir pos-15-02 pos-14-02 dir-left)
  (move-dir pos-15-02 pos-16-02 dir-right)
  (move-dir pos-15-04 pos-14-04 dir-left)
  (move-dir pos-15-04 pos-16-04 dir-right)
  (move-dir pos-15-06 pos-14-06 dir-left)
  (move-dir pos-15-06 pos-16-06 dir-right)
  (move-dir pos-15-08 pos-14-08 dir-left)
  (move-dir pos-15-08 pos-16-08 dir-right)
  (move-dir pos-15-10 pos-14-10 dir-left)
  (move-dir pos-15-10 pos-16-10 dir-right)
  (move-dir pos-15-12 pos-14-12 dir-left)
  (move-dir pos-15-12 pos-16-12 dir-right)
  (move-dir pos-15-14 pos-14-14 dir-left)
  (move-dir pos-15-14 pos-16-14 dir-right)
  (move-dir pos-15-16 pos-14-16 dir-left)
  (move-dir pos-15-16 pos-16-16 dir-right)
  (move-dir pos-16-02 pos-15-02 dir-left)
  (move-dir pos-16-02 pos-17-02 dir-right)
  (move-dir pos-16-04 pos-15-04 dir-left)
  (move-dir pos-16-04 pos-17-04 dir-right)
  (move-dir pos-16-06 pos-15-06 dir-left)
  (move-dir pos-16-06 pos-17-06 dir-right)
  (move-dir pos-16-08 pos-15-08 dir-left)
  (move-dir pos-16-08 pos-17-08 dir-right)
  (move-dir pos-16-10 pos-15-10 dir-left)
  (move-dir pos-16-10 pos-17-10 dir-right)
  (move-dir pos-16-12 pos-15-12 dir-left)
  (move-dir pos-16-12 pos-17-12 dir-right)
  (move-dir pos-16-14 pos-15-14 dir-left)
  (move-dir pos-16-14 pos-17-14 dir-right)
  (move-dir pos-16-16 pos-15-16 dir-left)
  (move-dir pos-16-16 pos-17-16 dir-right)
  (move-dir pos-17-02 pos-16-02 dir-left)
  (move-dir pos-17-02 pos-18-02 dir-right)
  (move-dir pos-17-04 pos-16-04 dir-left)
  (move-dir pos-17-04 pos-18-04 dir-right)
  (move-dir pos-17-06 pos-16-06 dir-left)
  (move-dir pos-17-06 pos-18-06 dir-right)
  (move-dir pos-17-08 pos-16-08 dir-left)
  (move-dir pos-17-08 pos-18-08 dir-right)
  (move-dir pos-17-10 pos-16-10 dir-left)
  (move-dir pos-17-10 pos-18-10 dir-right)
  (move-dir pos-17-12 pos-16-12 dir-left)
  (move-dir pos-17-12 pos-18-12 dir-right)
  (move-dir pos-17-14 pos-16-14 dir-left)
  (move-dir pos-17-14 pos-18-14 dir-right)
  (move-dir pos-17-16 pos-16-16 dir-left)
  (move-dir pos-17-16 pos-18-16 dir-right)
  (move-dir pos-18-02 pos-17-02 dir-left)
  (move-dir pos-18-02 pos-19-02 dir-right)
  (move-dir pos-18-04 pos-17-04 dir-left)
  (move-dir pos-18-04 pos-19-04 dir-right)
  (move-dir pos-18-06 pos-17-06 dir-left)
  (move-dir pos-18-06 pos-19-06 dir-right)
  (move-dir pos-18-08 pos-17-08 dir-left)
  (move-dir pos-18-08 pos-19-08 dir-right)
  (move-dir pos-18-10 pos-17-10 dir-left)
  (move-dir pos-18-10 pos-19-10 dir-right)
  (move-dir pos-18-12 pos-17-12 dir-left)
  (move-dir pos-18-12 pos-19-12 dir-right)
  (move-dir pos-18-14 pos-17-14 dir-left)
  (move-dir pos-18-14 pos-19-14 dir-right)
  (move-dir pos-18-16 pos-17-16 dir-left)
  (move-dir pos-18-16 pos-19-16 dir-right)
  (move-dir pos-19-02 pos-18-02 dir-left)
  (move-dir pos-19-02 pos-20-02 dir-right)
  (move-dir pos-19-04 pos-18-04 dir-left)
  (move-dir pos-19-04 pos-20-04 dir-right)
  (move-dir pos-19-06 pos-18-06 dir-left)
  (move-dir pos-19-06 pos-20-06 dir-right)
  (move-dir pos-19-08 pos-18-08 dir-left)
  (move-dir pos-19-08 pos-20-08 dir-right)
  (move-dir pos-19-10 pos-18-10 dir-left)
  (move-dir pos-19-10 pos-20-10 dir-right)
  (move-dir pos-19-12 pos-18-12 dir-left)
  (move-dir pos-19-12 pos-20-12 dir-right)
  (move-dir pos-19-14 pos-18-14 dir-left)
  (move-dir pos-19-14 pos-20-14 dir-right)
  (move-dir pos-19-16 pos-18-16 dir-left)
  (move-dir pos-19-16 pos-20-16 dir-right)
  (move-dir pos-20-02 pos-19-02 dir-left)
  (move-dir pos-20-02 pos-21-02 dir-right)
  (move-dir pos-20-04 pos-19-04 dir-left)
  (move-dir pos-20-04 pos-21-04 dir-right)
  (move-dir pos-20-06 pos-19-06 dir-left)
  (move-dir pos-20-06 pos-21-06 dir-right)
  (move-dir pos-20-08 pos-19-08 dir-left)
  (move-dir pos-20-08 pos-21-08 dir-right)
  (move-dir pos-20-10 pos-19-10 dir-left)
  (move-dir pos-20-10 pos-21-10 dir-right)
  (move-dir pos-20-12 pos-19-12 dir-left)
  (move-dir pos-20-12 pos-21-12 dir-right)
  (move-dir pos-20-14 pos-19-14 dir-left)
  (move-dir pos-20-14 pos-21-14 dir-right)
  (move-dir pos-20-16 pos-19-16 dir-left)
  (move-dir pos-20-16 pos-21-16 dir-right)
  (move-dir pos-21-02 pos-20-02 dir-left)
  (move-dir pos-21-02 pos-22-02 dir-right)
  (move-dir pos-21-04 pos-20-04 dir-left)
  (move-dir pos-21-04 pos-22-04 dir-right)
  (move-dir pos-21-06 pos-20-06 dir-left)
  (move-dir pos-21-06 pos-22-06 dir-right)
  (move-dir pos-21-08 pos-20-08 dir-left)
  (move-dir pos-21-08 pos-22-08 dir-right)
  (move-dir pos-21-10 pos-20-10 dir-left)
  (move-dir pos-21-10 pos-22-10 dir-right)
  (move-dir pos-21-12 pos-20-12 dir-left)
  (move-dir pos-21-12 pos-22-12 dir-right)
  (move-dir pos-21-14 pos-20-14 dir-left)
  (move-dir pos-21-14 pos-22-14 dir-right)
  (move-dir pos-21-16 pos-20-16 dir-left)
  (move-dir pos-21-16 pos-22-16 dir-right)
  (move-dir pos-22-02 pos-21-02 dir-left)
  (move-dir pos-22-02 pos-23-02 dir-right)
  (move-dir pos-22-04 pos-21-04 dir-left)
  (move-dir pos-22-04 pos-23-04 dir-right)
  (move-dir pos-22-06 pos-21-06 dir-left)
  (move-dir pos-22-06 pos-23-06 dir-right)
  (move-dir pos-22-08 pos-21-08 dir-left)
  (move-dir pos-22-08 pos-22-09 dir-down)
  (move-dir pos-22-09 pos-22-08 dir-up)
  (move-dir pos-22-09 pos-22-10 dir-down)
  (move-dir pos-22-10 pos-21-10 dir-left)
  (move-dir pos-22-10 pos-22-09 dir-up)
  (move-dir pos-22-12 pos-21-12 dir-left)
  (move-dir pos-22-12 pos-23-12 dir-right)
  (move-dir pos-22-14 pos-21-14 dir-left)
  (move-dir pos-22-14 pos-23-14 dir-right)
  (move-dir pos-22-16 pos-21-16 dir-left)
  (move-dir pos-22-16 pos-23-16 dir-right)
  (move-dir pos-23-02 pos-22-02 dir-left)
  (move-dir pos-23-02 pos-24-02 dir-right)
  (move-dir pos-23-04 pos-22-04 dir-left)
  (move-dir pos-23-04 pos-24-04 dir-right)
  (move-dir pos-23-06 pos-22-06 dir-left)
  (move-dir pos-23-06 pos-24-06 dir-right)
  (move-dir pos-23-12 pos-22-12 dir-left)
  (move-dir pos-23-12 pos-24-12 dir-right)
  (move-dir pos-23-14 pos-22-14 dir-left)
  (move-dir pos-23-14 pos-24-14 dir-right)
  (move-dir pos-23-16 pos-22-16 dir-left)
  (move-dir pos-23-16 pos-24-16 dir-right)
  (move-dir pos-24-02 pos-23-02 dir-left)
  (move-dir pos-24-02 pos-25-02 dir-right)
  (move-dir pos-24-04 pos-23-04 dir-left)
  (move-dir pos-24-04 pos-25-04 dir-right)
  (move-dir pos-24-06 pos-23-06 dir-left)
  (move-dir pos-24-06 pos-24-07 dir-down)
  (move-dir pos-24-07 pos-24-06 dir-up)
  (move-dir pos-24-07 pos-24-08 dir-down)
  (move-dir pos-24-08 pos-24-07 dir-up)
  (move-dir pos-24-08 pos-24-09 dir-down)
  (move-dir pos-24-09 pos-24-08 dir-up)
  (move-dir pos-24-09 pos-24-10 dir-down)
  (move-dir pos-24-10 pos-24-09 dir-up)
  (move-dir pos-24-10 pos-24-11 dir-down)
  (move-dir pos-24-11 pos-24-10 dir-up)
  (move-dir pos-24-11 pos-24-12 dir-down)
  (move-dir pos-24-12 pos-23-12 dir-left)
  (move-dir pos-24-12 pos-24-11 dir-up)
  (move-dir pos-24-14 pos-23-14 dir-left)
  (move-dir pos-24-14 pos-25-14 dir-right)
  (move-dir pos-24-16 pos-23-16 dir-left)
  (move-dir pos-24-16 pos-25-16 dir-right)
  (move-dir pos-25-02 pos-24-02 dir-left)
  (move-dir pos-25-02 pos-26-02 dir-right)
  (move-dir pos-25-04 pos-24-04 dir-left)
  (move-dir pos-25-04 pos-26-04 dir-right)
  (move-dir pos-25-14 pos-24-14 dir-left)
  (move-dir pos-25-14 pos-26-14 dir-right)
  (move-dir pos-25-16 pos-24-16 dir-left)
  (move-dir pos-25-16 pos-26-16 dir-right)
  (move-dir pos-26-02 pos-25-02 dir-left)
  (move-dir pos-26-02 pos-27-02 dir-right)
  (move-dir pos-26-04 pos-25-04 dir-left)
  (move-dir pos-26-04 pos-26-05 dir-down)
  (move-dir pos-26-05 pos-26-04 dir-up)
  (move-dir pos-26-05 pos-26-06 dir-down)
  (move-dir pos-26-06 pos-26-05 dir-up)
  (move-dir pos-26-06 pos-26-07 dir-down)
  (move-dir pos-26-07 pos-26-06 dir-up)
  (move-dir pos-26-07 pos-26-08 dir-down)
  (move-dir pos-26-08 pos-26-07 dir-up)
  (move-dir pos-26-08 pos-26-09 dir-down)
  (move-dir pos-26-09 pos-26-08 dir-up)
  (move-dir pos-26-09 pos-26-10 dir-down)
  (move-dir pos-26-10 pos-26-09 dir-up)
  (move-dir pos-26-10 pos-26-11 dir-down)
  (move-dir pos-26-11 pos-26-10 dir-up)
  (move-dir pos-26-11 pos-26-12 dir-down)
  (move-dir pos-26-12 pos-26-11 dir-up)
  (move-dir pos-26-12 pos-26-13 dir-down)
  (move-dir pos-26-13 pos-26-12 dir-up)
  (move-dir pos-26-13 pos-26-14 dir-down)
  (move-dir pos-26-14 pos-25-14 dir-left)
  (move-dir pos-26-14 pos-26-13 dir-up)
  (move-dir pos-26-16 pos-25-16 dir-left)
  (move-dir pos-26-16 pos-27-16 dir-right)
  (move-dir pos-27-02 pos-26-02 dir-left)
  (move-dir pos-27-02 pos-28-02 dir-right)
  (move-dir pos-27-16 pos-26-16 dir-left)
  (move-dir pos-27-16 pos-28-16 dir-right)
  (move-dir pos-28-02 pos-27-02 dir-left)
  (move-dir pos-28-02 pos-28-03 dir-down)
  (move-dir pos-28-03 pos-28-02 dir-up)
  (move-dir pos-28-03 pos-28-04 dir-down)
  (move-dir pos-28-04 pos-28-03 dir-up)
  (move-dir pos-28-04 pos-28-05 dir-down)
  (move-dir pos-28-05 pos-28-04 dir-up)
  (move-dir pos-28-05 pos-28-06 dir-down)
  (move-dir pos-28-06 pos-28-05 dir-up)
  (move-dir pos-28-06 pos-28-07 dir-down)
  (move-dir pos-28-07 pos-28-06 dir-up)
  (move-dir pos-28-07 pos-28-08 dir-down)
  (move-dir pos-28-08 pos-28-07 dir-up)
  (move-dir pos-28-08 pos-28-09 dir-down)
  (move-dir pos-28-09 pos-28-08 dir-up)
  (move-dir pos-28-09 pos-28-10 dir-down)
  (move-dir pos-28-10 pos-28-09 dir-up)
  (move-dir pos-28-10 pos-28-11 dir-down)
  (move-dir pos-28-11 pos-28-10 dir-up)
  (move-dir pos-28-11 pos-28-12 dir-down)
  (move-dir pos-28-12 pos-28-11 dir-up)
  (move-dir pos-28-12 pos-28-13 dir-down)
  (move-dir pos-28-13 pos-28-12 dir-up)
  (move-dir pos-28-13 pos-28-14 dir-down)
  (move-dir pos-28-14 pos-28-13 dir-up)
  (move-dir pos-28-14 pos-28-15 dir-down)
  (move-dir pos-28-15 pos-28-14 dir-up)
  (move-dir pos-28-15 pos-28-16 dir-down)
  (move-dir pos-28-16 pos-27-16 dir-left)
  (move-dir pos-28-16 pos-28-15 dir-up)
  (at_player player-01 pos-04-16)
  (at_stone stone-01 pos-03-15)
  (clear pos-01-01)
  (clear pos-01-02)
  (clear pos-01-03)
  (clear pos-01-04)
  (clear pos-01-05)
  (clear pos-01-06)
  (clear pos-01-07)
  (clear pos-01-08)
  (clear pos-01-09)
  (clear pos-01-10)
  (clear pos-01-11)
  (clear pos-01-12)
  (clear pos-01-13)
  (clear pos-01-14)
  (clear pos-02-16)
  (clear pos-03-02)
  (clear pos-03-03)
  (clear pos-03-04)
  (clear pos-03-05)
  (clear pos-03-06)
  (clear pos-03-07)
  (clear pos-03-08)
  (clear pos-03-09)
  (clear pos-03-10)
  (clear pos-03-11)
  (clear pos-03-12)
  (clear pos-03-13)
  (clear pos-03-14)
  (clear pos-03-16)
  (clear pos-04-02)
  (clear pos-05-02)
  (clear pos-05-04)
  (clear pos-05-05)
  (clear pos-05-06)
  (clear pos-05-07)
  (clear pos-05-08)
  (clear pos-05-09)
  (clear pos-05-10)
  (clear pos-05-11)
  (clear pos-05-12)
  (clear pos-05-13)
  (clear pos-05-14)
  (clear pos-05-15)
  (clear pos-05-16)
  (clear pos-06-02)
  (clear pos-06-04)
  (clear pos-07-02)
  (clear pos-07-04)
  (clear pos-07-06)
  (clear pos-07-07)
  (clear pos-07-08)
  (clear pos-07-09)
  (clear pos-07-10)
  (clear pos-07-11)
  (clear pos-07-12)
  (clear pos-07-13)
  (clear pos-07-14)
  (clear pos-07-15)
  (clear pos-07-16)
  (clear pos-08-02)
  (clear pos-08-04)
  (clear pos-08-06)
  (clear pos-08-16)
  (clear pos-09-02)
  (clear pos-09-04)
  (clear pos-09-06)
  (clear pos-09-08)
  (clear pos-09-09)
  (clear pos-09-10)
  (clear pos-09-11)
  (clear pos-09-12)
  (clear pos-09-13)
  (clear pos-09-14)
  (clear pos-09-16)
  (clear pos-10-02)
  (clear pos-10-04)
  (clear pos-10-06)
  (clear pos-10-08)
  (clear pos-10-14)
  (clear pos-10-16)
  (clear pos-11-02)
  (clear pos-11-04)
  (clear pos-11-06)
  (clear pos-11-08)
  (clear pos-11-10)
  (clear pos-11-11)
  (clear pos-11-12)
  (clear pos-11-14)
  (clear pos-11-16)
  (clear pos-12-02)
  (clear pos-12-04)
  (clear pos-12-06)
  (clear pos-12-08)
  (clear pos-12-10)
  (clear pos-12-12)
  (clear pos-12-14)
  (clear pos-12-16)
  (clear pos-13-02)
  (clear pos-13-04)
  (clear pos-13-06)
  (clear pos-13-08)
  (clear pos-13-10)
  (clear pos-13-12)
  (clear pos-13-14)
  (clear pos-13-16)
  (clear pos-14-02)
  (clear pos-14-04)
  (clear pos-14-06)
  (clear pos-14-08)
  (clear pos-14-10)
  (clear pos-14-12)
  (clear pos-14-14)
  (clear pos-14-16)
  (clear pos-15-02)
  (clear pos-15-04)
  (clear pos-15-06)
  (clear pos-15-08)
  (clear pos-15-10)
  (clear pos-15-12)
  (clear pos-15-14)
  (clear pos-15-16)
  (clear pos-16-02)
  (clear pos-16-04)
  (clear pos-16-06)
  (clear pos-16-08)
  (clear pos-16-10)
  (clear pos-16-12)
  (clear pos-16-14)
  (clear pos-16-16)
  (clear pos-17-02)
  (clear pos-17-04)
  (clear pos-17-06)
  (clear pos-17-08)
  (clear pos-17-10)
  (clear pos-17-12)
  (clear pos-17-14)
  (clear pos-17-16)
  (clear pos-18-02)
  (clear pos-18-04)
  (clear pos-18-06)
  (clear pos-18-08)
  (clear pos-18-10)
  (clear pos-18-12)
  (clear pos-18-14)
  (clear pos-18-16)
  (clear pos-19-02)
  (clear pos-19-04)
  (clear pos-19-06)
  (clear pos-19-08)
  (clear pos-19-10)
  (clear pos-19-12)
  (clear pos-19-14)
  (clear pos-19-16)
  (clear pos-20-02)
  (clear pos-20-04)
  (clear pos-20-06)
  (clear pos-20-08)
  (clear pos-20-10)
  (clear pos-20-12)
  (clear pos-20-14)
  (clear pos-20-16)
  (clear pos-21-02)
  (clear pos-21-04)
  (clear pos-21-06)
  (clear pos-21-08)
  (clear pos-21-10)
  (clear pos-21-12)
  (clear pos-21-14)
  (clear pos-21-16)
  (clear pos-22-02)
  (clear pos-22-04)
  (clear pos-22-06)
  (clear pos-22-08)
  (clear pos-22-09)
  (clear pos-22-10)
  (clear pos-22-12)
  (clear pos-22-14)
  (clear pos-22-16)
  (clear pos-23-02)
  (clear pos-23-04)
  (clear pos-23-06)
  (clear pos-23-12)
  (clear pos-23-14)
  (clear pos-23-16)
  (clear pos-24-02)
  (clear pos-24-04)
  (clear pos-24-06)
  (clear pos-24-07)
  (clear pos-24-08)
  (clear pos-24-09)
  (clear pos-24-10)
  (clear pos-24-11)
  (clear pos-24-12)
  (clear pos-24-14)
  (clear pos-24-16)
  (clear pos-25-02)
  (clear pos-25-04)
  (clear pos-25-14)
  (clear pos-25-16)
  (clear pos-26-02)
  (clear pos-26-04)
  (clear pos-26-05)
  (clear pos-26-06)
  (clear pos-26-07)
  (clear pos-26-08)
  (clear pos-26-09)
  (clear pos-26-10)
  (clear pos-26-11)
  (clear pos-26-12)
  (clear pos-26-13)
  (clear pos-26-14)
  (clear pos-26-16)
  (clear pos-27-02)
  (clear pos-27-16)
  (clear pos-28-02)
  (clear pos-28-03)
  (clear pos-28-04)
  (clear pos-28-05)
  (clear pos-28-06)
  (clear pos-28-07)
  (clear pos-28-08)
  (clear pos-28-09)
  (clear pos-28-10)
  (clear pos-28-11)
  (clear pos-28-12)
  (clear pos-28-13)
  (clear pos-28-14)
  (clear pos-28-15)
  (clear pos-28-16)
)
(:goal   (and (at-goal stone-01)))
)
