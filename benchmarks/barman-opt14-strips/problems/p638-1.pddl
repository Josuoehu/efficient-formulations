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
  shot5 - SHOT
  shot6 - SHOT
  shot7 - SHOT
  shot8 - SHOT
  ingredient1 - INGREDIENT
  ingredient2 - INGREDIENT
  ingredient3 - INGREDIENT
  cocktail1 - COCKTAIL
  cocktail2 - COCKTAIL
  cocktail3 - COCKTAIL
  cocktail4 - COCKTAIL
  cocktail5 - COCKTAIL
  cocktail6 - COCKTAIL
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
  (ontable_shot shot5)
  (ontable_shot shot6)
  (ontable_shot shot7)
  (ontable_shot shot8)
  (dispenses dispenser1 ingredient1)
  (dispenses dispenser2 ingredient2)
  (dispenses dispenser3 ingredient3)
  (clean_shaker shaker1)
  (clean_shot shot1)
  (clean_shot shot2)
  (clean_shot shot3)
  (clean_shot shot4)
  (clean_shot shot5)
  (clean_shot shot6)
  (clean_shot shot7)
  (clean_shot shot8)
  (empty_shaker shaker1)
  (empty_shot shot1)
  (empty_shot shot2)
  (empty_shot shot3)
  (empty_shot shot4)
  (empty_shot shot5)
  (empty_shot shot6)
  (empty_shot shot7)
  (empty_shot shot8)
  (handempty left)
  (handempty right)
  (shaker-empty-level shaker1 l0)
  (shaker-level shaker1 l0)
  (next l0 l1)
  (next l1 l2)
  (cocktail-part1 cocktail1 ingredient1)
  (cocktail-part2 cocktail1 ingredient2)
  (cocktail-part1 cocktail2 ingredient1)
  (cocktail-part2 cocktail2 ingredient3)
  (cocktail-part1 cocktail3 ingredient1)
  (cocktail-part2 cocktail3 ingredient2)
  (cocktail-part1 cocktail4 ingredient1)
  (cocktail-part2 cocktail4 ingredient3)
  (cocktail-part1 cocktail5 ingredient3)
  (cocktail-part2 cocktail5 ingredient2)
  (cocktail-part1 cocktail6 ingredient2)
  (cocktail-part2 cocktail6 ingredient3)
)
(:goal   (and (contains_shot_cocktail shot1 cocktail5)
  (contains_shot_cocktail shot2 cocktail6)
  (contains_shot_cocktail shot3 cocktail4)
  (contains_shot_cocktail shot4 cocktail1)
  (contains_shot_cocktail shot5 cocktail3)
  (contains_shot_cocktail shot6 cocktail2)
  (contains_shot_ingredient shot7 ingredient3)))
)
