# Giphy
iOS app

# Описание
Приложение для поиска гифок на ресурсе giphy. Работает в портретном и горизонтальном режиме. Проверки на кол-во вводимых символов для поиска нет. Поиск проивзодится только после тапа на "Search".

**SearchGifsViewController** отвечает за отображение колекции гифок, отправку запроса на поиск картинок используя **Communicator**. 
Класс **Communicator** содержит в себе запросы которые будут отправляться на сервер. После составления запроса он вызывает **Requester** в котором содержится логика работы с сервером при помощи фреймворка Alamofire. Если всё ок в **Communicator** воззращяется ответ с данными. 

При написании приложения были использованы фреймворки:
1. Alamofire - для нетворкинга
2. ObjectMapper - для парсинга данных полученных от giphy.com

Проект написан в среде разработки Xcode (10.2). 

Чтобы запустить проект нужно 
1. Открыть "Giphy.xcworkspace"
2. В правом верхнем углу нажать "RUN"

**Из .gitignore было убрано игонрирование предустановленых "подов". Дополнительные танцы с Terminal для запуска не требуются.**
