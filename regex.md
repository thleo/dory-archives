## dbt
### inserting function macros for multiple columns
LHS search & replacement:
search `,\n\s{4}` (if there are spaces)
replace `,\n{{macroName('`

RHS search & replacement:
search `,\n`
replace `') }} as  colName,\n`
### select blocks of (compiled) case logic
`CASE(.+\n){7}.+`