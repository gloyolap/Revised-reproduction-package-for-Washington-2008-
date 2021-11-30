clear all
set more off
capture log close

*claim 1. Now Scores

cd "/Users/usuario/Desktop/T3"
use basic
gen srvlngsq=srvlng*srvlng
gen agesq=age*age
replace rtl = 100-rtl

*regression by the author for NOW scores
reg nowtot ngirls white female repub  age agesq srvlng srvlngsq reld1 reld3-reld5 chid2-chid11 regd* demvote if congress==105

*robust errors #i eliminate the if command because it is redundant and create a global for the variables that are used as fixed effects

global controls "white female repub  age agesq srvlng srvlngsq reld1 reld3-reld5 chid2-chid11 regd* demvote"
reg nowtot ngirls $controls
reg nowtot ngirls $controls ,r 

*estimate with cluster on children instead of dummies to see consistency with the main assumption
reg nowtot ngirls white female repub  age agesq srvlng srvlngsq reld1 reld3-reld5 regd*demvote, abs(totchi)

*regression without fixedeffects *to see the changes*
reg nowtot ngirls 

*regression dividing the sample according to age *i argue this is because the age you have can cause different views on certain issues
mean age 

*below average
preserve
keep if age<53
reg nowtot ngirls $controls if congress==105
reg nowtot ngirls $controls if congress==105, r 
restore

*above average
preserve
keep if age>53
reg nowtot ngirls $controls if congress==105
reg nowtot ngirls $controls if congress==105, r
restore

*claim 2. Aauw Scores

* by the author
*column 2 (table2), column1 (at3)
reg aauw ngirls white female repub  age agesq srvlng srvlngsq reld1 reld3-reld5 chid2-chid11 regd* demvote  if congress==105
*column 3 (table2), column3 (at3)
reg aauw ngirls white female repub  age agesq srvlng srvlngsq reld1 reld3-reld5 chid2-chid11 regd* demvote  if congress==106
*column 4 (table2), column5 (at3)
reg aauw ngirls white female repub  age agesq srvlng srvlngsq reld1 reld3-reld5 chid2-chid11 regd* demvote  if congress==107
*column 5 (table2), column7 (at3)
reg aauw ngirls white female repub  age agesq srvlng srvlngsq reld1 reld3-reld5 chid2-chid12 regd* demvote  if congress==108

*i estimate for the whole sample to compare with fixed effects by congress. I do this because it can show me how the results change while assuming that errors are correlated for the same congress, i argue this can be because of certain discussions they have and the issues they are facing. 

reg aauw ngirls $controls
reg aauw ngirls $controls, r

reg aauw ngirls $controls, abs(congress)
reg aauw ngirls $controls, r abs(congress)




