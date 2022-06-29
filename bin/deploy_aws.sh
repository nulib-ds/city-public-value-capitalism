#!/bin/bash

BUILD_DIR="site"
BUCKET_ID="city-public-value-and-capitalism.northwestern.pub"
DIST_ID="E3MDI919TWPVU3"
#PDF_FILE="city-public-value-and-capitalism"

echo "Deleting old publication"
rm -rf $BUILD_DIR
mkdir $BUILD_DIR

#echo "Generating PDF"
#quire pdf --file=$PDF_FILE

echo "Generating site"
quire site

echo "Uploading website files to AWS s3"
aws s3 sync \
    $BUILD_DIR \
    s3://$BUCKET_ID \
    --delete

echo "Clearing AWS CloudFront Cache"
aws cloudfront create-invalidation \
    --distribution-id $DIST_ID \
    --paths "/*"