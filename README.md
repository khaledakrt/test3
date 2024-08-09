Apres l'execussion de script : ./tomcat_deploy.sh

verifier L'image : docker images

run container : docker run id_image

get id container  : docker ps

get ip container : docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <id_conainter>

using web interface to verify : ipconatiner:8080
