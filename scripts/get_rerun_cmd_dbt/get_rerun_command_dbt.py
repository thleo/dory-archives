import os
import re
os.getcwd()

# location of cloudwatch logs
log_file_path = 'console_logs.txt'

# if pasting logs from console
paste_logs = """"""

sep='------------------------------------------'

models_to_rerun=[]
except_regex_string=''
except_words = ['logging','packages','github','build','user','install','pip','START','OK', 'cloud', '\.sql', 'yml', 'warn' , 'dataset', 'seeds']
except_regex_string = '|'.join(except_words)
prod_run_var_string = 'ENVIRONMENT=production AWS_PROFILE=production dbt run -m '
# Change this variable if your logs include the start of your dbt run
dbt_logs_start = True

CWLogs = open(log_file_path, 'r')
CW_lines = CWLogs.readline()
if paste_logs:
    dbt_logs_start = True
# print(CW_lines)
    for line in paste_logs.splitlines():
        CW_lines = line
        if re.search('Running with dbt',CW_lines):
            dbt_logs_start=True
        elif re.search('on-run-end hooks',CW_lines):
            dbt_logs_start=False
        if dbt_logs_start:
            model_name_re = re.search('[a-z\_]+\.{1}[a-z\_\d]+',CW_lines)
            if model_name_re:
                if not (re.search(except_regex_string,line)):
                    model_name = model_name_re.group()
                    print(line)
                    models_to_rerun.append(model_name)
else:
    while CW_lines:
        CW_lines = CWLogs.readline()
        if re.search('Running with dbt',CW_lines):
            dbt_logs_start=True
        elif re.search('on-run-end hooks',CW_lines): # <<< this prevents the script from returning an output if the logs are pasted past the start of the dbt commands
            dbt_logs_start=False
        if dbt_logs_start: # << need to fix this logic to work also when there isn't hte start line in the logs
            model_name_re = re.search('[a-z\_]+\.{1}[a-z\_\d]+',CW_lines) 
            if model_name_re:
                # TODO: fix regex to exclude models with numbers in names
                if not (re.search(except_regex_string,CW_lines)):
                    model_name = model_name_re.group()
                    models_to_rerun.append(model_name)
                    # uncomment to test outputs
                # else:
                    print(model_name_re.group())
                    print(CW_lines)

CWLogs.close()  

# get model names without schemas
models_to_rerun_shortnames = []
models_failed=0
for x in models_to_rerun:
    models_failed+=1
    shortname = re.search('\.(.*)',x).group(1)
    models_to_rerun_shortnames.append(shortname)

model_names_string = ' '.join(models_to_rerun_shortnames)

shell_command_to_rerun = prod_run_var_string + model_names_string
print(sep)
print('models to rerun: ' + str(models_failed))
print(sep)
print("RUN THE FOLLOWING COMMAND\n don't forget to log in to staging")
print(sep)
print(shell_command_to_rerun)
print(sep)



