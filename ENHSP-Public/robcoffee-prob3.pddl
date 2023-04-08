(define (problem robcoffee-prob1)
(:domain robcoffee)

(:objects robtender - barista
          wairob - waiter
          barside - bar
          drink1 drink2 drink3 drink4 - warm
          tray1 - tray
          gripper1 - gripper
          client1 client2 client3 client4 - client
          table1 table3 table4 - table)

(:init 
    (free robtender)
    (at-rob wairob barside)
    (= (time-moving wairob) -1)
    (= (time-cleaning wairob) -1)
    (at-tray tray1 barside)
    (empty gripper1)
    (= (tray-level tray1) 0)
    (= (ready-time drink1) -1)
    (= (ready-time drink2) -1)
    (= (ready-time drink3) -1)
    (= (ready-time drink4) -1)
    (= (time-prepared drink1) -1)
    (= (time-prepared drink2) -1)
    (= (time-prepared drink3) -1)
    (= (time-prepared drink4) -1)
    (= (client-for-table table1) 2)
    (= (client-for-table table4) 2)
    (= (client-for-table table3) 0)
    (= (connected table1 barside) 2)
    (= (connected table3 barside) 3)
    (= (connected table4 barside) 3)
    (= (connected barside table1) 2)
    (= (connected barside table3) 3)
    (= (connected barside table4) 3)
    (= (connected table1 table3) 1)
    (= (connected table1 table4) 1)
    (= (connected table3 table1) 1)
    (= (connected table4 table1) 1)
    (= (connected table3 table4) 1)
    (= (connected table4 table3) 1)
    (= (size-table table1) 1)
    (= (size-table table3) 2)
    (= (size-table table4) 1)
    (at-client client1 table1)
    (at-client client2 table1)
    (at-client client3 table4)
    (at-client client4 table4)
    (= (time-to-drink client1) -1)
    (= (time-to-drink client2) -1)
    (= (time-to-drink client3) -1)
    (= (time-to-drink client4) -1)
    (request drink1 client1)
    (request drink2 client2)
    (request drink3 client3)
    (request drink4 client4)
    (dirty table3)
    )

(:goal (and
	 (served drink1 client1)
	 (served drink2 client2)
	 (served drink3 client3)
	 (served drink4 client4)
	 (not (dirty table1))
	 (not (dirty table3))
         (not (dirty table4))
       )
)


)
