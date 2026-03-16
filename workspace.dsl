workspace "Пример" "Демонстрация генерации диаграммы" {

    model {
        u = person "Пользователь"
        
        ss = softwareSystem "Программная система" {
            wa = container "Веб-приложение"
            db = container "База данных" {
                tags "Database"
            }
            
            u -> ss "Использует"
            u -> wa "Использует"
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
