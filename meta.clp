; Cargar --> (batch "meta.clp")

(mapclass App)
(mapclass gratis)
(mapclass pago)
(mapclass suscripcion)
(mapclass freemium)

(mapclass Desarrollador)
(mapclass Usuario)

(defrule load-app-existing-dev
	(app (id ?id)(categoria ?cat)(profit ?profit)(edad ?edad)(so ?so)(dev ?devname))
	?dev <- (object (is-a Desarrollador) (Nombre ?devname))
	; Si no insertamos esta aplicación anteriormente
	(not (object (is-a ?profit) (Nombre ?id)))
	=>
	(printout t "Aplicación " ?id " cargada " crlf)
	(make-instance of ?profit
		(Nombre ?id)
		(Categorias ?cat)
		(edad_recomendada ?edad)
		(Sistema_operativo (if (= (mod (random) 2) 0) then Android else iOS))
		(descargas (* 100 (random)))
		(Puntuacion (float (mod (random) 6)))
		(desarrollador ?dev)))

(defrule create-non-existing-dev
	?app <-(app (dev ?devname))
	(not (object (is-a Desarrollador) (Nombre ?devname)))
	(not (test (= ?devname nil)))
	=>
	(make-instance of Desarrollador (Nombre ?devname)))

(defrule get-protege-user-input
	?usuario <- (object (is-a Usuario)
		(Nombre ?nombre)
		(Edad ?edad)
		(Genero ?genero)
		(Nacionalidad ?nacionalidad))
	=>
	(assert (usuario
		(nombre ?nombre)
		(edad ?edad)
		(genero ?genero)
		(nacionalidad ?nacionalidad))))

(defrule return-recomendaciones
	(afinidad (sujeto ?nombre)(interes ?appname)(valor ?afinidad))
	(app (id ?appname)(profit ?profit))
	?usuario <- (object (is-a Usuario)
		(Nombre ?nombre)
		(Edad ?edad)
		(Genero ?genero)
		(Nacionalidad ?nacionalidad))
	?app <- (object (is-a ?profit) (Nombre ?appname))
	(not (done app_recommended ?appname))
	=>
	; TODO esperar a que termine afinidad
	(assert (done app_recommended ?appname))
	(printout t ?nombre " " ?appname " " ?afinidad crlf)
	(slot-insert$ ?usuario recomendaciones 1 ?app)
	)


;(defrule imprimir-afinidades-only
;	(afinidad (sujeto ?s) (interes ?app) (valor ?v))
;	=> (printout t ?s " + " ?app " = " ?v crlf))

(reset)
