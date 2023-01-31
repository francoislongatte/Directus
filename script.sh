get_param() {
    P=$(aws ssm get-parameter --name "$1" --with-decryption --query "Parameter.Value" --output text)
    echo "$P"
}

export NAME_BUCKET=root-fl-storage
export ARTIFACT_BUCKET=https://${NAME_BUCKET}.s3.eu-west-1.amazonaws.com/

MACRO_NAME=$(basename $(pwd))

echo 'CHECK PACKAGES WITH CLOUDFORMATION'
echo 'APP : '
aws cloudformation validate-template \
    --template-body file://.aws/app.yaml

echo 'DATABASE : '
aws cloudformation validate-template \
    --template-body file://.aws/database.yaml

echo 'STORAGE : '
aws cloudformation validate-template \
    --template-body file://.aws/storage.yaml

echo 'PACKAGE AND CHECK MAIN STACK  : '
aws cloudformation package \
    --template-file .aws/main.yaml \
    --s3-bucket ${NAME_BUCKET} \
    --s3-prefix cloudformation \
    --output-template-file packaged.yaml

aws cloudformation validate-template \
    --template-body file://packaged.yaml

echo 'DEPLOY WITH PARAM FROM SSM  : '

aws cloudformation deploy \
    --stack-name ${MACRO_NAME} \
    --template-file packaged.yaml \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
    --parameter-overrides \
            DirectusKey=$(get_param "DIRECTUS_KEY") \
            DirectusSecret=$(get_param "DIRECTUS_SECRET") \
            DirectusUsername=$(get_param "DIRECTUS_DATABASE_USERNAME") \
            DirectusPassword=$(get_param "DIRECTUS_DATABASE_PASSWORD") \
            DirectusClient=$(get_param "DIRECTUS_DATABASE_CLIENT") \
            AdminEmail=$(get_param "ADMIN_EMAIL") \
            AdminPassword=$(get_param "ADMIN_PASSWORD")  \
            DirectusDatabaseName=$(get_param "DIRECTUS_DATABASE_NAME") 
