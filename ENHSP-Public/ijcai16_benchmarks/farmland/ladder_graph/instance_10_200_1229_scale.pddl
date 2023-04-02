;; Enrico Scala (enricos83@gmail.com) and Miquel Ramirez (miquel.ramirez@gmail.com)
;;Setting seed to 1229
(define (problem instance_10_200_1229_scale)
	(:domain farmland)
	(:objects
		farm0 farm1 farm2 farm3 farm4 farm5 farm6 farm7 farm8 farm9  - farm
	)
  (:init
		(= (x farm0) 1)
		(= (x farm1) 0)
		(= (x farm2) 200)
		(= (x farm3) 0)
		(= (x farm4) 0)
		(= (x farm5) 0)
		(= (x farm6) 1)
		(= (x farm7) 0)
		(= (x farm8) 1)
		(= (x farm9) 1)
		
		(adj farm0 farm1)
		(adj farm0 farm5)
		(adj farm1 farm0)
		(adj farm1 farm2)
		(adj farm1 farm6)
		(adj farm2 farm1)
		(adj farm2 farm3)
		(adj farm2 farm7)
		(adj farm3 farm8)
		(adj farm3 farm2)
		(adj farm3 farm4)
		(adj farm4 farm9)
		(adj farm4 farm3)
		(adj farm5 farm0)
		(adj farm5 farm6)
		(adj farm6 farm1)
		(adj farm6 farm5)
		(adj farm6 farm7)
		(adj farm7 farm8)
		(adj farm7 farm2)
		(adj farm7 farm6)
		(adj farm8 farm9)
		(adj farm8 farm3)
		(adj farm8 farm7)
		(adj farm9 farm8)
		(adj farm9 farm4)
		
		(= (cost) 0)
	)
	(:goal
		(and
			(> (x farm0) 0)
			(> (x farm1) 0)
			(> (x farm2) 0)
			(> (x farm3) 0)
			(> (x farm4) 0)
			(> (x farm5) 0)
			(> (x farm6) 0)
			(> (x farm7) 0)
			(> (x farm8) 0)
			(> (x farm9) 0)
			
			(> (+ (* 1.5 (x farm0))(+ (* 1.3 (x farm1))(+ (* 1.0 (x farm2))(+ (* 1.2 (x farm3))(+ (* 1.4 (x farm4))(+ (* 1.4 (x farm5))(+ (* 2.0 (x farm6))(+ (* 1.4 (x farm7))(+ (* 1.9 (x farm8))(+ (* 1.4 (x farm9)) 0)))))))))) 280.0)
		)
	)
)


