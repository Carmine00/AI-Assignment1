(define (problem instance_8_1_1)
  (:domain mt-plant-watering-constrained)
  (:objects
    agent1 - agent
	tap1 - tap
	plant1 - plant
  )

  (:init
    (= (max_int) 20)
	(= (maxx) 8)
	(= (minx) 1)
	(= (maxy) 8)
	(= (miny) 1)
	(= (carrying) 0)
	(= (total_poured) 0)
	(= (total_loaded) 0)
	(= (poured plant1) 0)
	(= (x agent1) 8)
	(= (y agent1) 6)
	(= (x plant1) 5)
	(= (y plant1) 5)
	(= (x tap1) 5)
	(= (y tap1) 5)
  )

  (:goal (and 
    (= (poured plant1) 7)
	(= (total_poured) (poured plant1) )
  ))

  
  

  
)
