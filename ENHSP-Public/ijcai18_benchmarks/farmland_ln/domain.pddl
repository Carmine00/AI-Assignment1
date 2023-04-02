(define (domain farmland_ln)
    (:types farm -object
            
    )
    (:predicates (adj ?f1 ?f2 -farm))
    (:functions
        (x ?b -farm)
        (cost)
        (num-of-cars)
    )

    ;; Move a person from a unit f1 to a unit f2
    (:action move-by-car
        :parameters (?f1 ?f2 -farm)
        :precondition (and (not (= ?f1 ?f2)) (>= (x ?f1) (* 4 (num-of-cars))) (adj ?f1 ?f2) )
        :effect (and  (decrease (x ?f1) (* 4 (num-of-cars))) 
                      (increase (x ?f2) (* 4 (num-of-cars)))
                      (increase (cost) (* 0.1  (* 4 (num-of-cars))))
                )
    )
    
    (:action move-slow
         :parameters (?f1 ?f2 -farm)
         :precondition (and (not (= ?f1 ?f2)) (>= (x ?f1) 1) (adj ?f1 ?f2))
         :effect (and(decrease (x ?f1) 1) (increase (x ?f2) 1))
    )

    (:action hire-car
        :parameters ()
        :effect (and  (increase (num-of-cars) 1))
    )
)
