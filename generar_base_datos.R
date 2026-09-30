# PROYECTO DE MÁSTER: GESTIÓN CINEGÉTICA Y FORESTAL
# AUTOMATIZACIÓN DE CARPETAS Y ARCHIVOS .CSV EN R

# 1. Definición de rutas y estructura relacional
ruta_base <- "data"
carpetas <- c("Cinegética", "Ecología", "Economía", "Fauna", "Forestal", "Legal", "Sanitario")

for (carpeta in carpetas) {
  dir.create(file.path(ruta_base, carpeta), recursive = TRUE, showWarnings = FALSE)
}
message("✅ Estructura de directorios /data creada con éxito.")

# =====================================================================
# MÓDULO: FAUNA & TAXONOMÍA
# =====================================================================

# fauna.csv
fauna <- data.frame(
  id_fauna = c("FA0001", "FA0003", "FA0004", "FA0005", "FA0008", "FA0010", "FA0011", "FA0013", "FA0014", "FA0016", "FA0017", "FA0018", "FA0019", "FA0020", "FA0021"),
  nombre_comun = c("Jabalí", "Perdiz Roja", "Conejo", "Ciervo", "Codorniz Común", "Faisán Común", "Colín de Virginia", "Paloma Torcaz", "Paloma Zurita", "Becada", "Ánade Azulón", "Urraca", "Corneja Negra", "Cabra Montés", "Zorzal Común"),
  nombre_cientifico = c("Sus scrofa", "Alectoris rufa", "Oryctolagus cuniculus", "Cervus elaphus", "Coturnix coturnix", "Phasianus colchicus", "Colinus virginianus", "Columba palumbus", "Columba oenas", "Scolopax rusticola", "Anas platyrhynchos", "Pica pica", "Corvus corone", "Capra pyrenaica", "Turdus philomelos"),
  grupo_taxonomico = c("Mamífero", "Ave", "Mamífero", "Mamífero", "Ave", "Ave", "Ave", "Ave", "Ave", "Ave", "Ave", "Ave", "Ave", "Mamífero", "Ave"),
  subgrupo = c("Ungulado", "Galliforme", "Lagomorfo", "Ungulado", "Galliforme", "Galliforme", "Galliforme", "Columbiforme", "Columbiforme", "Charadriiforme", "Anseriforme", "Paseriforme (Córvido)", "Paseriforme (Córvido)", "Ungulado", "Paseriforme"),
  categoria_gestion = c("Caza Mayor", "Caza Menor", "Caza Menor", "Caza Mayor", "Caza Menor", "Caza Menor", "Caza Menor", "Caza Menor", "Caza Menor", "Caza Menor", "Caza Menor", "Caza Menor (Control)", "Caza Menor (Control)", "Caza Mayor", "Caza Menor"),
  especie_autoctona = c("Sí", "Sí", "Sí", "Sí", "Sí", "No", "No", "Sí", "Sí", "Sí", "Sí", "Sí", "Sí", "Sí", "Sí"),
  indice_contaminacion_genetica = c("Bajo", "Alto", "Bajo", "Medio", "Bajo", "Muy Alto", "Muy Alto", "Bajo", "Bajo", "Nulo", "Alto", "Nulo", "Nulo", "Nulo", "Bajo"),
  stringsAsFactors = FALSE
)
write.csv(fauna, file.path(ruta_base, "Fauna", "fauna.csv"), row.names = FALSE, fileEncoding = "UTF-8")

# fauna_biologia.csv (NA = Vacíos numéricos nativos de R para estadística)
fauna_biologia <- data.frame(
  id_fauna_biologia = c("FAUB0001", "FAUB0003", "FAUB0004", "FAUB0005", "FAUB0008", "FAUB0013", "FAUB0016", "FAUB0017", "FAUB0020", "FAUB0021"),
  id_fauna = c("FA0001", "FA0003", "FA0004", "FA0005", "FA0008", "FA0013", "FA0016", "FA0017", "FA0020", "FA0021"),
  peso_min_kg = c(35.0, 0.4, 0.9, 80.0, 0.09, 0.45, 0.28, 0.85, 60.0, 0.06),
  peso_max_kg = c(120.0, 0.5, 2.5, 200.0, 0.15, 0.55, 0.42, 1.50, 110.0, 0.09),
  envergadura_min_cm = c(NA, 50.0, NA, NA, 32.0, 75.0, 56.0, 80.0, NA, 30.0),
  envergadura_max_cm = c(NA, 60.0, NA, NA, 37.0, 80.0, 65.0, 100.0, NA, 36.0),
  sensibilidad_climatica_invernal = c("Baja", "Baja", "Media", "Baja", "Alta", "Media", "Muy Alta", "Media", "Alta", "Muy Alta"),
  vulnerabilidad_mancado_eclipse = c(0, 0, 0, 0, 0, 0, 0, 1, 0, 0), # Booleanos funcionales
  num_crias_huevos_max = c(8, 17, 6, 2, 12, 2, 4, 12, 2, 6),
  stringsAsFactors = FALSE
)
write.csv(fauna_biologia, file.path(ruta_base, "Fauna", "fauna_biologia.csv"), row.names = FALSE, fileEncoding = "UTF-8")

# fauna_subespecies.csv
fauna_subespecies <- data.frame(
  id_subespecie = c("SUB0001", "SUB0002", "SUB0003", "SUB0004", "SUB0005", "SUB0006"),
  id_fauna = c("FA0003", "FA0004", "FA0004", "FA0020", "FA0020", "FA0003"),
  nombre_subespecie = c("Alectoris rufa rufa", "Oryctolagus cuniculus cuniculus", "Oryctolagus cuniculus algirus", "Capra pyrenaica victoriae", "Capra pyrenaica hispanica", "Alectoris rufa intercedens"),
  region_endemica_predominante = c("Norte y Centro", "Norte del Ebro", "Sur del Ebro y Portugal", "Sistema Central (Gredos)", "Sistemas Béticos", "Sur y Levante"),
  indice_pureza_genetica_promedio = c("Medio", "Alto", "Alto", "Excelente", "Excelente", "Bajo"),
  stringsAsFactors = FALSE
)
write.csv(fauna_subespecies, file.path(ruta_base, "Fauna", "fauna_subespecies.csv"), row.names = FALSE, fileEncoding = "UTF-8")

# =====================================================================
# MÓDULO: CINEGÉTICA & ECOLOGÍA TERRITORIAL (Códigos INE para mapas)
# =====================================================================

especies_cinegeticas <- data.frame(
  id_cinegetica = c("CIN0001", "CIN0002", "CIN0003", "CIN0004", "CIN0005", "CIN0006", "CIN0007"),
  id_fauna = c("FA0001", "FA0005", "FA0003", "FA0004", "FA0016", "FA0017", "FA0020"),
  tipo_caza = c("Mayor", "Mayor", "Menor", "Menor", "Menor", "Menor", "Mayor"),
  categoria_caza = c("Ungulado", "Ungulado", "Ave", "Lagomorfo", "Ave Forestal", "Acuática", "Ungulado Alta Montaña"),
  modalidades_aprovechamiento = c("Montería/Batida", "Montería/Rececho", "Al salto/Ojeo", "Al salto/Con perro/Hurón", "Rececho con perro", "Puesto fijo", "Rececho alta montaña"),
  aprovechamiento_media_veda = c(0, 0, 0, 1, 0, 0, 0),
  stringsAsFactors = FALSE
)
write.csv(especies_cinegeticas, file.path(ruta_base, "Cinegética", "especies_cinegeticas.csv"), row.names = FALSE, fileEncoding = "UTF-8")

relacion_fauna_territorio <- data.frame(
  id_territorio_fauna = c("TER0001", "TER0002", "TER0003", "TER0004", "TER0005", "TER0006"),
  id_fauna = c("FA0020", "FA0020", "FA0021", "FA0003", "FA0004", "FA0016"),
  comunidad_autonoma = c("Castilla y León", "Andalucía", "Andalucía", "Castilla-La Mancha", "Extremadura", "Galicia"),
  provincia_presencia = c("Ávila", "Jaén", "Jaén", "Ciudad Real", "Badajoz", "Lugo"),
  codigo_ine_provincia = c(5, 23, 23, 13, 6, 27), # Para usar mapas del IGN directamente
  estatus_presencia = c("Residente Estable", "Residente Estable", "Invernante Abundante", "Residente", "Alta Densidad", "Invernante"),
  densidad_estimada_nivel = c("Media", "Alta", "Muy Alta", "Media-Baja", "Muy Alta", "Alta"),
  stringsAsFactors = FALSE
)
write.csv(relacion_fauna_territorio, file.path(ruta_base, "Ecología", "relacion_fauna_territorio.csv"), row.names = FALSE, fileEncoding = "UTF-8")

# habitats.csv
habitats <- data.frame(
  id_habitat = c("HAB0005", "HAB0006", "HAB0007", "HAB0008", "HAB0009", "HAB0011"),
  nombre_habitat = c("Montaña Alpina", "Bosque Caducifolio", "Bosque de Coníferas", "Bosque Mediterráneo", "Estepa / Agrícola", "Lagos y Marismas"),
  tipo_habitat = c("Montano", "Forestal Húmedo", "Forestal Seco", "Silvopastoral", "Abierto Cerealista", "Humedal"),
  capacidad_refugio = c("Media", "Muy Alta", "Alta", "Muy Alta", "Baja", "Media"),
  valor_cinegetico = c("Alto", "Muy Alto", "Alto", "Excelente", "Muy Alto", "Muy Alto"),
  stringsAsFactors = FALSE
)
write.csv(habitats, file.path(ruta_base, "Ecología", "habitats.csv"), row.names = FALSE, fileEncoding = "UTF-8")

# =====================================================================
# MÓDULO: FORESTAL, ECONOMÍA & SANITARIO
# =====================================================================

especies_forestales <- data.frame(
  id_especie_forestal = c("ESP0001", "ESP0002", "ESP0004", "ESP0005"),
  nombre_cientifico = c("Quercus ilex", "Pinus pinaster", "Castanea sativa", "Ulmus minor"),
  nombre_vulgar = c("Encina", "Pino resinero", "Castaño", "Olmo"),
  familia = c("Fagaceae", "Pinaceae", "Fagaceae", "Ulmaceae"),
  concepto_fernando = c("La bellota vale más que la madera", "La resina explica su historia económica", "Alta durabilidad natural", "Declive histórico por grafiosis"),
  stringsAsFactors = FALSE
)
write.csv(especies_forestales, file.path(ruta_base, "Forestal", "especies.csv"), row.names = FALSE, fileEncoding = "UTF-8")

usos_madera <- data.frame(
  id_uso = c("USO0001", "USO0002", "USO0003", "USO0004"),
  id_especie_forestal = c("ESP0001", "ESP0002", "ESP0004", "ESP0005"),
  uso_estructural = c(0, 1, 1, 1),
  uso_muebles = c(0, 1, 1, 1),
  uso_lena = c(1, 0, 0, 0),
  uso_barricas = c(0, 0, 1, 0),
  stringsAsFactors = FALSE
)
write.csv(usos_madera, file.path(ruta_base, "Forestal", "usos_madera.csv"), row.names = FALSE, fileEncoding = "UTF-8")

conflictos_sanitarios <- data.frame(
  id_conflicto = c("CONF0001", "CONF0002", "CONF0003", "CONF0004"),
  id_fauna = c("FA0001", "FA0005", "FA0004", "FA0017"),
  tipo_conflicto_antropico = c("Accidentes Tráfico / Urbano", "Daño Forestal Escodaduras", "Daño Infraestructura AVE", "Daños Cultivo Arrozal"),
  vector_patogeno = c("Mycobacterium bovis", "Mycobacterium bovis", "Virus Mixoma / RHDV", "Virus Influenza Aviaria"),
  especie_destino_afectada = c("Ganado Vacuno / Humano", "Ganado Caprino", "Lince Ibérico (Presa)", "Aves de Corral / Humano"),
  impacto_socioeconomico = c("Muy Alto", "Alto", "Muy Alto", "Alto"),
  stringsAsFactors = FALSE
)
write.csv(conflictos_sanitarios, file.path(ruta_base, "Sanitario", "relacion_fauna_conflicto_sanitario.csv"), row.names = FALSE, fileEncoding = "UTF-8")

message("🚀 Base de datos e ingeniería de variables consolidada en /data desde R.")


