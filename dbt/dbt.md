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

### Related guides
- [Taking Your dbt CI Pipeline to the Next Level][1]

[1]: https://www.datafold.com/blog/taking-your-dbt-ci-pipeline-to-the-next-level
