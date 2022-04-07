# Домашнее задание №6: Docker Compose

Евула Анджэй

## Запуск программы
- Запуск приложения: `docker-compose up`.
- Остановка приложения: `docker-compose down` (также удаляет контейнер).
- Установка образов: 
    ```bash
    docker pull shadowdedulet/hw4   # установка образа http-сервера
    docker-compose build            # установка образа сервиса
    ```
    
## Пример работы
При переходе по ссылке `http://localhost:3001/orders/check?cpu=4&ram=4&hdd_capacity=50&hdd_type=sata&os=linux` сервис возвращает ответ с кодом 200 в виде json-объекта:
```json
{
    "result": true,
    "total": 61924,
    "balance": 100000,
    "balance_after_transaction": 38076
}
``` 

## Результат
- Запускаются отдельные контейнеры для сервиса и сервера из [ДЗ4](http://git-intern.digitalleague.ru/shadowdedulet/hw4/).
- При переходе по [ссылке](http://localhost:3001/orders/check)(`http://localhost:3001/orders/check`) сервер возвращает данные по запрошенным параметрам ВМ.
