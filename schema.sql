
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS clients (
    client_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    phone TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS employees (
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    role TEXT NOT NULL
        CHECK (role IN ('Администратор', 'Мастер'))
);

CREATE TABLE IF NOT EXISTS statuses (
    status_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS requests (
    request_id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id INTEGER NOT NULL,
    employee_id INTEGER,
    status_id INTEGER NOT NULL,
    device_type TEXT NOT NULL,
    device_model TEXT NOT NULL,
    problem_description TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (client_id)
        REFERENCES clients (client_id),

    FOREIGN KEY (employee_id)
        REFERENCES employees (employee_id),

    FOREIGN KEY (status_id)
        REFERENCES statuses (status_id)
);

INSERT OR IGNORE INTO clients
    (client_id, full_name, phone)
VALUES
    (1, 'Иванов Иван Иванович', '+79990000001'),
    (2, 'Петров Пётр Петрович', '+79990000002'),
    (3, 'Сидорова Анна Сергеевна', '+79990000003');

INSERT OR IGNORE INTO employees
    (employee_id, full_name, role)
VALUES
    (1, 'Смирнов Алексей', 'Администратор'),
    (2, 'Кузнецов Дмитрий', 'Мастер'),
    (3, 'Васильев Андрей', 'Мастер');

INSERT OR IGNORE INTO statuses (status_id, name)
VALUES
    (1, 'Новая'),
    (2, 'На диагностике'),
    (3, 'В работе'),
    (4, 'Ожидает запчасть'),
    (5, 'Готова'),
    (6, 'Выдана'),
    (7, 'Отказ');

INSERT OR IGNORE INTO requests (
    request_id,
    client_id,
    employee_id,
    status_id,
    device_type,
    device_model,
    problem_description
)
VALUES
    (1, 1, 2, 3, 'Ноутбук', 'Lenovo IdeaPad',
     'Не включается'),
    (2, 2, 3, 2, 'Смартфон', 'Samsung Galaxy',
     'Разбит экран'),
    (3, 3, NULL, 1, 'Компьютер', 'Сборный ПК',
     'Не запускается операционная система');
