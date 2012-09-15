with var_globales;


package control is  

--establece cual sera el maximo de usuarios en el sistema
procedure Establecer_maximo_usuarios(max: in out integer);

--establece cada cuantos segundos sera vaciado el contestador
procedure Establecer_tiempo_vaciar_contestador(vaciar: in out integer);

-- genera un nuevo usuario
procedure Generar_Usuario(max_usuarios: integer; usuarios: in out var_globales.T_lista_usuarios ; id: in out integer);

-- finaliza un usuario
procedure Finalizar_Usuario(usuarios:in out var_globales.T_lista_usuarios ; id: in integer);


end control;