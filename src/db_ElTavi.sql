-- Database: db_eltavi

-- DROP DATABASE IF EXISTS db_eltavi;

CREATE DATABASE db_eltavi
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Indonesian_Indonesia.1252'
    LC_CTYPE = 'Indonesian_Indonesia.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

-- Create Tables

CREATE TABLE Penyewa (
    id_Penyewa VARCHAR(5) PRIMARY KEY,
    nama_Penyewa VARCHAR(20) NOT NULL,
    notelp_Penyewa VARCHAR(14) NOT NULL,
    alamat_Penyewa VARCHAR(40)
);

CREATE TABLE Karyawan (
    id_Karyawan VARCHAR(5) PRIMARY KEY,
    nama_Karyawan VARCHAR(20) NOT NULL,
    notelp_Karyawan VARCHAR(20) NOT NULL
);

CREATE TABLE Studio (
    id_Studio VARCHAR(5) PRIMARY KEY,
    nama_Ruangan VARCHAR(256) NOT NULL,
    harga_Per_Shift NUMERIC(8, 2) NOT NULL,
    fasilitas TEXT NOT NULL
);

CREATE TABLE Stok_Jajan (
    id_Jajan VARCHAR(5) PRIMARY KEY,
    nama_Jajan VARCHAR(256) NOT NULL,
    harga_Satuan NUMERIC(7, 2) NOT NULL,
    jumlah_Stok INT NOT NULL
);

CREATE TABLE Sewa_Studio (
    id_Sewa_Studio VARCHAR(5) PRIMARY KEY,
    banyak_Shift INT NOT NULL,
    start_From TIMESTAMP NOT NULL,
    finish_At TIMESTAMP NOT NULL,
    
    Studio_id_Studio VARCHAR(5) NOT NULL,

    CONSTRAINT fk_1_Studio_id_Studio
        FOREIGN KEY(Studio_id_Studio)
            REFERENCES Studio(id_Studio)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

CREATE TABLE Nota_Jajan (
    id_Nota_Jajan VARCHAR(5) PRIMARY KEY,
    id_Jajan VARCHAR(5) NOT NULL,
    jumlah_Jajan INT NOT NULL,
    
    Stok_Jajan_id_Jajan VARCHAR(5) NOT NULL,

    CONSTRAINT fk_1_Stok_Jajan_id_Jajan
        FOREIGN KEY(Stok_Jajan_id_Jajan)
            REFERENCES Stok_Jajan(id_Jajan)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

CREATE TABLE Pembayaran(
    id_Pembayaran VARCHAR(5) PRIMARY KEY,
    jumlah_Tagihan NUMERIC(10, 2) NOT NULL,
    status_Pembayaran BOOLEAN NOT NULL,

    Penyewa_id_Penyewa VARCHAR(5) NOT NULL,
    Karyawan_id_Karyawan VARCHAR(5) NOT NULL,
    Nota_Jajan_id_Nota_Jajan VARCHAR(5),
    Sewa_Studio_id_Sewa_Studio VARCHAR(5) NOT NULL,

    CONSTRAINT fk_1_Penyewa_id_Penyewa
        FOREIGN KEY(Penyewa_id_Penyewa)
            REFERENCES Penyewa(id_Penyewa)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT fk_2_Karyawan_id_Karyawan
        FOREIGN KEY(Karyawan_id_Karyawan)
            REFERENCES Karyawan(id_Karyawan)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT fk_3_Nota_Jajan_id_Nota_Jajan
        FOREIGN KEY(Nota_Jajan_id_Nota_Jajan)
            REFERENCES Nota_Jajan(id_Nota_Jajan)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT fk_4_Sewa_Studio_id_Sewa_Studio
        FOREIGN KEY(Sewa_Studio_id_Sewa_Studio)
            REFERENCES Sewa_Studio(id_Sewa_Studio)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

CREATE TABLE Log_Perubahan(
    id_Log_Perubahan VARCHAR(5) PRIMARY KEY,
    id_Sewa VARCHAR(5) NOT NULL,
    old_Start_From TIMESTAMP NOT NULL,
    old_Finish_At TIMESTAMP NOT NULL,
    diubah_At TIMESTAMP NOT NULL,
    status VARCHAR(256) NOT NULL,
    new_Start_From TIMESTAMP NOT NULL,
    new_Finish_At TIMESTAMP NOT NULL
);

/* ===== ===== */

-- Data Table Queries
INSERT INTO
    Stok_Jajan(id_Jajan, nama_Jajan, harga_Satuan, jumlah_Stok)
VALUES
    ('J0001', 'Beng-Beng', 3500.00, 40),
    ('J0002', 'Chitato', 17000.00, 20),
    ('J0003', 'Cheetos', 17000.00, 20),
    ('J0004', 'Qtela', 17000.00, 20),
    ('J0005', 'Taro', 17000.00, 20),
    ('J0006', 'Pocky', 15000.00, 30),
    ('J0007', 'Richeese Nabati', 3500.00, 50),
    ('J0008', 'Tango', 3500.00, 50),
    ('J0009', 'Pringles', 15000.00, 30),
    ('J0010', 'Pop Mie', 15000.00, 15),
    ('J0011', 'Mie Sedap Cup', 15000.00, 15),
    ('J0012', 'Fanta', 6000.00, 100),
    ('J0013', 'Coca-cola', 6000.00, 100),
    ('J0014', 'Sprite', 6000.00, 100),
    ('J0015', 'Ultra Milk', 8000.00, 100),
    ('J0016', 'Indomilk', 8000.00, 100),
    ('J0017', 'Pocari Sweat', 9000.00, 100),
    ('J0018', 'Minute Maid', 8000.00, 100),
    ('J0019', 'Aqua', 4000.00, 100),
    ('J0020', 'Kapal Api', 3000.00, 100),
    ('J0021', 'Kratingdaeng', 7000.00, 100);

/* ===== ===== */