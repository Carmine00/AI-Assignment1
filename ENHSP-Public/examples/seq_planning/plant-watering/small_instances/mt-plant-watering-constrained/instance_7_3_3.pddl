(define (problem instance_7_3_3)
  (:domain mt-plant-watering-constrained)
  (:objects
    tap1 - tap
	agent1 - agent
	plant2 plant1 plant3 - plant
  )

  (:init
    (= (max_int) 60)
	(= (maxx) 7)
	(= (minx) 1)
	(= (maxy) 7)
	(= (miny) 1)
	(= (carrying) 0)
	(= (total_poured) 0)
	(= (total_loaded) 0)
	(= (poured plant1) 0)
	(= (poured plant2) 0)
	(= (poured plant3) 0)
	(= (x agent1) 7)
	(= (y agent1) 1)
	(= (x plant2) 5)
	(= (y plant2) 5)
	(= (x tap1) 1)
	(= (y tap1) 1)
	(= (x plant1) 5)
	(= (y plant1) 5)
	(= (x plant3) 2)
	(= (y plant3) 2)
  )

  (:goal (and 
    (= (poured plant1) 7)
	(= (poured plant2) 10)
	(= (poured plant3) 4)
	(= (total_poured) (+ (+ (poured plant1) (poured plant2)) (poured plant3)) )
  ))

  
  

  
)
