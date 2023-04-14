(define (domain motion)  
   (:requirements :time :fluents :strips :adl :typing :equality)
   
   (:types 
    waiter
    table bar station - location
    )
    
    (:predicates 
    (at-rob ?r - waiter ?l - location)
    (fast-moving ?w - waiter ?from ?to - location)
    (slow-moving ?w - waiter ?from ?to - location)
    (passed ?l - location)
    )
    
   (:functions 
               (time-moving ?w - waiter)
               (distance ?l1 ?l2 - location)
               (type-motion)
               (tot-time)
    )
   
   
   (:action init-fast-motion
        :parameters (?w - waiter
                     ?from ?to - location)
        :precondition (and (at-rob ?w ?from)
        		(not (passed ?to))
                        (= (type-motion) 0))
        :effect (and 
        	 (not (at-rob ?w ?from))
        	 (fast-moving ?w ?from ?to)
        	)
    )
    
    (:action init-slow-motion
        :parameters (?w - waiter
                     ?from ?to - location)
        :precondition (and (at-rob ?w ?from)
        		(= (type-motion) 1))
        :effect (and 
        	 (not (at-rob ?w ?from))
        	 (slow-moving ?w ?from ?to))
     )
     
   
   (:process move-fast
        :parameters (?w - waiter
                     ?from ?to - location)
        :precondition (and (fast-moving ?w ?from ?to)
                        (< (time-moving ?w) (/ (distance ?from ?to) 2))
                        )
        :effect (increase (time-moving ?w) (* 1 #t))
    )
    
    (:process move-slow
        :parameters (?w - waiter
                     ?from ?to - location)
        :precondition (and (slow-moving ?w ?from ?to)
                        (< (time-moving ?w) (/ (distance ?from ?to) 1))
                        )
        :effect (and
        		
        	 (increase (time-moving ?w) (* 1 #t)))
     )
    
    
    (:action stop-fast-motion
        :parameters (?w - waiter
                     ?from ?to - location)
        :precondition (and (fast-moving ?w ?from ?to)
                        (>= (time-moving ?w) (/ (distance ?from ?to) 2))
                      )
        :effect (and 
        	(increase (tot-time) (time-moving ?w))
        	 (at-rob ?w ?to)
        	 (passed ?to)
        	 (not (fast-moving ?w ?from ?to))
        	 (assign (time-moving ?w) 0)
        	)
    )
    
    (:event stop-slow-motion
        :parameters (?w - waiter
                     ?from ?to - location)
        :precondition (and (slow-moving ?w ?from ?to)
                        (>= (time-moving ?w) (/ (distance ?from ?to) 1)) 
                        )
        :effect (and 
        	 (increase (tot-time) (time-moving ?w))
        	 (at-rob ?w ?to)
        	 (passed ?to)
        	 (not (slow-moving ?w ?from ?to))
        	 (assign (time-moving ?w) 0))
    )
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
)
