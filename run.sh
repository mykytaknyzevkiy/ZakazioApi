git reset --hard
git clean -d -f
git pull

chmod a+x ./gradlew

./gradlew clean

./gradlew bootWar

docker-compose build

docker-compose up -d