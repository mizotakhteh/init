# Mizotakhteh

## Initiate the whole project

### 0. Git clone

Clone this repository on your local machine and then go to the `init` directory.

```sh
git clone git@gitlab.com:mizotakhteh/init.git
cd init
```

### 1. Execute `init.sh`

```sh
./init.sh
```

This command:

- Create a namespace on your Kubernetes called ***mizotakhteh***.
- Create a service account on the *mizotakhteh* namespace called ***github***.
- Binding a cluster admin role to *github* service account (limited access just to this namespace).
- Create a Certificate for ***api.mizotakhteh.ml*** and keep it into ***mizotakhteh-tls*** secret.
- Print encrypted and decrypted Github token.

> Use decrypted token to create a CI/CD variable named ***GH_SA_TOKEN*** in the [mizotakhteh actions secrets](https://github.com/organizations/mizotakhteh/settings/secrets/actions).

### 2. Create a client in the Keycloak

Create a Client in the [homesys realm](https://keycloak.homesys.tk/auth/admin/master/console/#/realms/homesys/clients) and name it ***mizotakhteh***.

### 3. Set ***HOMESYS_TOR_ADDRESS***

In the Gitlab group of the project, create a CI/CD variable named ***HOMESYS_TOR_ADDRESS*** and specify its value with `https://homegod7mg3ttkcvfm4332tooggxccieg5ocrfoujxzyudlk5hclx2qd.onion:6443`.

### 4. Set ***HOMESYS_CA_K8S***

In the Gitlab group of the project, create a CI/CD variable named ***HOMESYS_CA_K8S*** and specify its value with the output of the following command:

```sh
kubectl config view --minify --raw --output 'jsonpath={..cluster.certificate-authority-data}'
```

## Obtain an OAuth access token

Use `curl` to obtain an OAuth access token from Keycloak.

```sh
curl \
  -s \
  -X POST \
  -H 'Content-type: application/x-www-form-urlencoded' \
  -d 'client_id=mizotakhteh' \
  -d 'grant_type=password' \
  -d 'username=hasan' \
  -d 'password=passw0rd' \
  https://keycloak.homesys.tk/auth/realms/homesys/protocol/openid-connect/token \
  | jq -r '.access_token' | jq -R 'split(".") | .[0],.[1] | @base64d | fromjson'
```
