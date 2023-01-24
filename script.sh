export NAME_BUCKET=root-fl-storage
export ARTIFACT_BUCKET=https://${NAME_BUCKET}.s3.eu-west-1.amazonaws.com/

if [ -z "${ARTIFACT_BUCKET}" ]; then
    echo "This deployment script needs an S3 bucket to store CloudFormation artifacts."
    echo "You can also set this by doing: export ARTIFACT_BUCKET=my-bucket-name"
    echo
    read -p "S3 bucket to store artifacts: " ARTIFACT_BUCKET
fi

# aws s3 cp .aws s3://${NAME_BUCKET}/cloudformation/ --recursive

MACRO_NAME=$(basename $(pwd))

aws cloudformation package \
    --template-file .aws/main.yaml \
    --s3-bucket ${NAME_BUCKET} \
    --s3-prefix cloudformation \
    --output-template-file packaged.yaml

aws cloudformation validate-template \
    --template-body file://packaged.yaml

aws cloudformation deploy \
    --stack-name ${MACRO_NAME} \
    --template-file packaged.yaml \
    --capabilities CAPABILITY_IAM \
