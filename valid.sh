aws cloudformation validate-template \
    --template-body file://.aws/main.yaml

aws cloudformation validate-template \
    --template-body file://.aws/app.yaml

aws cloudformation validate-template \
    --template-body file://.aws/database.yaml

aws cloudformation validate-template \
    --template-body file://.aws/storage.yaml