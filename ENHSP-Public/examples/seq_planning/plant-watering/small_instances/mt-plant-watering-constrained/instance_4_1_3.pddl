(define (problem instance_4_1_3)
  (:domain mt-plant-watering-constrained)
  (:objects
    agent1 - agent
	tap1 - tap
	plant1 - plant
  )

  (:init
    (= (max_int) 20)
	(= (maxx) 4)
	(= (minx) 1)
	(= (maxy) 4)
	(= (miny) 1)
	(= (carrying) 0)
	(= (total_poured) 0)
	(= (total_loaded) 0)
	(= (poured plant1) 0)
	(= (x agent1) 2)
	(= (y agent1) 1)
	(= (x plant1) 2)
	(= (y plant1) 2)
	(= (x tap1) 3)
	(= (y tap1) 3)
  )

  (:goal (and 
    (= (poured plant1) 6)
	(= (total_poured) (poured plant1) )
  ))

  
  

  
)
