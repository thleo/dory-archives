# cleaning
get the last value after a given delimiter in a string
*example: for a string formatted as `this.string.period.last`*
```
=TRIM(RIGHT(SUBSTITUTE(A2, ".", REPT(" ", LEN(A2))), LEN(A2)))
```