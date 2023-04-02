(define (problem instance_7_2_3)
  (:domain mt-plant-watering-constrained)
  (:objects
    tap1 - tap
	plant1 plant2 - plant
	agent1 - agent
  )

  (:init
    (= (max_int) 40)
	(= (maxx) 7)
	(= (minx) 1)
	(= (maxy) 7)
	(= (miny) 1)
	(= (carrying) 0)
	(= (total_poured) 0)
	(= (total_loaded) 0)
	(= (poured plant1) 0)
	(= (poured plant2) 0)
	(= (x agent1) 1)
	(= (y agent1) 4)
	(= (x tap1) 1)
	(= (y tap1) 1)
	(= (x plant1) 7)
	(= (y plant1) 7)
	(= (x plant2) 3)
	(= (y plant2) 3)
  )

  (:goal (and 
    (= (poured plant1) 5)
	(= (poured plant2) 3)
	(= (total_poured) (+ (poured plant1) (poured plant2)) )
  ))

  
  

  
)
