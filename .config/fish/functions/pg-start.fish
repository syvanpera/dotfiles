# Defined in - @ line 1
function pg-start --description 'alias pg-start docker run --rm --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v $HOME/docker/postgresql/data:/var/lib/postgresql/data postgres'
	docker run --rm --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v $HOME/docker/postgresql/data:/var/lib/postgresql/data postgres $argv;
end
