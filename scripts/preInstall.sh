set env vars
set -o allexport; source .env; set +o allexport;


mkdir -p ./pictrs
chown -R 991:991 ./pictrs


cat /opt/elestio/startPostfix.sh > post.txt
filename="./post.txt"

SMTP_LOGIN=""
SMTP_PASSWORD=""

# Read the file line by line
while IFS= read -r line; do
  # Extract the values after the flags (-e)
  values=$(echo "$line" | grep -o '\-e [^ ]*' | sed 's/-e //')

  # Loop through each value and store in respective variables
  while IFS= read -r value; do
    if [[ $value == RELAYHOST_USERNAME=* ]]; then
      SMTP_LOGIN=${value#*=}
    elif [[ $value == RELAYHOST_PASSWORD=* ]]; then
      SMTP_PASSWORD=${value#*=}
    fi
  done <<< "$values"

done < "$filename"

sed -i "s~ADMIN_EMAIL~${ADMIN_EMAIL}~g" ./lemmy.hjson
sed -i "s~PASSWORD_TO_CHANGE~${ADMIN_PASSWORD}~g" ./lemmy.hjson
sed -i "s~DOMAIN_TO_CHANGE~${DOMAIN}~g" ./lemmy.hjson
sed -i "s~API_KEY_TO_CHANGE~${API_KEY}~g" ./lemmy.hjson
sed -i "s~POSTGRES_USER~${POSTGRES_USER}~g" ./lemmy.hjson
sed -i "s~POSTGRES_PASSWORD~${POSTGRES_PASSWORD}~g" ./lemmy.hjson
sed -i "s~SMTP_HOST~tuesday.mxrouting.net~g" ./lemmy.hjson
sed -i "s~SMTP_PORT~25~g" ./lemmy.hjson
sed -i "s~SMTP_LOGIN~${SMTP_LOGIN}~g" ./lemmy.hjson
sed -i "s~SMTP_PASSWORD~${SMTP_PASSWORD}~g" ./lemmy.hjson
sed -i "s~SMTP_FROM~${SMTP_LOGIN}~g" ./lemmy.hjson
sed -i "s~SMTP_AUTH_STRATEGY~starttls~g" ./lemmy.hjson

rm post.txt