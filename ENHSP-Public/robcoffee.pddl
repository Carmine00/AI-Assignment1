(define (domain robcoffee)  
   (:requirements :time :fluents :strips :adl :typing :equality)
   
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
    (at-tray ?t - tray ?l - bar)
    (hold-drink ?g - gripper ?d - drink)
    (hold-tray ?g - gripper ?t - tray)
    (carrying-biscuit ?g)
    (empty ?g - gripper)
    (on-tray ?t - tray ?d - drink)
    (dirty ?t - table)
    (clean ?t - table)
    (fast-moving ?w - waiter)
    (slow-moving ?w - waiter)
    (waiter-cleaning ?w - waiter)
    (request ?d - drink ?c - client)
    (served ?d - drink ?c - client)
    (biscuit-given ?c - client)
    )
    
   (:functions (tray-level ?t - tray)
               (ready-time ?d - drink) ;time needed to prepare the drink
               (time-prepared ?d - drink) ;time elapsed from the preparation
               (time-moving ?w - waiter) ;time elapsed while moving (interrupt idea)
               (time-cleaning ?w - waiter) ;time elapsed while cleaning
               (goal-index ?w - waiter) ;index to reach a goal for waiter, needed for at-rob
               (identifier-loc ?l - location) ;id for each location, needed to compare goal-index (see end motion)
               (connected ?l1 ?l2 - location)
               (size-table ?t - table)
               (time-to-drink ?c - client)
               (client-for-table ?t - table)
   )
   
   
   (:action prepare-warm-drink
        :parameters (?wd - warm 
        	     ?a - barista 
        	     ?b - bar)
        :precondition (and (free ?a)
        	      (not (ready ?wd)))
        :effect (and (at-drink ?wd ?b)
                     (not (free ?a))
                     (assign (ready-time ?wd) 0))
    )
                     
    (:process making-warm-drink
        :parameters (?b - bar
                     ?wd - warm
                     ?a - barista
                    )
        :precondition (and (at-drink ?wd ?b)
                           (not (free ?a))
                           (< (ready-time ?wd) 5))
        :effect (increase (ready-time ?wd) (* 1 #t))
    )
    
    (:event ready-warm-drink
        :parameters (?wd - warm 
        	     ?a - barista 
        	     ?b - bar
        	     ?w - waiter)
        :precondition (and (>= (ready-time ?wd) 5)
        	       (not (ready ?wd)))
        :effect (and 
                     (free ?a)
                     (ready ?wd)
                     (assign (time-prepared ?wd) 0)
                     (assign (time-moving ?w) 0))
    )
    
    (:action prepare-cold-drink
        :parameters (?cd - cold 
        	     ?a - barista 
        	     ?b - bar)
        :precondition (and (free ?a)
        	      (not (ready ?cd)))
        :effect (and (at-drink ?cd ?b)
                     (not (free ?a))
                     (assign (ready-time ?cd) 0))
    )
    
    (:process making-cold-drink
        :parameters (?b - bar
                     ?cd - cold
                     ?a - barista
                    )
        :precondition (and (at-drink ?cd ?b)
                           (not (free ?a))
                           (< (ready-time ?cd) 3))
        :effect (increase (ready-time ?cd) (* 1 #t))
    )
    
    (:event ready-cold-drink
        :parameters (?cd - cold 
        	     ?a - barista 
        	     ?b - bar
        	     ?w - waiter)
        :precondition (and (>= (ready-time ?cd) 3)
        	       (not (ready ?cd)))
        :effect (and 
                     (free ?a)
                     (ready ?cd)
                     (assign (time-prepared ?cd) 0)
                     (assign (time-moving ?w) 0))
    )
    
    
    (:action take-tray
        :parameters (?w - waiter
                     ?t - tray
                     ?g - gripper
                     ?b - bar)
        :precondition (and (at-rob ?w ?b)
                           (at-tray ?t ?b)
                           (empty ?g))
        :effect (and (hold-tray ?g ?t)
                     (not (empty ?g))
                     (not (at-tray ?t ?b)))
    )
    
    (:action give-tray
        :parameters (?w - waiter
                     ?t - tray
                     ?g - gripper
                     ?b - bar)
        :precondition (and (at-rob ?w ?b)
                           (hold-tray ?g ?t)
                           (= (tray-level ?t) 0))
        :effect (and (not (hold-tray ?g ?t))
                     (empty ?g)
                     (at-tray ?t ?b))
    )
    
    (:action take-drink-tray
        :parameters (?w - waiter
                     ?t - tray
                     ?g - gripper
                     ?d - drink
                     ?b - bar)
        :precondition (and (at-rob ?w ?b)
                           (hold-tray ?g ?t)
                           (at-drink ?d ?b)
                           (ready ?d)
                           (< (tray-level ?t) 3))
        :effect (and (increase (tray-level ?t) 1)
                     (on-tray ?t ?d)
                     (not (at-drink ?d ?b)))
    )
    
    (:action take-drink-gripper
        :parameters (?w - waiter
                     ?g - gripper
                     ?d - drink
                     ?b - bar)
        :precondition (and (at-rob ?w ?b)
                           (empty ?g)
                           (at-drink ?d ?b)
                           (ready ?d))
        :effect (and (hold-drink ?g ?d)
                     (not (empty ?g))
                     (not (at-drink ?d ?b)))
    )
    
    (:action init-fast-motion
        :parameters (?w - waiter
                     ?g - gripper
                     ?t - tray
                     ?from ?to - location)
        :precondition (and (at-rob ?w ?from)
                        (not (hold-tray ?g ?t))
                        (= (time-moving ?w) 0)
                        )
        :effect (and 
        	 (not (at-rob ?w ?from))
        	 (fast-moving ?w)
        	 (assign (goal-index ?w) (identifier-loc ?to))
        	)
    )
    
    
    
    (:process move-fast
        :parameters (?w - waiter
                     ?from ?to - location)
        :precondition (and (fast-moving ?w)
        		(= (goal-index ?w) (identifier-loc ?to)) ;to avoid going to a location at same distance
                        (< (time-moving ?w) (/ (connected ?from ?to) 2))
                        )
        :effect (increase (time-moving ?w) (* 1 #t))
    )
    
    (:event stop-fast-motion
        :parameters (?w - waiter
                     ?from ?to - location)
        :precondition (and (fast-moving ?w)
        		(= (goal-index ?w) (identifier-loc ?to)) 
                        (= (time-moving ?w) (/ (connected ?from ?to) 2)) ;timer purpose
                        )
        :effect (and 
        	 (at-rob ?w ?to)
        	 (not (fast-moving ?w))
        	 (assign (time-moving ?w) 0)
        	)
    )
    
    
    (:action init-slow-motion
        :parameters (?w - waiter
                     ?g - gripper
                     ?t - tray
                     ?from ?to - location)
        :precondition (and (at-rob ?w ?from)
                        (hold-tray ?g ?t))
        :effect (and 
        	 (not (at-rob ?w ?from))
        	 (slow-moving ?w)
        	 (assign (goal-index ?w) (identifier-loc ?to))
        	)
     )
    
    
    (:process move-slow
        :parameters (?w - waiter
                     ?g - gripper
                     ?t - tray
                     ?from ?to - location)
        :precondition (and (slow-moving ?w)
        		(= (goal-index ?w) (identifier-loc ?to)) 
                        (< (time-moving ?w) (/ (connected ?from ?to) 1))
                        )
        :effect (and
        		
        	 (increase (time-moving ?w) (* 1 #t)))
     )
     
     (:event stop-slow-motion
        :parameters (?w - waiter
                     ?from ?to - location)
        :precondition (and (slow-moving ?w)
        		(= (goal-index ?w) (identifier-loc ?to)) 
                        (= (time-moving ?w) (/ (connected ?from ?to) 1)) 
                        )
        :effect (and 
        	 (at-rob ?w ?to)
        	 (not (slow-moving ?w))
        	 (assign (time-moving ?w) 0))
    )
    
    
    (:action give-drink-tray
        :parameters (?w - waiter
                     ?t - tray
                     ?g - gripper
                     ?d - drink
                     ?l - table
                     ?c - client)
        :precondition (and (at-rob ?w ?l)
                           (at-client ?c ?l)
                           (on-tray ?t ?d)
                           (hold-tray ?g ?t)
                           (request ?d ?c)
                           (<= (time-prepared ?d) 4))
        :effect (and (decrease (tray-level ?t) 1)
                     (at-drink ?d ?l)
                     (served ?d ?c)
                     (assign (time-to-drink ?c) 4)
                     (not (on-tray ?t ?d))
                )
    )
    
    (:action give-drink-gripper
        :parameters (?w - waiter
                     ?g - gripper
                     ?d - drink
                     ?l - table
                     ?c - client)
        :precondition (and (at-rob ?w ?l)
                           (at-client ?c ?l)
                           (hold-drink ?g ?d)
                           (request ?d ?c)
                           (<= (time-prepared ?d) 4))
        :effect (and (at-drink ?d ?l)
                     (served ?d ?c)
                     (empty ?g)
                     (assign (time-to-drink ?c) 4)
                     (not (hold-drink ?g ?d))
                     (not (ready ?d)))
    )
    
    
    
    
    (:process warm-cool-down
        :parameters (?w - warm)
        :precondition (and 
        		  (ready ?w)
        		  (< (time-prepared ?w) 4))
        :effect (and (increase (time-prepared ?w) 1))
    )
    
    
    (:process finish-drink
        :parameters (?c - client
                     ?d - drink
                     ?t - table)
        :precondition (and (at-client ?c ?t)
                           (served ?d ?c)
                           (> (time-to-drink ?c) 0))
        :effect (decrease (time-to-drink ?c) 1)
    )
    
    
    (:action take-biscuit
        :parameters (?w - waiter
                     ?cd - cold
                     ?g - gripper
                     ?b - bar
                     ?c - client)
        :precondition (and (at-rob ?w ?b)
                           (served ?cd ?c)
                           (empty ?g))
        :effect (and  (carrying-biscuit ?g)
                      (not (empty ?g)))
    )
    
    
    (:action give-biscuit
        :parameters (?w - waiter
                     ?g - gripper
                     ?cd - cold
                     ?t - table
                     ?c - client)
        :precondition (and (at-rob ?w ?t)
                           (carrying-biscuit ?g)
                           (served ?cd ?c))
        :effect (and  (biscuit-given ?c)
                      (empty ?g)
                      (not (carrying-biscuit ?g)))
    )
    
    (:event leave-table
        :parameters (?c - client
                     ?t - table)
        :precondition (and (= (time-to-drink ?c) 0)
        		(at-client ?c ?t))
        :effect (and  (decrease (client-for-table ?t) 1)
                      (not (at-client ?c ?t)))
    )
    
    ;make table dirty when all clients have left
    (:event table-dirty 
        :parameters (?t - table)
        :precondition (and (= (client-for-table ?t) 0)
        		(not (dirty ?t)))
        :effect (dirty ?t)
    )
    
    (:process clean-table
        :parameters (?t - table
                     ?g - gripper
                     ?w - waiter)
        :precondition (and (empty ?g)
        		(dirty ?t)
        		(< (time-cleaning ?w) (* (size-table ?t) 2)))
        :effect (increase (time-cleaning ?w) 2)
                     
    )
    
    (:event done-cleaning
        :parameters (?t - table
        	     ?w - waiter)
        :precondition (and (dirty ?t)
        	       (>= (time-cleaning ?w) (* (size-table ?t) 2))
        	      )
        :effect (and (not (dirty ?t))
        	(assign (time-cleaning ?w) 0)
        	(assign (client-for-table ?t) -1)) ;identifier to invalidate event table-dirty
    )
    
    
    
    
    
    
    
    
    
)   
