erDiagram
    CLIENTS {
        int client_id PK
        string client_name
        string client_phone
        string client_email
        string client_city
    }

    PROJECTS {
        varchar project_id PK
        string project_name
        string project_type
        date start_date
        date end_date
        string site_address
        string site_city
        string site_state
        int client_id FK
    }

    SUPERVISORS {
        int supervisor_id PK
        string supervisor_name
        string supervisor_phone
    }

    WORKERS {
        int worker_id PK
        string worker_name
        string worker_phone
        decimal hourly_rate
    }

    SKILLS {
        int skill_id PK
        string skill_name
    }

    CERTIFICATIONS {
        int cert_id PK
        string cert_name
    }

    WORKER_SKILLS {
        int worker_id FK
        int skill_id FK
    }

    WORKER_CERTIFICATIONS {
        int worker_id FK
        int cert_id FK
    }

    SUPPLIERS {
        int supplier_id PK
        string supplier_name
        string supplier_city
    }

    SUPPLIER_PHONES {
        int phone_id PK
        int supplier_id FK
        string phone_number
    }

    MATERIALS {
        int material_id PK
        string material_name
    }

    PROJECT_SUPPLIER_MATERIALS {
        varchar project_id FK
        int supplier_id FK
        int material_id FK
        decimal unit_cost
    }

    EQUIPMENT {
        int equipment_id PK
        string equipment_name
    }

    PROJECT_EQUIPMENT {
        varchar project_id FK
        int equipment_id FK
        decimal rental_cost
    }

    PROJECT_WORKERS {
        varchar project_id FK
        int worker_id FK
        int supervisor_id FK
    }

    %% Relationships
    CLIENTS ||--o{ PROJECTS : "has"
    PROJECTS ||--o{ PROJECT_WORKERS : "assigns"
    WORKERS ||--o{ PROJECT_WORKERS : "works on"
    SUPERVISORS ||--o{ PROJECT_WORKERS : "supervises"

    WORKERS ||--o{ WORKER_SKILLS : "has"
    SKILLS ||--o{ WORKER_SKILLS : "is assigned to"

    WORKERS ||--o{ WORKER_CERTIFICATIONS : "has"
    CERTIFICATIONS ||--o{ WORKER_CERTIFICATIONS : "is assigned to"

    SUPPLIERS ||--o{ SUPPLIER_PHONES : "has"
    SUPPLIERS ||--o{ PROJECT_SUPPLIER_MATERIALS : "provides"
    MATERIALS ||--o{ PROJECT_SUPPLIER_MATERIALS : "is used in"
    PROJECTS ||--o{ PROJECT_SUPPLIER_MATERIALS : "uses"

    PROJECTS ||--o{ PROJECT_EQUIPMENT : "uses"
    EQUIPMENT ||--o{ PROJECT_EQUIPMENT : "is used in"
