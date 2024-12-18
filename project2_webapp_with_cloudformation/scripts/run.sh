#!/bin/bash

show_help() {
    echo "Automation script for CloudFormation templates." 
    echo
    echo "Parameters"
    echo "  \$1: Execution mode. Valid values: deploy, delete, preview."
    echo "  \$2: Target region."
    echo "  \$3: Name of CloudFormation stack."
    echo "  \$4: Name of template file."
    echo "  \$5: Name of parameters file."
    echo
    echo "Usage examples:"
    echo "  ./run.sh create-stack us-east-1 udacity-scripts-exercise exercise.yml exercise-yml.json"
    echo "  ./run.sh deploy us-east-1 udacity-scripts-exercise exercise.yml exercise-yml.json"
    echo "  ./run.sh preview us-east-1 udacity-scripts-exercise exercise.yml exercise-yml.json"
    echo "  ./run.sh delete us-east-1 udacity-scripts-exercise"
    echo
}

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 1
fi

# Validate parameters
if [[ "$1" != "deploy" && "$1" != "delete" && "$1" != "preview" && "$1" != "create-stack" ]]; then
    echo "ERROR: Incorrect execution mode. Valid values: deploy, delete, preview, create-stack." >&2
    show_help
    exit 1
fi

EXECUTION_MODE="$1"
REGION="$2"
STACK_NAME="$3"
TEMPLATE_FILE_NAME="$4"
PARAMETERS_FILE_NAME="$5"

if [[ "$EXECUTION_MODE" == "create-stack" ]]; then
    aws cloudformation create-stack \
        --stack-name "$STACK_NAME" \
        --template-body file://"$TEMPLATE_FILE_NAME" \
        --parameters file://"$PARAMETERS_FILE_NAME" \
        --region "$REGION" \
        --capabilities CAPABILITY_IAM \
        --profile udacity
fi

if [[ "$EXECUTION_MODE" == "deploy" ]]; then
    aws cloudformation deploy \
        --stack-name "$STACK_NAME" \
        --template-file file://"$TEMPLATE_FILE_NAME" \
        --parameters file://"$PARAMETERS_FILE_NAME" \
        --region "$REGION" \
        --capabilities CAPABILITY_IAM \
        --profile udacity
fi

if [[ "$EXECUTION_MODE" == "preview" ]]; then
    aws cloudformation deploy \
        --stack-name "$STACK_NAME" \
        --template-file "$TEMPLATE_FILE_NAME" \
        --parameter-overrides file://"$PARAMETERS_FILE_NAME" \
        --no-execute-changeset \
        --region "$REGION" \
        --profile udacity
fi

if [[ "$EXECUTION_MODE" == "delete" ]]; then
    aws cloudformation delete-stack \
        --stack-name "$STACK_NAME" \
        --region "$REGION" \
        --profile udacity
fi
