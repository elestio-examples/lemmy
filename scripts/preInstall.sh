set env vars
set -o allexport; source .env; set +o allexport;


mkdir -p ./pictrs
chown -R 991:991 ./pictrs

sed -i "s~USER_TO_CHANGE~${ADMIN_EMAIL}~g" ./lemmy.hjson
sed -i "s~PASSWORD_TO_CHANGE~${ADMIN_PASSWORD}~g" ./lemmy.hjson
sed -i "s~DOMAIN_TO_CHANGE~${DOMAIN}~g" ./lemmy.hjson
sed -i "s~API_KEY_TO_CHANGE~${API_KEY}~g" ./lemmy.hjson
sed -i "s~POSTGRES_USER~${POSTGRES_USER}~g" ./lemmy.hjson
sed -i "s~POSTGRES_PASSWORD~${POSTGRES_PASSWORD}~g" ./lemmy.hjson
sed -i "s~SMTP_HOST~${SMTP_HOST}~g" ./lemmy.hjson
sed -i "s~SMTP_PORT~${SMTP_PORT}~g" ./lemmy.hjson
sed -i "s~SMTP_FROM~${SMTP_FROM_EMAIL}~g" ./lemmy.hjson
sed -i "s~SMTP_AUTH_STRATEGY~${SMTP_AUTH_STRATEGY}~g" ./lemmy.hjson