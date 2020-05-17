# Defined in - @ line 1
function mssql-start --description alias\ mssql-start\ docker\ run\ --rm\ --name\ mssql-docker\ -e\ \'ACCEPT_EULA=Y\'\ -e\ \'SA_PASSWORD=F00barXyzzy\'\ -d\ -p\ 1433:1433\ -v\ /home/tuomo/docker/volumes/mssql:/var/opt/mssql\ mcr.microsoft.com/mssql/server:2017-latest
	docker run --rm --name mssql-docker -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=F00barXyzzy' -d -p 1433:1433 -v /home/tuomo/docker/volumes/mssql:/var/opt/mssql mcr.microsoft.com/mssql/server:2017-latest $argv;
end
