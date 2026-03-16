workspace "Sim-Freezer" "Система заморозки абонентов" {
    !identifiers hierarchical

    model {

        // ========== Люди ==========
        WebUser = person "Пользователь веб-интерфейса" {
            description "Оператор, взаимодействующий с системой через веб"
            tags "client"
        }

        // ========== Система Sim-Freezer  ==========
        SimFreezer = softwaresystem "Sim-Freezer" {
            description "Микросервис для блокировки/разблокировки SIM-карт"
            tags "microservice"

            freezerService = container "Freezer Service" {
                description "Основная логика заморозки/разморозки"
                technology "Go"
                tags "service"
            }
        }

        // ========== Внешние системы  ==========
        WebApp = softwaresystem "Web Application" {
            description "Веб-интерфейс HRV (UI + Backend)"
            tags "frontend"
        }

        Pushsim = softwaresystem "Pushsim" {
            pushsimDB = container "Pushsim Database" {
                technology "MariaDB"
                tags "Database"
            }
        }

        BillingSystem = softwaresystem "Биллинг система Форвард" {
            description "Внешняя биллинговая система"
            tags "External"
        }

        Yate = softwaresystem "Yate" {
            description "Мобильное ядро (HLR/HSS, SMSC, шина)"
            tags "External"
        }

        // ========== Связи ==========
        WebUser -> WebApp "Использует браузер"
        WebApp -> SimFreezer.freezerService "API вызовы"
        SimFreezer.freezerService -> Yate "API вызовы"
        SimFreezer.freezerService -> BillingSystem "SQL (прямой доступ к БД Oracle)"
        SimFreezer.freezerService -> Pushsim.pushsimDB "SQL (прямой доступ к БД Mariadb)"
    }

    views {

        // ========== L1: System Context ==========
        systemContext SimFreezer {
            title "L1: Системный контекст Sim-Freezer"
            include *
            autoLayout lr
        }

        // ========== L2: Container Diagram ==========
        container SimFreezer {
            title "L2: Архитектура Sim-Freezer (контейнеры)"
            include SimFreezer
            include SimFreezer.freezerService
            include WebUser
            include WebApp
            include Pushsim
            include Pushsim.pushsimDB
            include BillingSystem
            include Yate
            autoLayout lr
        }
        
        #container Pushsim {
        #    title "L2: Архитектура Pushsim"
        #    include Pushsim
        #    include Pushsim.pushsimDB
        #    autoLayout lr
        #}
        
        styles {
            #element "Person" {
            #    background #199b66
            #    shape Person
            #}
            #element "Software System" {
            #    background #1eba79
            #}
            #element "External" {
            #    background #949494
            #}
            #element "Container" {
            #    background #23d98d
            #}
            #element "Database" {
            #    shape cylinder
            #    background #1053a7
            #}
            #element "service" {
            #    background #2a9d8f
            #}
            #element "frontend" {
            #    background #6a5acd
            #}
            #element "backend" {
            #    background #4b0082
            #}
            
             element "Element" {
                color #ffffff
            }
            element "Person" {
                background #199b66
                shape Person
            }
            element "Software System" {
                background #1eba79
            }

            element "External" {
                background #949494
            }
            
            element "CloudExt" {
                background #949494
                shape Ellipse
            }


            element "Container" {
                background #23d98d
            }

            element "Component" {
                background #50e3b7
            }
            element "Database" {
                shape cylinder
                background #1053a7
            }

            element "New" {
                background #f08920
            }
            
            element "Internal" {
                background #f4acac
            }
            
            
        }
    }
}
