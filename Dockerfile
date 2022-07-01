

Why use docker : there are 3 reason : op sys , node/python/ruby version with teams /  pc :node-v-12 & project need nopde-v-14 ...
workflow: NODE/PYTHON .. ==>> write dockerfile ==>> build an image ==>> run as container 

# dockerfile exemple : 
FROM node:alpine  
 
WORKDIR /usr/app

COPY . . 

RUN npm install

CMD ["npm","run","serve"]



docker build . or docker build -f expressapp or docker build -f expressapp:2(v-2)
/// remove image 
docker image rm expressapp:2 


dockerfile best practice :

FROM node:alpine

WORKDIR   /usr/app

COPY package.json .

RUN npm install

COPY . . 

CMD ["npm","run","start"]


docker ps used to : show all the containers running on an isolated env 


best practice : excute the command to run a container detached  on a terminal  so : 

docker run -d expressapp express // express is the name of container

why -d :run container in background & print container id

documentation : https://docs.docker.com/engine/reference/commandline/run/
 to stop the container : docker stop || docker kill 

diff between docker stop (id) & docker kill id: 
  
  -docker stop ==> cleanUpPrecess=>stop the container
  
  -docker kill ==> kill the container 
  
  
  NB ::: if container port : 3333 it's totally different of localhost:3000 of our machine , container is 100% isolated from our computer 
  
  ==>> we need port mapping from browser to machine to container 
  
  
  docker run -d --name -express-container -p 3333:3333 express-app
  
  
  now we can see ...
  
  
  -------------VOLUMES-------------

  -v path:/usr/app

  or 
  
  -v $(pwd):/usr/app
  
  
  -v /usr/app/node_module : leave the /user/app/node_modules alone , don't touch it
  
  volumes : synch , realtime change app/container 
  
  
  --------DockerComppose--------
  
  
  
  imagine having server / client so we need 2 images ..
  
  create docker-compose.yaml in the path of server/client 
  
  
  version : "3.8"
  
  services : 
    nba-client:
      build:
        context : ./client 
        dockerfile : Dockerfile || Dockerfile.dev
      container_name : client-dc
      ports: 
        -3000:3000 // this is an array
      volumes : 
        -'./client:/usr/app'
        -'/usr/app/node_modules'
      environment :
        -CHOKIRDAR_USEPOLLING=TRUE  // only for react app
    
    nba-server:
      build:
        context : ./server 
        dockerfile : Dockerfile || Dockerfile.dev
      container_name : client-dc
      ports: 
        -5000:5000 // this is an array
      volumes : 
        -'./server:/usr/app'
        -'/usr/app/node_modules'
      environment :
        -CHOKIRDAR_USEPOLLING=TRUE  // only for react app



  commant : docker compose up 
  
           docker compose down 

