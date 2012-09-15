with var_globales;


package procesos is  


-- *** Tipo Tarea Telefono (servidor) ***
task type Telefono(identificador: Integer) is
   entry Establecer_Llamada(num: var_globales.T_numero_telefono; dur: duration; usuario: var_globales.T_numero_max_usuario);
end Telefono;
type Telefono_Ptr is access Telefono;
type Lista_Telefonos is array(1..5) of Telefono_Ptr;
-- inicializa las tareas telefono
procedure Inicializar_Telefonos;


-- *** Tipo Tarea Router (servidor) ***
task type Router is
   entry Enrutar(num: var_globales.T_numero_telefono; Dur: Duration; Usuario: Var_Globales.T_Numero_Max_Usuario);
end Router;
type Router_Ptr is access Router;
-- inicializa una tarea router
procedure Crear_Router;


-- *** Tipo Tarea Usuario (cliente) ***
task type Usuario(identificador, numero_tlfno: Integer; duracion_llamada: var_globales.P_Dur);
type Usuario_Ptr is access Usuario;
-- inicializa una tarea usuario
procedure Crear_Usuario(identificador, numero_tlfno: integer; duracion_llamada: duration);


-- *** Tipo Tarea Contestador (servidor) ***
task type Contestador(identificador: Integer) is
   entry Dejar_Mensaje(usuario,num: integer; duracion: duration);
   entry Vaciar_Mensajes;
end Contestador;
type Contestador_Ptr is access Contestador;
type Lista_Contestadores is array(1..5) of Contestador_Ptr;
-- inicializa las tareas contestador
procedure Inicializar_Contestadores;


-- *** Tipo Tarea Vacia_Contestadores (cliente) ***
task type Vacia_Contestadores(iden,tiempo: integer); 
type Vacia_Contestadores_Ptr is access Vacia_Contestadores;
type Lista_Vacia_Contestadores is array(1..5) of Vacia_Contestadores_Ptr;
-- inicializa las tareas Vacia_Contestadores
procedure Inicializar_Vacia_Contestadores(time: integer);


--- variables globales ---
telefonos     : Lista_Telefonos;
Contestadores : Lista_Contestadores;
Vacia_Contest : Lista_Vacia_Contestadores;
Routter       : Router_Ptr;

end procesos;