# certs-generation-script

## After executing this script you will have following certificates created.

### - Server Cert
### - Intermediate Cert
### - Root Cert.

1.. In order to run this script execute below

```bash
chmod +x certs-generator.sh
./certs-generator.sh
```
2. It will ask for below details - First you have to provide the details of Root CA. You can provide these details in one go by typing `/C=US/ST=State/L=City/O=Organization/OU=CA/CN=my-root-ca`

Then provide the Intermediate CA details - [/C=US/ST=State/L=City/O=Organization/OU=CA/CN=my-intermediate-ca]
Then Server details - [/C=US/ST=State/L=City/O=Organization/OU=Apps/CN=*.apps.example.com]
Then Alt DNS name - DNS:*.apps.example.com,DNS:console.example.com
```bash
./certs.sh
Enter subject for Root CA [/C=US/ST=State/L=City/O=Organization/OU=CA/CN=my-root-ca]: /C=US/ST=State/L=City/O=Organization/OU=CA/CN=my-root-ca
Enter subject for Intermediate CA [/C=US/ST=State/L=City/O=Organization/OU=CA/CN=my-intermediate-ca]: /C=US/ST=State/L=City/O=Organization/OU=CA/CN=my-intermediate-ca
Enter subject for Server Certificate [/C=US/ST=State/L=City/O=Organization/OU=Apps/CN=*.apps.example.com]: /C=US/ST=State/L=City/O=Organization/OU=Apps/CN=*.apps.example.com
Enter comma-separated Subject Alternative Names (e.g., DNS:*.apps.example.com,DNS:console.example.com): DNS:*.apps.example.com,DNS:console.example.com
Generating RSA private key, 4096 bit long modulus
...................++++
.............................................................................................................................................................++++
e is 65537 (0x10001)
Generating RSA private key, 4096 bit long modulus
.......................++++
....................................++++
e is 65537 (0x10001)
Signature ok
subject=/C=US/ST=State/L=City/O=Organization/OU=CA/CN=my-intermediate-ca
Getting CA Private Key
Generating RSA private key, 4096 bit long modulus
....................................................................................++++
......................................................++++
e is 65537 (0x10001)
Signature ok
subject=/C=US/ST=State/L=City/O=Organization/OU=Apps/CN=*.apps.example.com
Getting CA Private Key

✅ Certificate generation completed. Files are in ./certs and ./private
```

3. Following private key, csr, crt files will be created by this script.
```bash
ll certs private csr 
certs:
-rw-r--r--  1 karan  staff   2.1K 27 Jun 10:56 intermediate.crt
-rw-r--r--  1 karan  staff    17B 27 Jun 10:56 intermediate.srl
-rw-r--r--  1 karan  staff   1.8K 27 Jun 10:56 root.crt
-rw-r--r--  1 karan  staff    17B 27 Jun 10:56 root.srl
-rw-r--r--  1 karan  staff   2.0K 27 Jun 10:56 server.crt

csr:
-rw-r--r--  1 karan  staff   1.7K 27 Jun 10:56 intermediate.csr
-rw-r--r--  1 karan  staff   1.7K 27 Jun 10:56 server.csr

private:
-rw-r--r--  1 karan  staff   3.2K 27 Jun 10:56 intermediate.key
-rw-r--r--  1 karan  staff   3.2K 27 Jun 10:56 root.key
-rw-r--r--  1 karan  staff   3.2K 27 Jun 10:56 server.key
```
4. Now you can use these files as per your requirement.
