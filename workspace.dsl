workspace "AI-Powered Application" "Веб-приложение с интеграцией Llama 3 через Ollama" {

    model {
        user = person "Пользователь" "Конечный пользователь веб-приложения"
        
        ollama = softwareSystem "Ollama (Llama 3)" "Локально развернутая LLM" {
            tags "External"
        }
        
        webApp = softwareSystem "AI Web Application" "Позволяет пользователям взаимодействовать с данными через AI" {
            tags "Internal"
            
            spa = container "Single-Page Application" "React / Vue / Angular" "Предоставляет пользовательский интерфейс, общается с бэкендом через API"
            backend = container "Spring Boot Application" "Java + Spring" "Обрабатывает бизнес-логику, оркестрирует запросы к БД и AI"
            postgres = container "PostgreSQL Database" "Relational DB" "Хранит пользователей, транзакционные данные и метаданны" {
                tags "Database"
            }
            vectorDb = container "Vector Database" "pgvector / Weaviate / Qdrant" "Хранит векторные эмбеддинги для семантического поиска" {
                tags "Database"
            }
        }
        
        // Связи между элементами
        user -> webApp "Использует" "HTTPS"
        webApp -> ollama "Отправляет промпты и получает ответы" "HTTP/REST"
        
        user -> spa "Открывает в браузере" "HTTPS"
        spa -> backend "Делает API вызовы" "JSON/HTTPS"
        backend -> postgres "Читает/пишет данные" "JDBC/SQL"
        backend -> vectorDb "Поиск по сходству, сохранение эмбеддингов" "gRPC/HTTP"
        backend -> ollama "Запросы к LLM (генерация, инференс)" "HTTP/REST"
        
        // Связь для RAG (Retrieval Augmented Generation)
        ollama -> vectorDb "Читает контекст для RAG" "HTTP"
    }

    views {
        systemContext webApp "SystemContext" "Контекстная диаграмма" {
            include *
            autoLayout
        }
        
        container webApp "Containers" "Диаграмма контейнеров" {
            include *
            autoLayout
        }
        
        styles {
            element "Person" {
                shape person
                background "#08427b"
                color "#ffffff"
            }
            element "SoftwareSystem" {
                background "#1168bd"
                color "#ffffff"
            }
            element "External" {
                background "#999999"
                color "#ffffff"
            }
            element "Container" {
                shape roundedBox
                background "#438dd5"
                color "#ffffff"
            }
            element "Database" {
                shape cylinder
                background "#f57c00"
                color "#ffffff"
            }
        }
    }
}
