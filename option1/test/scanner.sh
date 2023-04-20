# !bin/bash
export SERVER_URL=104.196.181.196:30542
export PASSWORD="secret"
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "login=admin&password=$PASSWORD&previousPassword=admin" -u admin:admin $SERVER_URL/api/users/change_password
export SONAR_LOGIN=$(curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "name=admin" -u admin:$PASSWORD $SERVER_URL/api/user_tokens/generate)
echo $SONAR_LOGIN
SONAR_LOGIN=$(python3 get_token.py $SONAR_LOGIN)
sonar-scanner -X -Dsonar.projectKey=project -Dsonar.sources=./prj/ -Dsonar.host.url=http://$SERVER_URL -Dsonar.login=$SONAR_LOGIN
