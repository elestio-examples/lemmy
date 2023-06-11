set env vars
set -o allexport; source .env; set +o allexport;

apt install jq -y

mkdir -p ./pictrs
chown -R 991:991 ./pictrs

sed -i "s~USER_TO_CHANGE~${ADMIN_EMAIL}~g" ./lemmy.hjson
sed -i "s~PASSWORD_TO_CHANGE~${ADMIN_PASSWORD}~g" ./lemmy.hjson
sed -i "s~DOMAIN_TO_CHANGE~${DOMAIN}~g" ./lemmy.hjson
sed -i "s~API_KEY_TO_CHANGE~${API_KEY}~g" ./lemmy.hjson
sed -i "s~POSTGRES_USER_TO_CHANGE~${POSTGRES_USER}~g" ./lemmy.hjson
sed -i "s~POSTGRES_PASSWORD_TO_CHANGE~${POSTGRES_PASSWORD}~g" ./lemmy.hjson