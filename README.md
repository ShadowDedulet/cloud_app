# README


1. Перейдите в директорию со своими проектами
2. Склонируйте этот репозиторий: `git clone git@gitlab.w55.ru:internship/cloud_app.git` 
3. Перейдите в папку с новым проектом: `cd cloud_app`
4. Соберите предварительный образ: `docker build . -t cloud_app`
5. Запустите консоль внутри контейнера из собранного образа: `docker run --rm -it -v $(pwd):/usr/src -u $(id -u):$(id -g) cloud_app bash`
6. Запустите команду инициализации нового rails приложения: `rails new . --skip-javascript --skip-test --skip-bundle`
7. Пересоберите образ заново: `docker build . -t cloud_app`
