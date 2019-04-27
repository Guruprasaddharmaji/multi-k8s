docker build -t dgp6182/multi-client:latest -t dgp6182/multi-client:$SHA -f ./client/Dcokerfile ./client
docker build -t dgp6182/multi-server:latest -t dgp6182/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dgp6182/multi-worker:latest -t dgp6182/multi-worker:$SHA -f ./worker/Dcokerfile ./worker
docker push dgp6182/multi-client:latest
docker push dgp6182/multi-server:latest
docker push dgp6182/multi-worker:latest

docker push dgp6182/multi-client:$SHA
docker push dgp6182/multi-server:$SHA
docker push dgp6182/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=dgp6182/multi-server:$SHA
kubectl set image deployments/client-deployment client:dgp6172/multi-client:$SHA
kubectl set image deployments/worker-deployment worker:dgp6182/multi-client:$SHA
