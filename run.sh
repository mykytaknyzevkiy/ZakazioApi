git reset --hard
git clean -d -f
git pull

# shellcheck disable=SC2164
cd crm

~/development/flutter/bin/flutter build web --no-sound-null-safety --web-renderer canvaskit

cd /root/ZakazioApi

chmod a+x ./gradlew

./gradlew clean

./gradlew bootWar

docker-compose build

docker-compose up -d