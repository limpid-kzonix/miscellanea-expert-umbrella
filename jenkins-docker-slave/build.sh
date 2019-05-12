#!/bin/bash

# delete orphan images
echo "Building images"
docker rmi -f `docker images | awk '{ print $3; }'`

# build 
echo "Building images"
for dockerfile in Dockerfile*
do
    echo "$dockerfile"
    dockertag=$( echo "$dockerfile" | cut -d '_' -f 2 )
    echo "$dockertag"
    if [ "$dockertag" =  "$dockerfile" ]
    then
        dockertag='arm-latest'
    fi
    echo "Building $dockerfile => tag=$dockertag"
    docker build -t jenkins/slave:$dockertag .
    docker build -t jenkins/agent:$dockertag .
done

echo "Build finished successfully"
