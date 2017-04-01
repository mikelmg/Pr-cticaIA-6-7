; Grupo 16
; Germán Franco Dorca
; Miguel Mora Gómez

; ====== USUARIOS ======

(deftemplate usuario
	(slot nombre (type STRING))
	(slot edad (type INTEGER))
	(slot genero (type SYMBOL) (allowed-values h m))
	(slot nacionalidad (type SYMBOL))
	(slot so (type NUMBER) (default 999)))

; Interes genérico
(deftemplate interes
	(slot sujeto (type STRING))
	(slot interes (type SYMBOL))
	(slot valor (type NUMBER) (default 0)))

(deftemplate salario_edad
	(slot edad_min (type NUMBER))
	(slot edad_max (type NUMBER))
	(slot salario (type NUMBER)))

(deftemplate nivel_econ
	(slot usuario (type STRING))
	(slot nivel (type NUMBER) (allowed-values 0 1 2 3 4)))

; Internal use only
(deftemplate salario_estimado
	(slot usuario (type STRING))
	(slot estimacion (type NUMBER)))


; ====== APPS ======
(deftemplate app
	(slot id (type STRING))
	(slot categoria (type SYMBOL))
	(slot profit (type SYMBOL) (allowed-values gratis pago freemium suscripcion))
	(slot edad (type INTEGER))
	(slot so (type NUMBER) (default 0))
	(slot dev (type SYMBOL)))

; Cada usuario tiene una afinidad por cada app.
; De esta forma recomendamos la(s) que mayor interés le cause al usuario.
(deftemplate afinidad extends interes
	(slot sujeto (type STRING))
	(slot interes (type STRING)))

; Desarrolladores
(deftemplate devs
	(slot name (type STRING)))


; ====== FACTS ======

(deffacts usuarios
	(usuario (nombre "manolito94") (edad 24) (genero h) (nacionalidad es) (so 6))
	(usuario (nombre "lolHD") (edad 15) (genero h) (nacionalidad en_GB) (so 7))
	(usuario (nombre "juani") (edad 52) (genero m) (nacionalidad es) (so 4))
	(usuario (nombre "charstring") (edad 26) (genero m) (nacionalidad en_ZA) (so 6))
	(usuario (nombre "maricarmen") (edad 38) (genero m) (nacionalidad ms-my) (so 4)))


(deftemplate interes_cat extends interes
	(slot valor (default 20)))

(deffacts intereses_categorias
	(interes_cat (sujeto "manolito94") (interes juegos))
	(interes_cat (sujeto "manolito94") (interes deportes))
	(interes_cat (sujeto "juani") (interes salud))
	(interes_cat (sujeto "lolHD") (interes juegos)))

(deffacts apps
	(app (id "Whatsapp")(categoria social)(so 4)(profit gratis)(edad 25)(dev "Facebook"))
	(app (id "Candy Crush")(categoria juegos)(so 4) (profit freemium)(edad 30)(dev "King"))
	(app (id "Minecraft")(categoria juegos)(so 5) (profit pago)(edad 16)(dev "Mojang"))
	(app (id "Amazon")(categoria compras)(so 3)(profit freemium)(edad 31)(dev "Amazon"))
	(app (id "Telegram")(categoria social)(so 5)(profit gratis)(edad 23)(dev "Telegram"))
	(app (id "eBay")(categoria compras)(so 4)(profit freemium)(edad 34)(dev "eBay"))
	(app (id "Shazam")(categoria musica)(so 4)(profit gratis)(edad 17)(dev "Shazam Entertainment"))
	(app (id "Blablacar")(categoria viajes)(so 3)(profit freemium)(edad 39)(dev "BlaBlaCar"))
	(app (id "El Pais")(categoria noticias)(so 4)(profit gratis)(edad 48)(dev "Prisa"))
	(app (id "Dora la Exploradora")(categoria juegos)(so 4)(profit pago)(edad 5)(dev "Disney"))
	(app (id "Uber")(categoria viajes)(so 4)(profit freemium)(edad 32)(dev "Uber Tecnologies"))
	(app (id "Where's my Mickey")(categoria juegos)(so 4)(profit freemium)(edad 7)(dev "Disney"))
	(app (id "Need for Speed")(categoria juegos)(so 2)(profit pago)(edad 19)(dev "EA"))
	(app (id "Instagram")(categoria social)(so 4)(profit gratis)(edad 18)(dev "Facebook"))
	(app (id "Radios de España")(categoria musica)(so 5)(profit gratis)(edad 36)(dev "34labs"))
	(app (id "Youtube")(categoria video)(so 5)(profit gratis)(edad 20)(dev "Google"))
	(app (id "Adictolandia")(categoria juegos)(so 5)(profit freemium)(edad 6)(dev "Disney"))
	(app (id "Los sims")(categoria juegos)(so 6)(profit pago)(edad 27)(dev "EA"))
	(app (id "Photoshop express")(categoria juegos)(so 4)(profit suscripcion)(edad 27)(dev "Adobe"))
	(app (id "Spotify")(categoria musica)(so 2)(profit suscripcion)(edad 23)(dev "Spotify"))
	(app (id "La marea")(categoria noticias)(so 5)(profit suscripcion)(edad 33)(dev "MásPúblico"))
	(app (id "Project Fi")(categoria productividad)(so 6)(profit suscripcion)(edad 34)(dev "Google")))

(deftemplate interes_c extends interes
	(slot sujeto (type SYMBOL))
	(slot interes (type STRING))
	(slot valor (default 10)))

; Alto uso de apps por pais
(deffacts high_country_app_usage
	(interes_c (sujeto en_ZA) (interes "Whatsapp"))
	(interes_c (sujeto ms-my) (interes "Whatsapp"))
	(interes_c (sujeto es)    (interes "Instagram"))
	(interes_c (sujeto en-us) (interes "Twitter")))

; Interes de categorias por edad de usuario
(deffacts high_age_category_usage
	(hausage 18 24 social)
	(hausage 10 25 juegos)
	(hausage 35 44 social)
	(hausage 40 50 libros)
	(hausage 18 26 compras))

(deftemplate afinidad_mon extends interes
	(slot sujeto (type NUMBER) (allowed-values 0 1 2 3 4))
	(slot interes (type SYMBOL) (allowed-values gratis pago freemium suscripcion)))

; Interes tipo de app por nivel economico
(deffacts afinidad_monetizacion_nivel_eco
	(afinidad_mon (sujeto 0) (interes gratis) (valor 10))

	(afinidad_mon (sujeto 1) (interes gratis) (valor 8))
	(afinidad_mon (sujeto 1) (interes freemium) (valor 2))
	(afinidad_mon (sujeto 1) (interes pago) (valor 1))

	(afinidad_mon (sujeto 2) (interes gratis) (valor 7))
	(afinidad_mon (sujeto 2) (interes freemium) (valor 6))
	(afinidad_mon (sujeto 2) (interes pago) (valor 4))
	(afinidad_mon (sujeto 2) (interes suscripcion) (valor 2))

	(afinidad_mon (sujeto 3) (interes gratis) (valor 6))
	(afinidad_mon (sujeto 3) (interes freemium) (valor 5))
	(afinidad_mon (sujeto 3) (interes pago) (valor 6))
	(afinidad_mon (sujeto 3) (interes suscripcion) (valor 5))

	(afinidad_mon (sujeto 4) (interes gratis) (valor 4))
	(afinidad_mon (sujeto 4) (interes freemium) (valor 4))
	(afinidad_mon (sujeto 4) (interes pago) (valor 6))
	(afinidad_mon (sujeto 4) (interes suscripcion) (valor 6)))

; Salarios por edad (generalizacion)
(deffacts salarios_UK
	(salario_edad (edad_min 16) (edad_max 19) (salario 864))
	(salario_edad (edad_min 20) (edad_max 24) (salario 1085))
	(salario_edad (edad_min 25) (edad_max 29) (salario 1442))
	(salario_edad (edad_min 30) (edad_max 34) (salario 1714))

	(salario_edad (edad_min 35) (edad_max 39) (salario 1864))
	(salario_edad (edad_min 40) (edad_max 44) (salario 1907))
	(salario_edad (edad_min 45) (edad_max 49) (salario 1864))

	(salario_edad (edad_min 50) (edad_max 54) (salario 1836))
	(salario_edad (edad_min 55) (edad_max 59) (salario 1743))
	(salario_edad (edad_min 60) (edad_max 64) (salario 1557))

	(salario_edad (edad_min 65) (edad_max 69) (salario 1386))
	(salario_edad (edad_min 70) (edad_max 74) (salario 1243))
	(salario_edad (edad_min 75) (edad_max 999) (salario 1221)))

(deftemplate interes_eco extends interes
	(slot valor (default 10)))

; Intereses por nivel economico
(deffacts intereses_socieconomicos
	(interes_eco (sujeto 0) (interes empleo))
	(interes_eco (sujeto 0) (interes social))
	(interes_eco (sujeto 0) (interes noticias) (valor 5))

	(interes_eco (sujeto 1) (interes social))
	(interes_eco (sujeto 1) (interes educacion))
	(interes_eco (sujeto 1) (interes noticias))
	(interes_eco (sujeto 1) (interes familia))

	(interes_eco (sujeto 2) (interes comida) (valor 8))
	(interes_eco (sujeto 2) (interes salud) (valor 5))
	(interes_eco (sujeto 2) (interes entretenimiento))

	(interes_eco (sujeto 3) (interes finanzas))
	(interes_eco (sujeto 3) (interes compras))
	(interes_eco (sujeto 3) (interes salud))
	(interes_eco (sujeto 3) (interes entretenimiento))

	(interes_eco (sujeto 4) (interes finanzas))
	(interes_eco (sujeto 4) (interes compras))
	(interes_eco (sujeto 4) (interes viajes)))

; ====== RULES ======

; Create affinity facts
(defrule init_afinidad
	(usuario (nombre ?nombre))
	(app (id ?appid))
	=>
	(assert (afinidad (sujeto ?nombre) (interes ?appid))))

; Remove unsupported apps
(defrule test_so
	(usuario (nombre ?nombre) (so ?uso))
	(app (id ?appid) (so ?aso))
	(test (< ?uso ?aso))
	?af <- (afinidad (sujeto ?nombre) (interes ?appid))
	=>
	(retract ?af))


; ====== Reglas de afinidad ======

; Check category matchings
(defrule aff_categoria
	(usuario (nombre ?nombre))
	?int_cat <- (interes (sujeto ?nombre) (interes ?cat) (valor ?interes))
	(app (id ?appid) (categoria ?cat))
	?af <- (afinidad (sujeto ?nombre) (interes ?appid) (valor ?afmount))
	 ; dont repeat with modified affinity facts
	(not (done d_aff_categoria ?nombre ?appid ?int_cat))
	=>
	(modify ?af (valor (+ ?afmount ?interes)))
	(assert (done d_aff_categoria ?nombre ?appid ?int_cat)))

; Check recommended age matching
(defrule aff_edad
	(usuario (nombre ?usu) (edad ?edad))
	(app (id ?appid) (edad ?edad_recomendada))
	?af <- (afinidad (sujeto ?usu) (interes ?appid) (valor ?afmount))
	; dont repeat with modified affinity facts
	(not (done d_aff_edad ?usu ?appid))

	(test (< ?edad (* ?edad_recomendada 1.3)))
	(test (> ?edad (* ?edad_recomendada 0.7)))
	=>
	(modify ?af (valor (+ ?afmount 10)))
	(assert (done d_aff_edad ?usu ?appid)))

; Affinity per country usage
(defrule aff_country
	(usuario (nombre ?usu) (nacionalidad ?pais))
	(app (id ?appid))
	?af <- (afinidad (sujeto ?usu) (interes ?appid) (valor ?afmount))
	(interes (sujeto ?pais) (interes ?appid) (valor ?valor))
	(not (done d_aff_country ?usu ?appid ?pais))
	=>
	(modify ?af (valor (+ ?afmount ?valor)))
	(assert (done d_aff_country ?usu ?appid ?pais)))

; Affinity per age usage
(defrule aff_age
	(usuario (nombre ?usu) (edad ?edad))
	(hausage ?min ?max ?cat)
	(test (and (>= ?edad ?min) (<= ?edad ?max)))
	=>
	(assert (interes (sujeto ?usu) (interes ?cat) (valor 10))))

; Affinity per socioeconomic level
(defrule aff_economic
	(usuario (nombre ?usu))
	(nivel_econ (usuario ?usu) (nivel ?nec))
	(interes_eco (sujeto ?nec) (interes ?categoria) (valor ?val))
	=>
	(assert (interes (sujeto ?usu) (interes ?categoria) (valor ?val))))

; Salary calculation based on estimations
(defrule estimacion_salario_h
	(salario_edad (edad_min ?edad_min) (edad_max ?edad_max) (salario ?salario))
	(usuario (nombre ?usu) (edad ?edad) (genero h))
	(test (>= ?edad ?edad_min))
	(test (<= ?edad ?edad_max))
	=>
	(assert (salario_estimado (usuario ?usu) (estimacion ?salario))))

(defrule estimacion_salario_m
	(salario_edad (edad_min ?edad_min) (edad_max ?edad_max) (salario ?salario))
	(usuario (nombre ?usu) (edad ?edad) (genero m))
	(test (>= ?edad ?edad_min))
	(test (<= ?edad ?edad_max))
	=>
	(bind ?salario_est (* ?salario 0.8))
	(assert (salario_estimado (usuario ?usu) (estimacion ?salario_est))))

; Socioeconomic level assignment based on the estimated salary
(defrule asig_nivel_socioeconomico_0
	?estimacion <- (salario_estimado (usuario ?usuario) (estimacion ?salario))
	(test (< ?salario 700))
	=>
	(retract ?estimacion)
	(assert (nivel_econ (usuario ?usuario) (nivel 0))))

(defrule asig_nivel_socioeconomico_1
	?estimacion <- (salario_estimado (usuario ?usuario) (estimacion ?salario))
	(test (> ?salario 700))
	(test (< ?salario 1500))
	=>
	(retract ?estimacion)
	(assert (nivel_econ (usuario ?usuario) (nivel 1))))

(defrule asig_nivel_socioeconomico_2
	?estimacion <- (salario_estimado (usuario ?usuario) (estimacion ?salario))
	(test (> ?salario 1500))
	(test (< ?salario 2200))
	=>
	(retract ?estimacion)
	(assert (nivel_econ (usuario ?usuario) (nivel 2))))

(defrule asig_nivel_socioeconomico_3
	?estimacion <- (salario_estimado (usuario ?usuario) (estimacion ?salario))
	(test (> ?salario 2200))
	(test (< ?salario 3000))
	=>
	(retract ?estimacion)
	(assert (nivel_econ (usuario ?usuario) (nivel 3))))

(defrule asig_nivel_socioeconomico_4
	?estimacion <- (salario_estimado (usuario ?usuario) (estimacion ?salario))
	(test (> ?salario 3000))
	=>
	(retract ?estimacion)
	(assert (nivel_econ (usuario ?usuario) (nivel 4))))

(defrule aff_monetizacion
	(usuario (nombre ?usu) (edad ?edad))
	(app (id ?appid) (profit ?monetizacion))
	?af <- (afinidad (sujeto ?usu) (interes ?appid) (valor ?afmount))
	(nivel_econ (usuario ?usu) (nivel ?nec))

	; intereses por nivel economico
	(afinidad (sujeto ?nec) (interes ?monetizacion) (valor ?interes))

	; dont repeat with modified affinity facts
	(not (done d_aff_mon ?usu ?appid))
	=>
	(modify ?af (valor (+ ?afmount ?interes)))
	(assert (done d_aff_mon ?usu ?appid)))

(reset)
(run)
