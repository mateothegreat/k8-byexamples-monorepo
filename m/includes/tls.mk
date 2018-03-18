
# openssl dhparam -out dhparam.pem 4096
#
# HOST=support.azure.appsoa.io
# HOST=frontend.azure.appsoa.io
# CERT_NAME=tls-$HOST
# CERT_FILE=tls-$HOST.crt
# KEY_FILE=tls-$HOST.key
# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(KEY_FILE) -out $(CERT_FILE) -subj "/CN=$(HOST)/O=$(HOST)"
#
# kubectl create secret tls ${CERT_NAME} --key $(KEY_FILE) --cert $(CERT_FILE)


CERT_NAME=tls-$(HOST)
CERT_FILE=tls-$(HOST).crt
KEY_FILE = ${HOST}.key

tls: tls/generate tls/create_secret

tls/generate:

	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(KEY_FILE) -out $(CERT_FILE) -subj "/CN=$(HOST)/O=$(HOST)"

tls/delete_secret:

	kubectl delete --ignore-not-found secret $(CERT_NAME)

tls/create_secret: tls_delete_secret

	kubectl create secret tls $(CERT_NAME) --key $(KEY_FILE) --cert $(CERT_FILE)