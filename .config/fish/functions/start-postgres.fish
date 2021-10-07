function start-postgres --wraps='podman run --rm --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v /home/tuomo/docker/volumes/postgres:/var/lib/postgresql/data docker.io/postgres' --description 'alias start-postgres podman run --rm --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v /home/tuomo/docker/volumes/postgres:/var/lib/postgresql/data docker.io/postgres'
  podman run --rm --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v /home/tuomo/docker/volumes/postgres:/var/lib/postgresql/data docker.io/postgres $argv; 
end
