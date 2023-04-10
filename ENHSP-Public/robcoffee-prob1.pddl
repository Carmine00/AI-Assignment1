(define (problem robcoffee-prob1)
(:domain robcoffee)

(:objects robtender - barista
          wairob - waiter
          barside - bar
          drink1 drink2 - cold
          tray1 - tray
          gripper1 - gripper
          client1 client2 - client
          table2 table3 table4 - table)

(:init 
    (free robtender)
    (at-rob wairob barside)
    (= (time-moving wairob) 0)
    (= (time-cleaning wairob) -1)
    (at-tray tray1 barside)
    (empty gripper1)
    (= (tray-level tray1) 0)
    (= (ready-time drink1) -1)
    (= (ready-time drink2) -1)
    (= (time-prepared drink1) -1)
    (= (time-prepared drink2) -1)
    (= (client-for-table table2) 2)
    (= (client-for-table table3) 0)
    (= (client-for-table table4) 0)
    (= (connected table2 barside) 2)
    (= (connected table3 barside) 3)
    (= (connected table4 barside) 3)
    (= (connected barside table2) 2)
    (= (connected barside table3) 3)
    (= (connected barside table4) 3)
    (= (connected table2 table3) 1)
    (= (connected table2 table4) 1)
    (= (connected table3 table2) 1)
    (= (connected table4 table2) 1)
    (= (connected table3 table4) 1)
    (= (connected table4 table3) 1)
    (= (size-table table2) 1)
    (= (size-table table3) 2)
    (= (size-table table4) 1)
    (at-client client1 table2)
    (at-client client2 table2)
    (= (time-to-drink client1) -1)
    (= (time-to-drink client2) -1)
    (request drink1 client1)
    (request drink2 client2)
    (dirty table3)
    (dirty table4)
    )

(:goal (and
	 (served drink1 client1)
	 (served drink2 client2)
	 (biscuit-given client1)
	 (biscuit-given client2)
	 (not (dirty table2))
	 (not (dirty table3))
         (not (dirty table4))
       )
)


)
