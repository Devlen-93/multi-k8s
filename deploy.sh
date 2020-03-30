docker build -t devlen93/multi-client:latest -t devlen93/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t devlen93/multi-server:latest -t devlen93/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t devlen93/multi-worker:latest -t devlen93/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push devlen93/multi-client:latest
docker push devlen93/multi-server:latest
docker push devlen93/multi-worker:latest

docker push devlen93/multi-client:$SHA
docker push devlen93/multi-server:$SHA
docker push devlen93/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=devlen93/multi-server:$SHA
kubectl set image deployments/client-deployment client=devlen93/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=devlen93/multi-worker:$SHA