# Task 1
* Docker and Docker Compose are set up
# Task 2
* Commands for containers / images:
    1. docker pull postgres
    2. docker pull grafana/grafana
    3. docker run -d --name mypostgres -e POSTGRES_PASSWORD=mysecretpassword -p 8080:8080 -v postgres-data:/usr/share/postgres/html --restart unless-stopped --memory="512m" --cpus="1.0" postgres
    4. docker run -d --name mygrafana -p 3000:3000 -v grafana-data:/usr/share/grafana/html --restart unless-stopped --memory="1g" --cpus="2.0" grafana/grafana
    5. docker restart mypostgres
    6. docker restart mygrafana
    7. docker stop mypostgres mygrafana
    8. docker rm mypostgres mygrafana
# Task 3
docker-compose.yml attached
