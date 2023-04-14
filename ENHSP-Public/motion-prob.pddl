(define (problem motion-prob)
(:domain motion)

(:objects 
          wairob - waiter
          chargespot - station
          barside - bar
          table1 table2 table3 table4 - table)

(:init 
    (at-rob wairob chargespot)
    (= (time-moving wairob) 0)
    (= (tot-time) 0)
    ; move forward
    (= (distance chargespot barside) 2)
    (= (distance barside table1) 2)
    (= (distance barside table2) 2)
    (= (distance table1 table2) 1)
    (= (distance table1 table3) 2)
    (= (distance table1 table4) 2)
    (= (distance table2 table3) 2)
    (= (distance table2 table4) 2)
    (= (distance table3 table4) 2)
    (= (distance table1 chargespot) 2)
    (= (distance table3 chargespot) 2)
    ; move backward
    (= (distance barside chargespot) 2)
    (= (distance table1 barside) 2)
    (= (distance table2 barside) 2)
    (= (distance table2 table1) 2)
    (= (distance table3 table1) 2)
    (= (distance table4 table1) 2)
    (= (distance table3 table2) 2)
    (= (distance table4 table2) 2)
    (= (distance table4 table3) 2)
    (= (distance chargespot table1) 2)
    (= (distance chargespot table3) 2)
    (= (type-motion) 0)
    )

(:goal (and
	 (passed barside)
	 (passed table1)
	 (passed table2)
	 (passed table3)
	 (passed table4)
	 (passed chargespot)
       )
)

(:metric minimize (tot-time))





)
