docker build -t bobbyvann/multi-client:latest -t bobbyvann/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bobbyvann/multi-server:latest -t bobbyvann/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bobbyvann/multi-worker:latest -t bobbyvann/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bobbyvann/multi-client:latest
docker push bobbyvann/multi-server:latest
docker push bobbyvann/multi-worker:latest
docker push bobbyvann/multi-client:$SHA
docker push bobbyvann/multi-server:$SHA
docker push bobbyvann/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bobbyvann/multi-server:$SHA
kubectl set image deployments/client-deployment client=bobbyvann/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bobbyvann/multi-worker:$SHA