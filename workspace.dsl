workspace "Пример" "Демонстрация генерации диаграммы C4 model" {

    model {
        // 1. Сначала определяем всех людей
        u = person "Пользователь" "Обычный пользователь системы"
        
        // 2. Потом определяем программную систему со всеми контейнерами
        ss = softwareSystem "Программная система" "Наша основная система" {
            
            // 3. Внутри системы определяем все контейнеры
            wa = container "Веб-приложение" 
                "Обеспечивает интерфейс для пользователей" 
                "React + Node.js"
            
            db = container "База данных" 
                "Хранит все данные системы" 
                "PostgreSQL" {
                tags "Database"
            }
        }
        
        // 4. После определения всех элементов описываем связи
        u -> ss "Использует систему в целом"
        u -> ss.wa "Взаимодействует через браузер"
        ss.wa -> ss.db "Читает и записывает данные"
        
        // Дополнительная связь для демонстрации
        ss.db -> ss.wa "Возвращает результаты запросов"
    }

    views {
        // Диаграмма контекста системы (уровень 1 C4)
        systemContext ss "SystemContext" {
            include *
            autolayout lr
            title "Система контекста - Программная система"
            description "Общий контекст взаимодействия пользователя с системой"
        }

        // Диаграмма контейнеров (уровень 2 C4)
        container ss "ContainerDiagram" {
            include *
            autolayout lr
            title "Контейнеры внутри Программной системы"
            description "Детализация внутренней структуры системы"
        }

        // Настройка стилей
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
                shape Rectangle
                background #438dd5
                color #ffffff
            }
            
            element "Database" {
                shape Cylinder
                background #000000
                color #ffffff
            }
            
            // Стили для связей
            relationship "Uses" {
                color #707070
                style Solid
                thickness 2
            }
        }
        
        // Тема для красивого отображения
        theme default
    }

    // Добавляем документацию (опционально)
    documentation {
        section "Обзор" {
            content "Эта программная система демонстрирует использование C4 model с Structurizr DSL"
        }
        
        section "Контейнеры" {
            content """
                ## Веб-приложение
                Обеспечивает пользовательский интерфейс и обрабатывает запросы.
                
                ## База данных
                Хранит все данные и обеспечивает их целостность.
            """
        }
    }
}
