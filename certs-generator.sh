#!/bin/bash
set -e

mkdir -p certs private csr

read -p "Enter subject for Root CA [/C=US/ST=State/L=City/O=Organization/OU=CA/CN=my-root-ca]: " ROOT_SUBJECT
ROOT_SUBJECT=${ROOT_SUBJECT:-/C=US/ST=State/L=City/O=Organization/OU=CA/CN=my-root-ca}

read -p "Enter subject for Intermediate CA [/C=US/ST=State/L=City/O=Organization/OU=CA/CN=my-intermediate-ca]: " INT_SUBJECT
INT_SUBJECT=${INT_SUBJECT:-/C=US/ST=State/L=City/O=Organization/OU=CA/CN=my-intermediate-ca}

read -p "Enter subject for Server Certificate [/C=US/ST=State/L=City/O=Organization/OU=Apps/CN=*.apps.example.com]: " SERVER_SUBJECT
SERVER_SUBJECT=${SERVER_SUBJECT:-/C=US/ST=State/L=City/O=Organization/OU=Apps/CN=*.apps.example.com}

read -p "Enter comma-separated Subject Alternative Names (e.g., DNS:*.apps.example.com,DNS:console.example.com): " ALT_NAMES

# Create Root CA
openssl genrsa -out private/root.key 4096
openssl req -x509 -new -nodes -key private/root.key -sha256 -days 3650 \
    -out certs/root.crt -subj "$ROOT_SUBJECT"

# Create Intermediate CA CSR
openssl genrsa -out private/intermediate.key 4096
openssl req -new -key private/intermediate.key -out csr/intermediate.csr -subj "$INT_SUBJECT"

# Sign Intermediate CA with Root CA
cat > extfile.cnf <<EOF
basicConstraints=CA:TRUE,pathlen:0
keyUsage=critical,keyCertSign,cRLSign
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid,issuer
EOF

openssl x509 -req -in csr/intermediate.csr -CA certs/root.crt -CAkey private/root.key -CAcreateserial \
    -out certs/intermediate.crt -days 1825 -sha256 -extfile extfile.cnf

# Create Server CSR
openssl genrsa -out private/server.key 4096
openssl req -new -key private/server.key -out csr/server.csr -subj "$SERVER_SUBJECT"

cat > san.cnf <<EOF
subjectAltName=$ALT_NAMES
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
EOF

# Sign Server Cert with Intermediate CA
openssl x509 -req -in csr/server.csr -CA certs/intermediate.crt -CAkey private/intermediate.key -CAcreateserial \
    -out certs/server.crt -days 825 -sha256 -extfile san.cnf

echo -e "\n✅ Certificate generation completed. Files are in ./certs and ./private"
