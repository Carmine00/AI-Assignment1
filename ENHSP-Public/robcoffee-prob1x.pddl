(define (problem robcoffee-prob1)
(:domain robcoffee)

(:objects robtender - barista
          wairob - waiter
          barside - bar
          tray1 - tray
          gripper1 - gripper
          drink1 drink2 - warm
          drink3 drink4 - cold
        )

(:init 
    (free robtender)
    (at-rob wairob barside)
    (at-tray tray1 barside)
    (empty gripper1)
    (= (tray-level tray1) 0)
    )

(:goal (and 
        (ready drink1)
        (ready drink2)
        (ready drink3)
        (ready drink4)
        (on-tray tray1 drink1)
        (on-tray tray1 drink2)
        (on-tray tray1 drink3)
        )

)
)
