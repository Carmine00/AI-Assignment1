(define (domain robcoffee)  
   (:requirements :time :fluents :strips :adl :typing :equality)
   
   (:types 
    barista 
    waiter
    client
    warm cold - drink
    gripper
    table bar station - location
    tray
    )
    
    
    
   (:predicates 
    (free ?b - barista) ;barista free to prepare drinks
    (at-rob ?r - waiter ?l - location) ;identify where waiter is
    (at-client ?c - client ?l - table) ;identify where client is
    (at-drink ?d - drink ?l - location) ;identify where drink is (bar or table)
    (ready ?d - drink) ;the drink has been prepared
    (cooling ?wd - warm) ;a warm drink has begun to cool down
    (at-tray ?t - tray ?l - bar) ;the tray is located at the bar
    (hold-drink ?g - gripper ?d - drink ?w - waiter) ;waiter holding drink with gripper
    (hold-tray ?g - gripper ?t - tray ?w - waiter) ;waiter holds tray
    (belong ?g - gripper ?w - waiter) ;identify the gripper to each single waiter
    (carrying-biscuit ?g - gripper ?w - waiter) ;waiter is carrying a biscuit with a specific gripper
    (empty ?g - gripper ?w - waiter) ;gripper free to carry something
    (on-tray ?t - tray ?d - drink) ;drink has been located on the tray
    (dirty ?t - table) ;table is dirty
    (fast-moving ?w - waiter ?from ?to - location) ;waiter is moving fast from an initial point to a final one
    (slow-moving ?w - waiter ?from ?to - location) ;waiter is moving slow from an initial point to a final one
    (waiter-cleaning ?w - waiter) ;waiter is involved in the cleaning process
    (table-cleaning ?t - table) ;a specific table is being cleaned
    (request ?d - drink ?c - client) ;a specific drink has been requested by a client
    (served ?d - drink ?c - client) ;a specific drink has been given to a client
    (biscuit-given ?c - client) ;the biscuit has been given to the client
    (order ?w - waiter ?t - table) ;a waiter has been assigned to a table
    (clean ?t - table) ;if set to true, the table is now clean
    )
    
   (:functions (tray-level ?t - tray) ;up to maxinum 3 drinks can be on the trya
               (ready-time ?d - drink) ;time needed to prepare the drink
               (time-prepared ?d - drink) ;time elapsed from the preparation
               (time-moving ?w - waiter) ;time elapsed while moving 
               (time-cleaning ?w - waiter) ;time elapsed while cleaning
               (distance ?l1 ?l2 - location) ;distance between two locations
               (size-table ?t - table) ;dimension of each table
               (time-to-drink ?c - client) ;time given for each client to drink
               (client-for-table ?t - table) ;number of clients for tables, needed for drinking
               
               
   )
   
   ;;;;;
   ; PROCESSES
   
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
     
      (:process warm-cool-down
        :parameters (?w - warm)
        :precondition (cooling ?w)  
        :effect (and (increase (time-prepared ?w) (* 1 #t)))
    )
    
    
    (:process finish-drink
        :parameters (?c - client
                     ?d - drink
                     ?t - table)
        :precondition (and (at-client ?c ?t)
                           (served ?d ?c)
                           (> (time-to-drink ?c) 0))
        :effect (decrease (time-to-drink ?c) (* 1 #t))
    )
    
      (:process clean-table
        :parameters (?t - table
                     ?w - waiter)
        :precondition (and (waiter-cleaning ?w)
        		(table-cleaning ?t)
        		(< (time-cleaning ?w) (* (size-table ?t) 2)))
        :effect (increase (time-cleaning ?w) (* 1 #t))
                     
    )
   
   
   ;;;;;
   ; EVENTS
   
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
                     (cooling ?wd)
                     (assign (time-prepared ?wd) 0)
                     )
    )
    
    (:event warm-served
        :parameters (?w - warm
        	     ?c - client)
        :precondition (and
        		(cooling ?w)
        		(served ?w ?c))  
        :effect (not (cooling ?w))
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
                )
    )
    
    (:event stop-fast-motion
        :parameters (?w - waiter
                     ?from ?to - location)
        :precondition (and (fast-moving ?w ?from ?to)
                        (>= (time-moving ?w) (/ (distance ?from ?to) 2)) ;timer purpose
                        )
        :effect (and 
        	 (at-rob ?w ?to)
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
        	 (at-rob ?w ?to)
        	 (not (slow-moving ?w ?from ?to))
        	 (assign (time-moving ?w) 0))
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
        		(not (dirty ?t))
        	      )
        :effect (dirty ?t)
    )
    
    (:event done-cleaning
        :parameters (?t - table
        	     ?w - waiter)
        :precondition (and (dirty ?t)
        		(waiter-cleaning ?w)
        		(table-cleaning ?t)
        	       (>= (time-cleaning ?w) (* (size-table ?t) 2))
        	      )
        :effect (and (not (dirty ?t))
        	(clean ?t)
        	(not (waiter-cleaning ?w))
        	(not (table-cleaning ?t))
        	(assign (time-cleaning ?w) 0)
        	(assign (client-for-table ?t) -1)) ;identifier to invalidate event table-dirty
    )
   
   
   ;;;;;
   ; ACTIONS
   
   
   (:action prepare-warm-drink
        :parameters (?wd - warm 
        	     ?a - barista 
        	     ?b - bar
        	     ?c - client
        	     ?t - table)
        :precondition (and (free ?a)
        		(request ?wd ?c)
        	      (not (ready ?wd)))
        :effect (and (at-drink ?wd ?b)
                     (not (free ?a))
                     (assign (ready-time ?wd) 0))
    )
                     
    
    (:action prepare-cold-drink
        :parameters (?cd - cold 
        	     ?a - barista 
        	     ?b - bar
        	     ?c - client
        	     ?t - table)
        :precondition (and (free ?a)
        		(request ?cd ?c)
        	      (not (ready ?cd)))
        :effect (and (at-drink ?cd ?b)
                     (not (free ?a))
                     (assign (ready-time ?cd) 0))
    )
    
    
    (:action take-tray
        :parameters (?w - waiter
                     ?t - tray
                     ?g - gripper
                     ?b - bar
                     ?l - table
					 )
        :precondition (and (at-rob ?w ?b)
                           (at-tray ?t ?b)
                           (order ?w ?t)
                           (empty ?g ?w)
                           (belong ?g ?w))
        :effect (and (hold-tray ?g ?t ?w)
                     (not (empty ?g ?w))
                     (not (at-tray ?t ?b)))
    )
    
    (:action give-tray
        :parameters (?w - waiter
                     ?t - tray
                     ?g - gripper
                     ?b - bar)
        :precondition (and (at-rob ?w ?b)
                           (hold-tray ?g ?t ?w)
                           (= (tray-level ?t) 0))
        :effect (and (not (hold-tray ?g ?t ?w))
                     (empty ?g ?w)
                     (at-tray ?t ?b))
    )
    
    (:action take-drink-tray
        :parameters (?w - waiter
                     ?t - tray
                     ?g - gripper
                     ?d - drink
                     ?b - bar
                     ?l - table
                     ?c - client)
        :precondition (and (at-rob ?w ?b)
                           (hold-tray ?g ?t ?w)
                           (at-drink ?d ?b)
                           (order ?w ?l)
                           (request ?d ?c)
                           (at-client ?c ?l)
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
                     ?b - bar
                     ?l - table
                     ?c - client)
        :precondition (and (at-rob ?w ?b)
                           (empty ?g ?w)
                           (belong ?g ?w)
                           (order ?w ?l)
                           (at-drink ?d ?b)
                           (ready ?d)
                           (request ?d ?c)
                           (at-client ?c ?l))
        :effect (and (hold-drink ?g ?d ?w)
                     (not (empty ?g ?w))
                     (not (at-drink ?d ?b)))
    )
    
    (:action init-fast-motion
        :parameters (?w - waiter
                     ?g - gripper
                     ?t - tray
                     ?from ?to - location)
        :precondition (and (at-rob ?w ?from)
                        (not (hold-tray ?g ?t ?w))
                        (belong ?g ?w)
                        (not (waiter-cleaning ?w)))
        :effect (and 
        	 (not (at-rob ?w ?from))
        	 (fast-moving ?w ?from ?to)
        	)
    )
    
    
    (:action init-slow-motion
        :parameters (?w - waiter
                     ?g - gripper
                     ?t - tray
                     ?from ?to - location)
        :precondition (and (at-rob ?w ?from)
                        (hold-tray ?g ?t ?w)
                        (not (waiter-cleaning ?w))
                       )
        :effect (and 
        	 (not (at-rob ?w ?from))
        	 (slow-moving ?w ?from ?to)
        	)
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
                           (hold-tray ?g ?t ?w)
                           (request ?d ?c)
                           (<= (time-prepared ?d) 4))
        :effect (and (decrease (tray-level ?t) 1)
                     (at-drink ?d ?l)
                     (served ?d ?c)
                     (not (request ?d ?c))
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
                           (hold-drink ?g ?d ?w)
                           (request ?d ?c)
                           (<= (time-prepared ?d) 4))
        :effect (and (at-drink ?d ?l)
                     (served ?d ?c)
                     (not (request ?d ?c))
                     (empty ?g ?w)
                     (assign (time-to-drink ?c) 4)
                     (not (hold-drink ?g ?d ?w)))
    )
    
    
    
    (:action take-biscuit
        :parameters (?w - waiter
                     ?d - cold
                     ?g - gripper
                     ?b - bar
                     ?c - client
                     ?t - table)
        :precondition (and (at-rob ?w ?b)      				
                           (served ?d ?c)
                           (order ?w ?t)
                           (not (biscuit-given ?c))
                           (empty ?g ?w)
                           (belong ?g ?w)
                           (at-client ?c ?t)
                     )
        :effect (and  (carrying-biscuit ?g ?w)
                      (not (empty ?g ?w)))
    )
    
    
    (:action give-biscuit
        :parameters (?w - waiter
                     ?g - gripper
                     ?t - table
                     ?c - client)
        :precondition (and (at-rob ?w ?t)
        		   (order ?w ?t)
                           (carrying-biscuit ?g ?w)
                           (at-client ?c ?t))
        :effect (and  (biscuit-given ?c)
                      (empty ?g ?w)
                      (not (carrying-biscuit ?g ?w)))
    )
    
    (:action start-cleaning 
        :parameters (?t - table
        	     ?g - gripper
        	     ?w - waiter)
        :precondition (and (empty ?g ?w)
        		(dirty ?t)
        		(at-rob ?w ?t)
        		(= (client-for-table ?t) 0)
        		(not (table-cleaning ?t))
        		(not (waiter-cleaning ?w)))
        :effect (and (table-cleaning ?t)
        	   (waiter-cleaning ?w))
        	
    )
    
   
    
  
    
    
    
    
    
    
    
    
    
)   
