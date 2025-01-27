## Bigquery
Recommended method: use ADC
1. Create credentials file by using command
```zsh
gcloud auth application-default login
```
_ensure that gcloud has been installed via brew_
2. Add the resulting file under ADC credential option in datagrip.

## Redshift
Use the postgres driver.