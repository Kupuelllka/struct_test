workspace "Пример" "Демонстрация генерации диаграммы" {

    model {
        u = person "Пользователь"
        
        ss = softwareSystem "Программная система" {
            // Сначала определяем все контейнеры
            wa = container "Веб-приложение"
            db = container "База данных" {
                tags "Database"
            }
            
            // А потом описываем связи (уже внутри системы)
            u -> ss "Использует"
            u -> wa "Использует"          // Убрали ss. - теперь просто wa
            wa -> db "Читает и пишет"
        }
    }

    views {
        systemContext ss "Контекст" {
            include *
            autolayout lr
        }

        container ss "Контейнеры" {
            include *
            autolayout lr
        }

        styles {
            element "Database" {
                shape Cylinder
            }
        }
    }

}
