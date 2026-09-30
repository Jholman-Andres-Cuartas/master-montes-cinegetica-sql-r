import sqlite3
import os

def inicializar_base_datos():
    # Creamos de forma limpia el archivo de la base de datos SQL
    db_path = "cinegetica_montes.db"
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    print("🛠️ Creando tablas relacionales con restricciones PK/FK en SQL...")
    
    # 1. TABLA MAESTRA: FAUNA (Corregido a NOT NULL)
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS fauna (
        id_fauna TEXT PRIMARY KEY,
        nombre_comun TEXT NOT NULL,
        nombre_cientifico TEXT NOT NULL,
        grupo_taxonomico TEXT,
        subgrupo TEXT,
        categoria_gestion TEXT,
        especie_autoctona TEXT,
        indice_contaminacion_genetica TEXT
    );
    """)

    # 2. TABLA BIOLOGÍA (Relación 1:1 con Fauna)
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS fauna_biologia (
        id_fauna_biologia TEXT PRIMARY KEY,
        id_fauna TEXT UNIQUE,
        peso_min_kg REAL,
        peso_max_kg REAL,
        envergadura_min_cm REAL,
        envergadura_max_cm REAL,
        sensibilidad_climatica_invernal TEXT,
        vulnerabilidad_mancado_eclipse INTEGER,
        num_crias_huevos_max INTEGER,
        FOREIGN KEY (id_fauna) REFERENCES fauna (id_fauna) ON DELETE CASCADE
    );
    """)

    # 3. TABLA HÁBITATS (Corregido a NOT NULL)
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS habitats (
        id_habitat TEXT PRIMARY KEY,
        nombre_habitat TEXT NOT NULL,
        tipo_habitat TEXT,
        capacidad_refugio TEXT,
        valor_cinegetico TEXT
    );
    """)

    # 4. TABLA INTERMEDIA: FAUNA Y TERRITORIO (Clave para tus mapas en R)
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS relacion_fauna_territorio (
        id_territorio_fauna TEXT PRIMARY KEY,
        id_fauna TEXT,
        comunidad_autonoma TEXT,
        provincia_presencia TEXT,
        codigo_ine_provincia INTEGER,
        estatus_presencia TEXT,
        densidad_estimada_nivel TEXT,
        FOREIGN KEY (id_fauna) REFERENCES fauna (id_fauna)
    );
    """)

    # 5. TABLA ESPECIES CINEGÉTICAS
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS especies_cinegeticas (
        id_cinegetica TEXT PRIMARY KEY,
        id_fauna TEXT,
        tipo_caza TEXT,
        categoria_caza TEXT,
        modalidades_aprovechamiento TEXT,
        aprovechamiento_media_veda INTEGER,
        FOREIGN KEY (id_fauna) REFERENCES fauna (id_fauna)
    );
    """)

    # 6. TABLA INTERMEDIA: RELACIÓN CINEGÉTICA HÁBITAT
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS relacion_cinegetica_habitat (
        id_cinegetica TEXT,
        id_habitat TEXT,
        idoneidad_habitat TEXT,
        uso_estacional TEXT,
        PRIMARY KEY (id_cinegetica, id_habitat),
        FOREIGN KEY (id_cinegetica) REFERENCES especies_cinegeticas (id_cinegetica),
        FOREIGN KEY (id_habitat) REFERENCES habitats (id_habitat)
    );
    """)

    conn.commit()
    print("✅ Tablas SQL creadas de forma robusta.")
    
    # --- INYECCIÓN DE DATOS OPTIMIZADA CON PYTHON ---
    print("⏳ Insertando registros maestros...")
    
    # Datos de Fauna
    fauna_datos = [
        ("FA0003", "Perdiz Roja", "Alectoris rufa", "Ave", "Galliforme", "Caza Menor", "Sí", "Alto"),
        ("FA0004", "Conejo", "Oryctolagus cuniculus", "Mamífero", "Lagomorfo", "Caza Menor", "Sí", "Bajo"),
        ("FA0016", "Becada", "Scolopax rusticola", "Ave", "Charadriiforme", "Caza Menor", "Sí", "Nulo"),
        ("FA0020", "Cabra Montés", "Capra pyrenaica", "Mamífero", "Ungulado", "Caza Mayor", "Sí", "Nulo"),
        ("FA0021", "Zorzal Común", "Turdus philomelos", "Ave", "Paseriforme", "Caza Menor", "Sí", "Bajo")
    ]
    cursor.executemany("INSERT OR IGNORE INTO fauna VALUES (?,?,?,?,?,?,?,?);", fauna_datos)

    # Datos Biológicos (Optimizados para R, usando None para campos vacíos)
    biologia_datos = [
        ("FAUB0003", "FA0003", 0.4, 0.5, 50.0, 60.0, "Baja", 0, 17),
        ("FAUB0004", "FA0004", 0.9, 2.5, None, None, "Media", 0, 6),
        ("FAUB0016", "FA0016", 0.28, 0.42, 56.0, 65.0, "Muy Alta", 0, 4),
        ("FAUB0020", "FA0020", 60.0, 110.0, None, None, "Alta", 0, 2),
        ("FAUB0021", "FA0021", 0.06, 0.09, 30.0, 36.0, "Muy Alta", 0, 6)
    ]
    cursor.executemany("INSERT OR IGNORE INTO fauna_biologia VALUES (?,?,?,?,?,?,?,?,?);", biologia_datos)

    # Datos Territoriales (Códigos INE directos para mapas de R)
    territorio_datos = [
        ("TER0001", "FA0020", "Castilla y León", "Ávila", 5, "Residente Estable", "Media"),
        ("TER0002", "FA0020", "Andalucía", "Jaén", 23, "Residente Estable", "Alta"),
        ("TER0003", "FA0021", "Andalucía", "Jaén", 23, "Invernante Abundante", "Muy Alta"),
        ("TER0004", "FA0003", "Castilla-La Mancha", "Ciudad Real", 13, "Residente", "Media-Baja")
    ]
    cursor.executemany("INSERT OR IGNORE INTO relacion_fauna_territorio VALUES (?,?,?,?,?,?,?);", territorio_datos)

    conn.commit()
    conn.close()
    print("🚀 Base de datos relacional 'cinegetica_montes.db' construida y lista para usar.")

if __name__ == "__main__":
    inicializar_base_datos()
