#! /bin/sh

if [ ! -f $PRIVKEY_PATH ]; then
        openssl genpkey -algorithm RSA -out $PRIVKEY_PATH > /dev/null 2>&1
        echo "Private key generated."
fi

if [ ! -f $CERT_PATH ]; then
        openssl req -new -x509 -key $PRIVKEY_PATH -out $CERT_PATH -days 365 \
            -subj "$CERT_DETAILS" > /dev/null 2>&1
        echo "TLS certificate generated."
fi

echo "Starting wordpress' NGINX webserver..."

nginx -g "daemon off;"
