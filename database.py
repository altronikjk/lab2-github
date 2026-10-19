
import sqlite3
from pathlib import Path


BASE_DIR = Path(__file__).resolve().parent
DB_PATH = BASE_DIR / "workshop.db"
SCHEMA_PATH = BASE_DIR / "schema.sql"


def get_connection():
    conn = sqlite3.connect(DB_PATH)
    conn.execute("PRAGMA foreign_keys = ON")
    return conn


def initialize_database():
    sql = SCHEMA_PATH.read_text(encoding="utf-8")

    with get_connection() as conn:
        conn.executescript(sql)


def show_requests():
    with get_connection() as conn:
        rows = conn.execute("""
            SELECT
                requests.request_id,
                clients.full_name,
                requests.device_type,
                requests.device_model,
                statuses.name,
                employees.full_name
            FROM requests
            JOIN clients
                ON requests.client_id = clients.client_id
            JOIN statuses
                ON requests.status_id = statuses.status_id
            LEFT JOIN employees
                ON requests.employee_id = employees.employee_id
        """).fetchall()

    for row in rows:
        print(row)


if __name__ == "__main__":
    initialize_database()
    print("База данных создана и заполнена.")
    show_requests()
