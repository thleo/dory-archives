# AWS
## Services
### AWS SSM
Fetch decrypted value for non-latest version of parameter store value.
```bash
awsprod ssm get-parameters --names /some/descriptive/name/password:1 --with-decryption
>>> aws ssm get-parameters --names /some/descriptive/name/password:1 --with-decryption --profile production
```
### Lambdas
invoke lambda with payload:
```bash
aws lambda invoke --function-name generic-lambda-function-name --payload $(echo '{"key1": "val1", "k2": "v2", "object_bucket": "additional-string-if-needed"}' | base64) --profile staging response.json
```
*payload dependent on what is specified in function*

### s3
recursive file search
```shell
aws s3 ls s3://galileo-vendor-uhc-production-ep91jknafo5194tn/to_galileo/ --recursive | grep -E 'GALILEO_2022|GALILEO_2023'
``````