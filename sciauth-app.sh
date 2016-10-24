ONETIME_TOKEN=$(vault token-create -policy="sciauth" -use-limit=8 -ttl="1m" -format="json" | jq -r .auth.client_token)

docker stop sciauth
docker rm sciauth

docker run --name sciauth -p 8001:8001 -e ONETIME_TOKEN=$ONETIME_TOKEN -e VAULT_ADDR=https://vault.aws.dbmi.hms.harvard.edu:443 -e VAULT_SKIP_VERIFY=1 -e VAULT_PATH=secret/dbmi/sciauth -i -t dbmi/sciauth-app 

#docker exec -i -t sciauth /bin/bash