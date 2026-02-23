(define (domain barman)
(:requirements :strips :typing :action-costs)
(:types 
  dispenser - OBJECT
  container - OBJECT
  ingredient - BEVERAGE
  level - OBJECT
  cocktail - BEVERAGE
  beverage - OBJECT
  shaker - CONTAINER
  hand - OBJECT
  shot - CONTAINER
)
(:predicates 
  (ontable_shaker ?c - SHAKER)
  (ontable_shot ?c - SHOT)
  (holding_shaker ?h - HAND ?c - SHAKER)
  (holding_shot ?h - HAND ?c - SHOT)
  (handempty ?h - HAND)
  (empty_shaker ?c - SHAKER)
  (empty_shot ?c - SHOT)
  (contains_shaker_cocktail ?c - SHAKER ?b - COCKTAIL)
  (contains_shaker_ingredient ?c - SHAKER ?b - INGREDIENT)
  (contains_shot_cocktail ?c - SHOT ?b - COCKTAIL)
  (contains_shot_ingredient ?c - SHOT ?b - INGREDIENT)
  (clean_shaker ?c - SHAKER)
  (clean_shot ?c - SHOT)
  (used_shaker_cocktail ?c - SHAKER ?b - COCKTAIL)
  (used_shaker_ingredient ?c - SHAKER ?b - INGREDIENT)
  (used_shot_cocktail ?c - SHOT ?b - COCKTAIL)
  (used_shot_ingredient ?c - SHOT ?b - INGREDIENT)
  (dispenses ?d - DISPENSER ?i - INGREDIENT)
  (shaker-empty-level ?s - SHAKER ?l - LEVEL)
  (shaker-level ?s - SHAKER ?l - LEVEL)
  (next ?l1 - LEVEL ?l2 - LEVEL)
  (unshaked ?s - SHAKER)
  (shaked ?s - SHAKER)
  (cocktail-part1 ?c - COCKTAIL ?i - INGREDIENT)
  (cocktail-part2 ?c - COCKTAIL ?i - INGREDIENT)
)
(:action fill-shot
:parameters (?s - SHOT ?i - INGREDIENT ?h1 - HAND ?h2 - HAND ?d - DISPENSER)
:precondition 
  (and (holding_shot ?h1 ?s)
  (handempty ?h2)
  (dispenses ?d ?i)
  (empty_shot ?s)
  (clean_shot ?s))
:effect 
  (and (not (empty_shot ?s))
  (contains_shot_ingredient ?s ?i)
  (not (clean_shot ?s))
  (used_shot_ingredient ?s ?i))
)
(:action refill-shot
:parameters (?s - SHOT ?i - INGREDIENT ?h1 - HAND ?h2 - HAND ?d - DISPENSER)
:precondition 
  (and (holding_shot ?h1 ?s)
  (handempty ?h2)
  (dispenses ?d ?i)
  (empty_shot ?s)
  (used_shot_ingredient ?s ?i))
:effect 
  (and (not (empty_shot ?s))
  (contains_shot_ingredient ?s ?i))
)
(:action pour-shot-to-clean-shaker
:parameters (?s - SHOT ?i - INGREDIENT ?d - SHAKER ?h1 - HAND ?l - LEVEL ?l1 - LEVEL)
:precondition 
  (and (holding_shot ?h1 ?s)
  (contains_shot_ingredient ?s ?i)
  (empty_shaker ?d)
  (clean_shaker ?d)
  (shaker-level ?d ?l)
  (next ?l ?l1))
:effect 
  (and (not (contains_shot_ingredient ?s ?i))
  (empty_shot ?s)
  (contains_shaker_ingredient ?d ?i)
  (not (empty_shaker ?d))
  (not (clean_shaker ?d))
  (unshaked ?d)
  (not (shaker-level ?d ?l))
  (shaker-level ?d ?l1))
)
(:action pour-shot-to-used-shaker
:parameters (?s - SHOT ?i - INGREDIENT ?d - SHAKER ?h1 - HAND ?l - LEVEL ?l1 - LEVEL)
:precondition 
  (and (holding_shot ?h1 ?s)
  (contains_shot_ingredient ?s ?i)
  (unshaked ?d)
  (shaker-level ?d ?l)
  (next ?l ?l1))
:effect 
  (and (not (contains_shot_ingredient ?s ?i))
  (contains_shaker_ingredient ?d ?i)
  (empty_shot ?s)
  (not (shaker-level ?d ?l))
  (shaker-level ?d ?l1))
)
(:action empty-shaker
:parameters (?h - HAND ?s - SHAKER ?b - COCKTAIL ?l - LEVEL ?l1 - LEVEL)
:precondition 
  (and (holding_shaker ?h ?s)
  (contains_shaker_cocktail ?s ?b)
  (shaked ?s)
  (shaker-level ?s ?l)
  (shaker-empty-level ?s ?l1))
:effect 
  (and (not (shaked ?s))
  (not (shaker-level ?s ?l))
  (shaker-level ?s ?l1)
  (not (contains_shaker_cocktail ?s ?b))
  (empty_shaker ?s))
)
(:action clean-shaker
:parameters (?h1 - HAND ?h2 - HAND ?s - SHAKER)
:precondition 
  (and (holding_shaker ?h1 ?s)
  (handempty ?h2)
  (empty_shaker ?s))
:effect 
  (and (clean_shaker ?s))
)
(:action shake
:parameters (?b - COCKTAIL ?d1 - INGREDIENT ?d2 - INGREDIENT ?s - SHAKER ?h1 - HAND ?h2 - HAND)
:precondition 
  (and (holding_shaker ?h1 ?s)
  (handempty ?h2)
  (contains_shaker_ingredient ?s ?d1)
  (contains_shaker_ingredient ?s ?d2)
  (cocktail-part1 ?b ?d1)
  (cocktail-part2 ?b ?d2)
  (unshaked ?s))
:effect 
  (and (not (unshaked ?s))
  (not (contains_shaker_ingredient ?s ?d1))
  (not (contains_shaker_ingredient ?s ?d2))
  (shaked ?s)
  (contains_shaker_cocktail ?s ?b))
)
(:action grasp_shaker
:parameters (?h - HAND ?c - SHAKER)
:precondition 
  (and (ontable_shaker ?c)
  (handempty ?h))
:effect 
  (and (not (ontable_shaker ?c))
  (not (handempty ?h))
  (holding_shaker ?h ?c))
)
(:action grasp_shot
:parameters (?h - HAND ?c - SHOT)
:precondition 
  (and (ontable_shot ?c)
  (handempty ?h))
:effect 
  (and (not (ontable_shot ?c))
  (not (handempty ?h))
  (holding_shot ?h ?c))
)
(:action leave_shaker
:parameters (?h - HAND ?c - SHAKER)
:precondition 
  (holding_shaker ?h ?c)
:effect 
  (and (not (holding_shaker ?h ?c))
  (handempty ?h)
  (ontable_shaker ?c))
)
(:action leave_shot
:parameters (?h - HAND ?c - SHOT)
:precondition 
  (holding_shot ?h ?c)
:effect 
  (and (not (holding_shot ?h ?c))
  (handempty ?h)
  (ontable_shot ?c))
)
(:action empty-shot_cocktail
:parameters (?h - HAND ?p - SHOT ?b - COCKTAIL)
:precondition 
  (and (holding_shot ?h ?p)
  (contains_shot_cocktail ?p ?b))
:effect 
  (and (not (contains_shot_cocktail ?p ?b))
  (empty_shot ?p))
)
(:action empty-shot_ingredient
:parameters (?h - HAND ?p - SHOT ?b - INGREDIENT)
:precondition 
  (and (holding_shot ?h ?p)
  (contains_shot_ingredient ?p ?b))
:effect 
  (and (not (contains_shot_ingredient ?p ?b))
  (empty_shot ?p))
)
(:action clean-shot_cocktail
:parameters (?s - SHOT ?b - COCKTAIL ?h1 - HAND ?h2 - HAND)
:precondition 
  (and (holding_shot ?h1 ?s)
  (handempty ?h2)
  (empty_shot ?s)
  (used_shot_cocktail ?s ?b))
:effect 
  (and (not (used_shot_cocktail ?s ?b))
  (clean_shot ?s))
)
(:action clean-shot_ingredient
:parameters (?s - SHOT ?b - INGREDIENT ?h1 - HAND ?h2 - HAND)
:precondition 
  (and (holding_shot ?h1 ?s)
  (handempty ?h2)
  (empty_shot ?s)
  (used_shot_ingredient ?s ?b))
:effect 
  (and (not (used_shot_ingredient ?s ?b))
  (clean_shot ?s))
)
(:action pour-shaker-to-shot_cocktail
:parameters (?b - COCKTAIL ?d - SHOT ?h - HAND ?s - SHAKER ?l - LEVEL ?l1 - LEVEL)
:precondition 
  (and (holding_shaker ?h ?s)
  (shaked ?s)
  (empty_shot ?d)
  (clean_shot ?d)
  (contains_shaker_cocktail ?s ?b)
  (shaker-level ?s ?l)
  (next ?l1 ?l))
:effect 
  (and (not (clean_shot ?d))
  (not (empty_shot ?d))
  (contains_shot_cocktail ?d ?b)
  (shaker-level ?s ?l1)
  (not (shaker-level ?s ?l)))
)
(:action pour-shaker-to-shot_ingredient
:parameters (?b - INGREDIENT ?d - SHOT ?h - HAND ?s - SHAKER ?l - LEVEL ?l1 - LEVEL)
:precondition 
  (and (holding_shaker ?h ?s)
  (shaked ?s)
  (empty_shot ?d)
  (clean_shot ?d)
  (contains_shaker_ingredient ?s ?b)
  (shaker-level ?s ?l)
  (next ?l1 ?l))
:effect 
  (and (not (clean_shot ?d))
  (not (empty_shot ?d))
  (contains_shot_ingredient ?d ?b)
  (shaker-level ?s ?l1)
  (not (shaker-level ?s ?l)))
)
)
