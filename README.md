# scaffold-fastapi
A Python FastAPI scaffold project

# Docker container management
## Create Docker image 
> docker build -t scaffold_img .
## Run Docker image
docker run -it -p 8000:8000 [--name scaffold] scaffold_img sh

# Running locally
## With uvicorn
> uvicorn rest_api.main:app --port 8000 --host 0.0.0.0 --app-dir src
## As Python script
> python src/app.py