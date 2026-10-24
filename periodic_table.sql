DROP DATABASE IF EXISTS periodic_table;

CREATE DATABASE periodic_table;

\c periodic_table;

CREATE TABLE elements (
    atomic_number INTEGER PRIMARY KEY,
    symbol VARCHAR(2) UNIQUE NOT NULL,
    name VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE types (
    type_id SERIAL PRIMARY KEY,
    type VARCHAR(10) UNIQUE NOT NULL
);

CREATE TABLE properties (
    atomic_number INTEGER PRIMARY KEY,
    atomic_mass VARCHAR(20) NOT NULL,
    melting_point_celsius VARCHAR(20) NOT NULL,
    boiling_point_celsius VARCHAR(20) NOT NULL,
    type_id INTEGER NOT NULL,
    CONSTRAINT properties_atomic_number_fkey FOREIGN KEY (atomic_number)
        REFERENCES elements(atomic_number),
    CONSTRAINT properties_type_id_fkey FOREIGN KEY (type_id)
        REFERENCES types(type_id)
);

INSERT INTO elements (atomic_number, symbol, name) VALUES
    (1, 'H', 'Hydrogen'),
    (2, 'He', 'Helium'),
    (3, 'Li', 'Lithium'),
    (4, 'Be', 'Beryllium'),
    (5, 'B', 'Boron'),
    (6, 'C', 'Carbon'),
    (7, 'N', 'Nitrogen'),
    (8, 'O', 'Oxygen'),
    (9, 'F', 'Fluorine'),
    (10, 'Ne', 'Neon');

INSERT INTO types (type) VALUES
    ('metal'),
    ('metalloid'),
    ('nonmetal');

INSERT INTO properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES
    (1, '1.008', '-259.1', '-252.9', 3),
    (2, '4.0026', '-272.2', '-269', 3),
    (3, '6.94', '180.5', '1342', 1),
    (4, '9.0122', '1287', '2470', 1),
    (5, '10.81', '2075', '4000', 2),
    (6, '12.011', '3550', '4027', 3),
    (7, '14.007', '-210.1', '-195.8', 3),
    (8, '15.999', '-218', '-183', 3),
    (9, '18.998', '-220', '-188.1', 3),
    (10, '20.18', '-248.6', '-246.1', 3);
