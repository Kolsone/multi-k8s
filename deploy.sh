docker build -t kolsone/multi-client:latest -t kolsone/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kolsone/multi-server:latest -t kolsone/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kolsone/multi-worker:latest -t kolsone/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kolsone/multi-client:latest
docker push kolsone/multi-server:latest
docker push kolsone/multi-worker:latest

docker push kolsone/multi-client:$SHA
docker push kolsone/multi-server:$SHA
docker push kolsone/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kolsone/multi-server:$SHA
kubectl set image deployments/client-deployment client=kolsone/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kolsone/multi-worker:$SHA
