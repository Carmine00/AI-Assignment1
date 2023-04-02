(define (problem instance_7_1_2)
  (:domain mt-plant-watering-constrained)
  (:objects
    agent1 - agent
	tap1 - tap
	plant1 - plant
  )

  (:init
    (= (max_int) 20)
	(= (maxx) 7)
	(= (minx) 1)
	(= (maxy) 7)
	(= (miny) 1)
	(= (carrying) 0)
	(= (total_poured) 0)
	(= (total_loaded) 0)
	(= (poured plant1) 0)
	(= (x agent1) 4)
	(= (y agent1) 3)
	(= (x plant1) 3)
	(= (y plant1) 3)
	(= (x tap1) 2)
	(= (y tap1) 2)
  )

  (:goal (and 
    (= (poured plant1) 9)
	(= (total_poured) (poured plant1) )
  ))

  
  

  
)
