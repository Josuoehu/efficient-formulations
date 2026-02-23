(define (problem prob)
(:domain barman)
(:objects 
  shaker1 - SHAKER
  left - HAND
  right - HAND
  shot1 - SHOT
  shot2 - SHOT
  shot3 - SHOT
  shot4 - SHOT
  ingredient1 - INGREDIENT
  ingredient2 - INGREDIENT
  ingredient3 - INGREDIENT
  cocktail1 - COCKTAIL
  cocktail2 - COCKTAIL
  cocktail3 - COCKTAIL
  dispenser1 - DISPENSER
  dispenser2 - DISPENSER
  dispenser3 - DISPENSER
  l0 - LEVEL
  l1 - LEVEL
  l2 - LEVEL
)
(:init
  (ontable_shaker shaker1)
  (ontable_shot shot1)
  (ontable_shot shot2)
  (ontable_shot shot3)
  (ontable_shot shot4)
  (dispenses dispenser1 ingredient1)
  (dispenses dispenser2 ingredient2)
  (dispenses dispenser3 ingredient3)
  (clean_shaker shaker1)
  (clean_shot shot1)
  (clean_shot shot2)
  (clean_shot shot3)
  (clean_shot shot4)
  (empty_shaker shaker1)
  (empty_shot shot1)
  (empty_shot shot2)
  (empty_shot shot3)
  (empty_shot shot4)
  (handempty left)
  (handempty right)
  (shaker-empty-level shaker1 l0)
  (shaker-level shaker1 l0)
  (next l0 l1)
  (next l1 l2)
  (cocktail-part1 cocktail1 ingredient3)
  (cocktail-part2 cocktail1 ingredient1)
  (cocktail-part1 cocktail2 ingredient2)
  (cocktail-part2 cocktail2 ingredient3)
  (cocktail-part1 cocktail3 ingredient1)
  (cocktail-part2 cocktail3 ingredient2)
)
(:goal   (and (contains_shot_cocktail shot1 cocktail3)
  (contains_shot_cocktail shot2 cocktail1)
  (contains_shot_cocktail shot3 cocktail2)))
)
