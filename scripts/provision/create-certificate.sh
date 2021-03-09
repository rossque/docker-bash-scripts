#!/bin/bash

DOMAIN=$1
SSL_DAYS=$2
SSL_DAYS_LEFT=$3
CURRENT_DATE=$4

if [ -z "$DOMAIN" ] || [ -z "$SSL_DAYS" ] || [ -z "$SSL_DAYS_LEFT" ] || [ -z "$CURRENT_DATE" ]
then
    printf "Missing script argument\n"$0" <domain>"
    exit 1
fi

# Check days until SSL certificate expires
SSL_EXPIRY_DATE=$(grep SSL_EXPIRY_DATE ~/.docker/certs/.SSL_timestamp | cut -d '=' -f2)
SSL_DAYS_DIFF=$(echo "($SSL_EXPIRY_DATE - $CURRENT_DATE) / 86400" | bc)

deleteCertificate(){
  printf "\nDeleting old certificate for $1\n"
  hashes=$(security find-certificate -c "$1" -a -Z|grep SHA-1|awk '{ print $NF }')
  for hash in $hashes; do
      sudo security delete-certificate -Z $hash
  done
  printf "...\e[92m done \e[39m\n"
}

# Create Self Signed Certificates (Issued by Certificate Authority)
if [[ ! -f ~/.docker/certs/$DOMAIN.crt ]] || [ "$SSL_DAYS_DIFF" -le $SSL_DAYS_LEFT ]
then

printf "\nCreating SSL certificates ...\n"

deleteCertificate $DOMAIN

SSL_EXPIRY_DATE=$(date -v+"$SSL_DAYS"d +%s)
echo "SSL_EXPIRY_DATE="$SSL_EXPIRY_DATE > ~/.docker/certs/.SSL_timestamp

openssl genrsa -out ~/.docker/certs/$DOMAIN.key 2048 && \
openssl req -new -subj "/C=US/ST=California/L=San Francisco Bay Area/O=$DOMAIN/OU=Developers/CN=$DOMAIN" -key ~/.docker/certs/$DOMAIN.key -out ~/.docker/certs/$DOMAIN.csr

cat > ~/.docker/certs/$DOMAIN.ext << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $DOMAIN
EOF

openssl x509 -req -in ~/.docker/certs/$DOMAIN.csr -CA ~/.docker/certs/ca.pem -CAkey ~/.docker/certs/ca.key -CAcreateserial \
-out ~/.docker/certs/$DOMAIN.crt -days $SSL_DAYS -sha256 -extfile ~/.docker/certs/$DOMAIN.ext && \
sudo security add-trusted-cert -d -r trustAsRoot -k /Library/Keychains/System.keychain ~/.docker/certs/$DOMAIN.crt

printf "...\e[92m done \e[39m\n"

fi

# End script
exit 0
