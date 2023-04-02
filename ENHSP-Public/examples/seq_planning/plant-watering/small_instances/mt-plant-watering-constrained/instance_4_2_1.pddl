(define (problem instance_4_2_1)
  (:domain mt-plant-watering-constrained)
  (:objects
    tap1 - tap
	plant1 plant2 - plant
	agent1 - agent
  )

  (:init
    (= (max_int) 40)
	(= (maxx) 4)
	(= (minx) 1)
	(= (maxy) 4)
	(= (miny) 1)
	(= (carrying) 0)
	(= (total_poured) 0)
	(= (total_loaded) 0)
	(= (poured plant1) 0)
	(= (poured plant2) 0)
	(= (x agent1) 4)
	(= (y agent1) 2)
	(= (x tap1) 4)
	(= (y tap1) 4)
	(= (x plant1) 3)
	(= (y plant1) 3)
	(= (x plant2) 3)
	(= (y plant2) 3)
  )

  (:goal (and 
    (= (poured plant1) 4)
	(= (poured plant2) 2)
	(= (total_poured) (+ (poured plant1) (poured plant2)) )
  ))

  
  

  
)
