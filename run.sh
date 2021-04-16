git reset --hard
git clean -d -f
git pull

# shellcheck disable=SC2164
cd crm

flutter build web --no-sound-null-safety --web-renderer canvaskit

cd /root/ZakazioApi

chmod a+x ./gradlew

./gradlew clean

./gradlew bootWar

docker-compose build

docker-compose up -d