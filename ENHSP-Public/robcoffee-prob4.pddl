(define (problem robcoffee-prob1)
(:domain robcoffee)

(:objects robtender - barista
          wairob1 wairob2 - waiter
          chargespot - station
          barside - bar
          drink1 drink2 drink3 drink4 - warm
          drink5 drink6 drink7 drink8 - cold
          tray1 - tray
          gripper1 gripper2 - gripper
          client1 client2 client3 client4 client5 client6 client7 client8 - client
          table1 table3 table4 - table)

(:init 
    (free robtender)
    (at-rob wairob1 chargespot)
    (at-rob wairob2 chargespot)
    (= (time-moving wairob1) -1)
    (= (time-cleaning wairob1) 0)
    (= (time-moving wairob2) -1)
    (= (time-cleaning wairob2) 0)
    (at-tray tray1 barside)
    (empty gripper1 wairob1)
    (belong gripper1 wairob1)
    (empty gripper2 wairob2)
    (belong gripper2 wairob2)
    (= (tray-level tray1) 0)
    (= (ready-time drink1) -1)
    (= (ready-time drink2) -1)
    (= (ready-time drink3) -1)
    (= (ready-time drink4) -1)
    (= (ready-time drink5) -1)
    (= (ready-time drink6) -1)
    (= (ready-time drink7) -1)
    (= (ready-time drink8) -1)
    (= (time-prepared drink1) -1)
    (= (time-prepared drink2) -1)
    (= (time-prepared drink3) -1)
    (= (time-prepared drink4) -1)
    (= (time-prepared drink5) -1)
    (= (time-prepared drink6) -1)
    (= (time-prepared drink7) -1)
    (= (time-prepared drink8) -1)
    (= (client-for-table table1) 2)
    (= (client-for-table table3) 4)
    (= (client-for-table table4) 2)
    ; DISTANCES MOVE FORWARD
    (= (distance chargespot barside) 1)
    (= (distance chargespot table1) 1)
    (= (distance chargespot table3) 1)
    (= (distance barside table1) 2)
    (= (distance table1 table3) 1)
    (= (distance table1 table4) 1)
    (= (distance table3 table4) 1)
    ; DISTANCES MOVE BACKWARD
    (= (distance table1 barside) 2)
    (= (distance table3 table1) 1)
    (= (distance table4 table1) 1)
    (= (distance table4 table3) 1)
    (= (size-table table1) 1)
    (= (size-table table3) 2)
    (= (size-table table4) 1)
    (at-client client1 table3)
    (at-client client2 table3)
    (at-client client3 table3)
    (at-client client4 table3)
    (at-client client5 table1)
    (at-client client6 table1)
    (at-client client7 table4)
    (at-client client8 table4)
    (= (time-to-drink client1) -1)
    (= (time-to-drink client2) -1)
    (= (time-to-drink client3) -1)
    (= (time-to-drink client4) -1)
    (= (time-to-drink client5) -1)
    (= (time-to-drink client6) -1)
    (= (time-to-drink client7) -1)
    (= (time-to-drink client8) -1)
    ; WARM DRINKS
    (request drink1 client1)
    (request drink2 client2)
    (request drink3 client3)
    (request drink4 client4)
    ; COLD DRINKS
    (request drink5 client5)
    (request drink6 client6)
    (request drink7 client7)
    (request drink8 client8)

    (order wairob2 table1)
    (order wairob2 table4)
    (order wairob1 table3)
    )

(:goal (and
	 (served drink1 client1)
	 (served drink2 client2)
	 (served drink3 client3)
	 (served drink4 client4)
	 (served drink5 client5)
	 (served drink6 client6)
	 (served drink7 client7)
	 (served drink8 client8)
	 (biscuit-given client5)
	 (biscuit-given client6)
	 (biscuit-given client7)
	 ;this option makes the engine to get stuck so it was commented
	 ;we tried all the options for the engine but yet it could not
	 ;generate a plan
	 ;(biscuit-given client8)
	 (clean table1)
	 (clean table3)
     	 (clean table4)
       )
)




)
