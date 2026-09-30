# 1. CARGA DE LIBRERÍAS
library(DBI)
library(RSQLite)

# 2. CREAR CONEXIÓN LIMPIA
con <- dbConnect(RSQLite::SQLite(), "cinegetica_montes.db")

# 3. CREAR TABLAS MAESTRAS E INYECTAR DATOS DESDE R (Solución definitiva)
dbExecute(con, "
CREATE TABLE IF NOT EXISTS fauna (
    id_fauna TEXT PRIMARY KEY,
    nombre_comun TEXT NOT NULL,
    subgrupo TEXT
);")

dbExecute(con, "
CREATE TABLE IF NOT EXISTS fauna_biologia (
    id_fauna_biologia TEXT PRIMARY KEY,
    id_fauna TEXT UNIQUE,
    peso_min_kg REAL,
    peso_max_kg REAL,
    sensibilidad_climatica_invernal TEXT
);")

# Insertar registros de prueba de tu Máster si las tablas están vacías
dbExecute(con, "INSERT OR IGNORE INTO fauna VALUES ('FA0003', 'Perdiz Roja', 'Galliforme');")
dbExecute(con, "INSERT OR IGNORE INTO fauna VALUES ('FA0004', 'Conejo', 'Lagomorfo');")
dbExecute(con, "INSERT OR IGNORE INTO fauna VALUES ('FA0016', 'Becada', 'Charadriiforme');")
dbExecute(con, "INSERT OR IGNORE INTO fauna VALUES ('FA0020', 'Cabra Montés', 'Ungulado');")
dbExecute(con, "INSERT OR IGNORE INTO fauna VALUES ('FA0021', 'Zorzal Común', 'Paseriforme');")

dbExecute(con, "INSERT OR IGNORE INTO fauna_biologia VALUES ('FAUB0003', 'FA0003', 0.4, 0.5, 'Baja');")
dbExecute(con, "INSERT OR IGNORE INTO fauna_biologia VALUES ('FAUB0004', 'FA0004', 0.9, 2.5, 'Media');")
dbExecute(con, "INSERT OR IGNORE INTO fauna_biologia VALUES ('FAUB0016', 'FA0016', 0.28, 0.42, 'Muy Alta');")
dbExecute(con, "INSERT OR IGNORE INTO fauna_biologia VALUES ('FAUB0020', 'FA0020', 60.0, 110.0, 'Alta');")
dbExecute(con, "INSERT OR IGNORE INTO fauna_biologia VALUES ('FAUB0021', 'FA0021', 0.06, 0.09, 'Muy Alta');")

# 4. EXTRAER LA MATRIZ DE TRABAJO MEDIANTE UN JOIN RELACIONAL
query_biometria <- "
    SELECT f.nombre_comun, f.subgrupo, b.peso_min_kg, b.peso_max_kg, b.sensibilidad_climatica_invernal
    FROM fauna f
    JOIN fauna_biologia b ON f.id_fauna = b.id_fauna;
"
dataset_cinegetico <- dbGetQuery(con, query_biometria)

