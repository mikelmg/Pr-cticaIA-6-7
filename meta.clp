; Cargar --> (batch "meta.clp")

(mapclass App)
(mapclass gratis)
(mapclass pago)
(mapclass suscripcion)
(mapclass freemium)

(defrule asdassdas
?app <-(app (id ?id)(categoria ?cat)(profit ?profit)(edad ?edad)(so ?so))
=>
(make-instance of ?profit (Nombre ?id)(Categorias ?cat)(edad_recomendada ?edad)(Sistema_operativo Android))
)

