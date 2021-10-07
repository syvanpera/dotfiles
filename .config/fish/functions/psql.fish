function psql --description 'alias psql podman exec -it -u postgres postgres psql'
  podman exec -it -u postgres postgres psql $argv; 
end
