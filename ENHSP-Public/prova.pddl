(define (domain robcoffee)  
   (:requirements :fluents :strips :adl :typing :equality)
   
   (:types 
    barista 
    waiter
    client
    warm cold - drink
    gripper
    table bar - location
    tray
    )
    
    
    
   (:predicates 
    (free ?b - barista)
    (at-rob ?r - waiter ?l - location)
    (at-client ?c - client ?l - table)
    (at-drink ?d - drink ?l - location)
    (ready ?d - drink)
    (waiter-cleaning ?w - waiter ?t - table)
    (at-tray ?t - tray ?l - bar)
    (hold-drink ?g - gripper ?d - drink)
    (hold-tray ?g - gripper ?t - tray)
    (carrying-biscuit ?g)
    (empty ?g - gripper)
    (on-tray ?t - tray ?d - drink)
    (dirty ?t - table)
    (clean ?t - table)
    (request ?d - drink ?c - client)
    (served ?d - drink ?c - client)
    (biscuit-given ?c - client)
    )
    
   (:functions (tray-level ?t - tray)
               (time-prepared ?d - drink)
               (connected ?l1 ?l2 - location)
               (size-table ?t - table)
               (time-to-drink ?c - client)
               (client-for-table ?t - table)
   )
   
    (:process clean-table
        :parameters (?t - table
                     ?w - waiter)
        :precondition (and (waiter-cleaning ?w ?t)
        		(< (time-cleaning ?w) (* (size-table ?t) 2)))
        :effect (increase (time-cleaning ?w) (* 1 #t))
                     
    )
                     
    (:process make-warm-drink
        :parameters (?b - bar
                     ?wd - drink
                     ?a - barista
                    )
        :precondition (and (at-drink ?wd ?b)
                           (not (free ?a))
                           (< (time-prepared ?wd) 5))
        :effect (increase (time-prepared ?wd) (* 1 #t))
    )
    
    (:event ready-drink
        :parameters (?wd - warm 
        	     ?a - barista 
        	     ?b - bar)
        :precondition (and (not (ready ?wd))
        		(= (time-prepared ?wd) 5))
        :effect (and 
                     (free ?a)
                     (ready ?wd))
    )
    
    (:event table-dirty 
        :parameters (?t - table)
        :precondition (and (= (client-for-table ?t) 0)
        		(not (dirty ?t)))
        :effect (dirty ?t)
    )

    
    (:action done-cleaning
        :parameters (?t - table
        	     ?w - waiter)
        :precondition (and (dirty ?t)
        	       (>= (time-cleaning ?w) (* (size-table ?t) 2))
        	      )
        :effect (and (not (dirty ?t))
        	(not (waiter-cleaning ?w ?t))
        	(assign (time-cleaning ?w) 0)
        	(assign (client-for-table ?t) -1)) ;identifier to invalidate event table-dirty
    )
    
      (:action move-forward
        :parameters (?w - waiter
                     ?from - bar
                     ?to - table)
        :precondition (and (at-rob ?w ?from)
                        )
        :effect (and 
        	 (not (at-rob ?w ?from))
        	(at-rob ?w ?to)
        	)
    )
    
     (:action move-backward
        :parameters (?w - waiter
                     ?from - table 
                     ?to - bar)
        :precondition (and (at-rob ?w ?from)
                        )
        :effect (and 
        	 (not (at-rob ?w ?from))
        	(at-rob ?w ?to)
        	)
    )
    
    (:action move-table
        :parameters (?w - waiter
                     ?from - table 
                     ?to - table)
        :precondition (and (at-rob ?w ?from)
                        )
        :effect (and 
        	 (not (at-rob ?w ?from))
        	(at-rob ?w ?to)
        	)
    )
    
    
   
   
   (:action prepare-warm-drink
        :parameters (?wd - warm 
        			 ?a - barista 
        			 ?b - bar)
        :precondition (free ?a)
        :effect (and (at-drink ?wd ?b)
                     (not (free ?a))
                     (assign (time-prepared ?wd) 0))
    )
    
    (:action start-cleaning 
        :parameters (?t - table
        	     ?g - gripper
        	     ?w - waiter)
        :precondition (and (empty ?g)
        		(dirty ?t)
        		(at-rob ?w ?t)
        		(not (waiter-cleaning ?w ?t)))
        :effect (waiter-cleaning ?w ?t)
    )
    
    
    

    


    
    
)   
