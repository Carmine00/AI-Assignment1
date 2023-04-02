(define (problem robcoffee-prob2x)
(:domain robcoffee)

(:objects robtender - barista
          wairob - waiter
          barside - bar
          tray1 - tray
          gripper1 - gripper
          drink1 drink2 - warm
          drink3 drink4 - cold
          client1 client2 client3 - client
        )

(:init 
    (free robtender)
    (at-rob wairob barside)
    (at-tray tray1 barside)
    (empty gripper1)
    (at-client client1 barside)
    (at-client client3 barside)
    (at-client client2 barside)
    (request drink1 client1)
    (request drink2 client2)
    (request drink3 client3)
    (= (tray-level tray1) 0)
)

(:goal (and 
        (served drink1 client1)
        (served drink2 client2)
        (served drink3 client3)
        ))
)
