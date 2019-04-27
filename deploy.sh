docker build -t dgp6182/multi-client:latest -t dgp6182/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dgp6182/multi-server:latest -t dgp6182/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dgp6182/multi-worker:latest -t dgp6182/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dgp6182/multi-client:latest
docker push dgp6182/multi-server:latest
docker push dgp6182/multi-worker:latest

docker push dgp6182/multi-client:$SHA
docker push dgp6182/multi-server:$SHA
docker push dgp6182/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=stephengrider/multi-server
kubectl set image deployments/client-deployment client=stephengrider/multi-client
kubectl set image deployments/worker-deployment worker=stephengrider/multi-client
