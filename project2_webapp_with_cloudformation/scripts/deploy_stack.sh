aws cloudformation deploy \
   --stack-name $1 \
   --template-file $2 \
   --parameter-overrides $3 \
   --region us-east-1 

aws cloudformation create-change-set \
  --stack-name my-networking-stack \
  --template-body file://stack_templates/networking.yml \
  --parameters file://parameters/networking-parameters.json \
  --change-set-name my-change-set

aws cloudformation create-stack \
  --stack-name my-networking-stack \
  --template-body file://stack_templates/networking.yml \
  --parameters file://parameters/networking-parameters.json \
  --region us-east-1 \
  --profile udacity

aws cloudformation delete-stack \
  --stack-name my-networking-stack \
