docker build --platform=linux/amd64 --tag proj1 .
docker run -p 8888:8888 --rm proj1