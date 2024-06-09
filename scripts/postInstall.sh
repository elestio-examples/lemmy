#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sed -i "s~DOMAIN_TO_CHANGE~${DOMAIN}~g" ./docker-compose.yml
docker-compose down;
docker-compose up -d;
sleep 45s;

