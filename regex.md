## general
### remove jinja blocks
search `\{.*\}`

### remove empty lines
search `^\n`

### remove lines containing {word}
search `.*word.*\n`
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

### add dbt def blocks to list of columns
search `\n`
replace `\ndescription: '{{ doc("MARKDOWN") }}'\n- name: `

### grepping cloudwatch logs
*isolating failed models*
1. search: `.*start.*\n`
    replace: ``
1. search `.*ok.*\n`
    replace: ``
1. search `.*model `
    replace: ``
1. search `.*relation `
    replace: ``
1. search `\s\.*.*\]`
    replace: ``
1. **STOP HERE** if `schema_name.model_name` format is desired. Continue if isolating model names only is desired.
1. search `.*\.`
    replace: ``
1. search `\n`
    replace: ` ` (whitespace)
1. complete.

    
### case insensitive search
```python
import re
print (re.search('bush', 'BuSh', re.IGNORECASE))
print (re.match('bush', 'BuSh', re.IGNORECASE))
print (re.sub('bush', 'xxxx', 'buShels', flags=re.IGNORECASE))
```