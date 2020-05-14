# Defined in - @ line 1
function mysql-start --description 'alias mysql-start docker run --rm --name mysql-docker -e MYSQL_ROOT_PASSWORD=mysql -d -p 3306:3306 -v /home/tuomo/docker/volumes/mysql:/var/lib/mysql mysql'
	docker run --rm --name mysql-docker -e MYSQL_ROOT_PASSWORD=mysql -d -p 3306:3306 -v /home/tuomo/docker/volumes/mysql:/var/lib/mysql mysql $argv;
end
