(define (problem robcoffee-prob1)
(:domain robcoffee)

(:objects robtender - barista
          wairob - waiter
          barside - bar
          gripper1 - gripper
          drink1 - warm
          table1 table2 - table
        )

(:init 
    (free robtender)
    (at-rob wairob barside)
    (empty gripper1)
    (= (size-table table1) 2)
     (= (size-table table1) 3)
    (= (time-cleaning wairob) 0)
     (= (client-for-table table1) 0)
     (= (client-for-table table2) 0)
     (dirty table1)
      (dirty table2)
    )

(:goal (and 
	(ready drink1)
        (not (dirty table1))
        ;(not (dirty table2))
        )

)
)
