workspace "Пример" "Демонстрация генерации диаграммы" {

    model {
        u = person "Пользователь" "Обычный пользователь системы"
        
        ss = softwareSystem "Программная система" "Наша основная система" {
            wa = container "Веб-приложение" "Обеспечивает интерфейс для пользователей" "React + Node.js"
            db = container "База данных" "Хранит все данные системы" "PostgreSQL" {
                tags "Database"
            }
        }
        
        u -> ss "Использует систему"
        u -> ss.wa "Взаимодействует через браузер"
        ss.wa -> ss.db "Читает и записывает данные"
        ss.db -> ss.wa "Возвращает результаты"
    }

    views {
        systemContext ss "SystemContext" {
            include *
            autolayout lr
        }

        container ss "ContainerDiagram" {
            include *
            autolayout lr
        }

        styles {
            element "Person" {
                shape Person
                background #08427b
                color #ffffff
            }
            element "SoftwareSystem" {
                background #1168bd
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Database" {
                shape Cylinder
                background #000000
                color #ffffff
            }
        }
    }
}
