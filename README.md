# ruby-mastermind
Ruby project for The Odin Project

## rules
* Computer (randomly) choose a 4 digit code with different colors
* Color: (r)ed, (b)lue, (g)reen, (y)ellow, (o)range, (p)urple
* Another player has 12 chance to guess correct code
* During each guess, the guess will be checked with the secret code and display the matching result.
  If both color and position matched, it will show "◉" as "exact match".
  If only color matched, it will show "◯" as "correct color".
* If the guessing player got the secret code within 12 chances, the player wins.
* If the guessing player didn't get the secret code within 12 chances, the computer wins.