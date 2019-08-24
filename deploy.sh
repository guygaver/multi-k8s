docker build -t guygaver/fibonacci-client:latest -t guygaver/fibonacci-client:$SHA -f ./client/Dockerfile ./client
docker build -t guygaver/fibonacci-server:latest -t guygaver/fibonacci-server:$SHA -f ./server/Dockerfile ./server
docker build -t guygaver/fibonacci-worker:latest -t guygaver/fibonacci-worker:$SHA -f ./worker/Dockerfile ./worker

docker push guygaver/fibonacci-client:latest
docker push guygaver/fibonacci-client:$SHA
docker push guygaver/fibonacci-server:latest
docker push guygaver/fibonacci-server:$SHA
docker push guygaver/fibonacci-worker:latest
docker push guygaver/fibonacci-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/fibonacci-client-deployment fibonacci-client=guygaver/fibonacci-client:$SHA
kubectl set image deployments/fibonacci-server-deployment fibonacci-server=guygaver/fibonacci-server:$SHA
kubectl set image deployments/fibonacci-worker-deployment fibonacci-worker=guygaver/fibonacci-worker:$SHA