import os
import re
os.getcwd()

# location of cloudwatch logs
log_file_path = '/Users/dleong/Downloads/log-events-viewer-result.csv'

# if pasting logs from console
paste_logs = """"""

sep='------------------------------------------'

models_to_rerun=[]
except_regex_string=''
except_words = ['logging','packages','github','build','user','install','pip','START','OK']
except_regex_string = '|'.join(except_words)
prod_run_var_string = 'ENVIRONMENT=production AWS_PROFILE=production dbt run -m '
dbt_logs_start = False

CWLogs = open(log_file_path, 'r')
CW_lines = CWLogs.readline()
def process_lines(lines, dbt_logs_start=False):
    models_to_rerun = []
    for line in lines:
        if 'Running with dbt' in line:
            dbt_logs_start = True
        elif 'on-run-end hooks' in line:
            dbt_logs_start = False

        if dbt_logs_start:
            model_name_re = re.search('[a-z\_]+\.{1}[a-z\_\d]+', line)
            if model_name_re and not re.search(except_regex_string, line):
                model_name = model_name_re.group()
                models_to_rerun.append(model_name)
    return models_to_rerun

if paste_logs:
    lines = paste_logs.splitlines()
    models_to_rerun = process_lines(lines, dbt_logs_start=True)
else:
    with open(log_file_path, 'r') as CWLogs:
        lines = CWLogs.readlines()
        models_to_rerun = process_lines(lines)

# No need to close the file if you're using 'with' statement

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



