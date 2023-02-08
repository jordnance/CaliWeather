CREATE TABLE IF NOT EXISTS User(
    userId integer PRIMARY KEY AUTOINCREMENT,
    username text NOT NULL,
    password text NOT NULL
);

CREATE TABLE IF NOT EXISTS Preference(
    userprefId integer PRIMARY KEY REFERENCES User(userId) ON DELETE CASCADE,
    lang text default "English",
    fontSize integer default 12,
    alerts text default NULL,
    tempFormat text default "Fahrenheit",
    theme text default "Light",
    cityName text default "Fresno"
);

PRAGMA foreign_keys = ON;