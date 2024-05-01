# Function: dbtdev_snowflake
# Description: Runs a dbt command for a specific model in the dev environment.
# Parameters:
#   - model_name: The name of the model to run.
# Usage: dbtdev_snowflake <model_name>
function dbtdev_snowflake() {
    model_name=$1
    command="ENVIRONMENT=production AWS_PROFILE=production dbt run -s $model_name --profile dev"
    echo "Running command: $command"
    ENVIRONMENT=production AWS_PROFILE=production dbt run -s $model_name --profile dev
}