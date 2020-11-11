#!/bin/bash


changed_folder=$(git diff HEAD~ --name-only | uniq)
tag=$(git log -1 --format=%h) 


for folder in $changed_folder
 do
    dir=$(dirname "$folder")
    if [ "$dir" == 'api' ]; then
      echo "Change detected in api service"
      echo "Building rest api"
      docker build -t registry.digitalocean.com/ruchir-excercise/api:$tag -f api/Dockerfile api/.

      echo "Logging into docker registery"
      doctl registry login --expiry-seconds 600

      echo "Pushing container to docker registery"
      sudo docker push registry.digitalocean.com/ruchir-excercise/api:$tag
      
     
      sleep 10 

      echo "updating Chart Version in the Chart.yaml"
      sed -i 's/build-version/$tag/g' api/api-deploy/Chart.yaml

      echo "Configuring kubernetes access"
    
      doctl kubernetes cluster kubeconfig save testing-cluster
  
      echo "deploying the chart on version $tag"
 
      helm install api api/api-deploy/ -n api
      
      

    elif [ "$dir" == 'web' ]; then
      echo "Change detected in web service"
      echo "Building web UI"
      sudo docker build -t registry.digitalocean.com/ruchir-excercise/web:$tag -f web/Dockerfile web/.

    else
       echo "Change detected in $dir" 

    fi         
  
 done

