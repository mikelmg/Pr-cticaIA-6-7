; Grupo 16
; Germán Franco Dorca
; Miguel Mora Gómez

; Cargar --> (batch "meta.clp")

(mapclass App)
(mapclass gratis)
(mapclass pago)
(mapclass suscripcion)
(mapclass freemium)

(mapclass Desarrollador)
(mapclass Usuario)
(mapclass Recomendacion)

; Carga aplicaciones Jess a Protégé
(defrule load-app
	(app (id ?id)(categoria ?cat)(profit ?profit)(edad ?edad)(so ?so)(dev ?devname))
	?dev <- (object (is-a Desarrollador) (Nombre ?devname))
	; Si no habíamos insertado esta aplicación anteriormente
	(not (object (is-a ?profit) (Nombre ?id)))
	=>
	(printout t "Cargada aplicación " ?id crlf)
	(make-instance of ?profit
		(Nombre ?id)
		(Categorias ?cat)
		(edad_recomendada ?edad)
		; Nuestras aplicaciones jess no tienen SO si no versión de Android,
		; así que lo cargamos así para que haya algo de variedad
		(Sistema_operativo (if (= (mod (random) 2) 0) then Android else iOS))
		(descargas (* 100 (random)))
		(Puntuacion (float (mod (random) 6)))
		(desarrollador ?dev)))

; Crea instancias de Desarrollador en Protégé a partir del nombre en la app Jess
(defrule create-non-existing-dev
	?app <-(app (dev ?devname))
	(not (object (is-a Desarrollador) (Nombre ?devname)))
	(not (test (= ?devname nil)))
	=>
	(make-instance of Desarrollador (Nombre ?devname)))

; Carga a Jess un usuario Protégé para poder empezar la recomendación
(defrule get-protege-user-input
	?usuario <- (object (is-a Usuario)
		(Nombre ?nombre)
		(Edad ?edad)
		(Genero ?genero)
		(Nacionalidad ?nacionalidad)
		(Categorias ?interes_categoria))
	(not (usuario (nombre ?nombre)))
	=>
	(printout t "Cargado usuario " ?nombre crlf)
	(assert (usuario
		(nombre ?nombre)
		(edad ?edad)
		(genero (if (= ?genero hombre) then h else m))
		(nacionalidad ?nacionalidad)))
	(assert (interes_cat (sujeto ?nombre)(interes ?interes_categoria))))

; Covierte las afinidades Jess en Recomendaciones Protégé
(defrule convertir-afinidad
	(afinidad (sujeto ?nombre)(interes ?appname)(valor ?afinidad))
	(object (OBJECT ?usuario)(is-a Usuario)(Nombre ?nombre)(Sistema_operativo ?so))
	(app (id ?appname)(profit ?profit))
	(object (OBJECT ?app)(is-a ?profit)(Nombre ?appname)(Sistema_operativo ?so))
	(not (object (is-a Recomendacion)(app_recomendada ?app)(recomendada_a ?usuario)))
	(test (> ?afinidad 0))
	=>
	(make-instance of Recomendacion
		(app_recomendada ?app)
		(recomendada_a ?usuario)
		(afinidad ?afinidad)))

; Actualiza las recomendaciones en Protéǵé cuando se actualizan en Jess
(defrule actualizar-afinidad
	(afinidad (sujeto ?nombre)(interes ?appname)(valor ?afinidad))
	(object (OBJECT ?usuario)(is-a Usuario)(Nombre ?nombre))
	(app (id ?appname)(profit ?profit))
	(object (OBJECT ?app)(is-a ?profit)(Nombre ?appname))
	?recomendacion <- (object (is-a Recomendacion)(app_recomendada ?app)(recomendada_a ?usuario)(afinidad ?old_afinidad))
	(test (not (= ?afinidad ?old_afinidad))) ; Controla bucles infinitos
	=>
	(slot-set ?recomendacion afinidad ?afinidad))

(reset)
