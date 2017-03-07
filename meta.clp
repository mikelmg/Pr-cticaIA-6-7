(mapclass App)

(defrule asdassdas
?app <-(app (id ?id)(categoria ?cat)(profit ?profit)(edad ?edad)(so ?so))
=>
(make-instance of ?profit (Nombre ?id)(Categoria ?cat)(Edad_minima_recomendada ?edad)(Sistema_operativo ?so))
)


