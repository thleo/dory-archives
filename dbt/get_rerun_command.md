# get_rerun_command_dbt.py

This Python script is used to parse logs from AWS CloudWatch and identify which dbt models need to be rerun.

It then outputs a script to be run in terminal.

## Overview

1. **Imports**: The script imports the necessary modules: `os` and `re`.

2. **Current Working Directory**: It retrieves the current working directory using `os.getcwd()`.

3. **Log File Path**: It specifies the location of the CloudWatch logs in `log_file_path`.

4. **Pasted Logs**: If logs are pasted from the console, they are stored in `paste_logs`.

5. **Separator**: It defines a separator string `sep`.

6. **Models to Rerun**: It initializes an empty list `models_to_rerun` to store the models that need to be rerun.

7. **Exclusion Words**: It creates a list of words `except_words` that are to be excluded from the logs.

8. **Exclusion Regex**: It creates a regex string `except_regex_string` from the `except_words` list.

9. **Production Run Command**: It defines a string `prod_run_var_string` that contains the command to run dbt in production environment.

10. **DBT Logs Start**: It sets a flag `dbt_logs_start` to False initially.

11. **CloudWatch Logs**: It opens the CloudWatch logs file and reads the first line.

12. **Pasted Logs Processing**: If `paste_logs` is not empty, it sets `dbt_logs_start` to True and splits the pasted logs into lines.
