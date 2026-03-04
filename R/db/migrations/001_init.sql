-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    role TEXT NOT NULL CHECK(role IN ('admin','sales')),
    active INTEGER DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Proposals table
CREATE TABLE IF NOT EXISTS proposals (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    proposal_number TEXT UNIQUE,
    created_by INTEGER NOT NULL,
    status TEXT DEFAULT 'Draft',
    client_company TEXT,
    client_name TEXT,
    client_email TEXT,
    brief TEXT,
    currency TEXT DEFAULT 'USD',
    total_amount REAL DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(created_by) REFERENCES users(id)
);

-- Proposal line items
CREATE TABLE IF NOT EXISTS proposal_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    proposal_id INTEGER NOT NULL,
    label TEXT,
    qty REAL,
    unit_price REAL,
    total REAL,
    meta_json TEXT,

    FOREIGN KEY(proposal_id) REFERENCES proposals(id)
);

-- Audit logs
CREATE TABLE IF NOT EXISTS audit_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    action TEXT,
    entity_type TEXT,
    entity_id TEXT,
    meta_json TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);