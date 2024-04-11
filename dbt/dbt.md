## redshift -> snowflake
### syntax
`is True` | `is False` -> `= True` | `= False`

### regex
```python
import re
print (re.search('bush', 'BuSh', re.IGNORECASE))
print (re.match('bush', 'BuSh', re.IGNORECASE))
print (re.sub('bush', 'xxxx', 'Bushmeat', flags=re.IGNORECASE))
```
regex for combing dbt logs
```python
[\d*:].*success.*\]
```

