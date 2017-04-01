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

(reset)
