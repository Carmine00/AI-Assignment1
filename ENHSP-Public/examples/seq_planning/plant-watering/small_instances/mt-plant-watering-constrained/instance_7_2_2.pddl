(define (problem instance_7_2_2)
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
	(= (x agent1) 7)
	(= (y agent1) 5)
	(= (x tap1) 6)
	(= (y tap1) 6)
	(= (x plant1) 3)
	(= (y plant1) 3)
	(= (x plant2) 4)
	(= (y plant2) 4)
  )

  (:goal (and 
    (= (poured plant1) 7)
	(= (poured plant2) 5)
	(= (total_poured) (+ (poured plant1) (poured plant2)) )
  ))

  
  

  
)
