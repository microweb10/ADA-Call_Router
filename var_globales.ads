with adagraph; use adagraph;

package var_globales is

   subtype T_numero_max_usuario is integer range 1..16;
   subtype T_numero_telefono is integer range 961..965;
   subtype T_duracion_llamada is integer range 1..10;
   
  -- Duración de la llamada: tiene que ser un puntero para pasarla como parámetro --
  type P_dur is access Duration;  

---------------
-- Usuarios  --
---------------

type T_usuario is record
   id: integer;
   estado: Color_type;    --Light_Gray: no está; Green: llamando; Red : esperando
   x, y: integer; 
   numero: integer;       -- número al que llama
   dur: duration;         --duración de la llamada
   presente : boolean;
end record;

type T_lista_usuarios is array(T_numero_max_usuario) of T_usuario;
type T_lista_usu_presentes is array(T_numero_max_usuario) of boolean;

procedure inicializar_usuarios(usuarios: in out T_lista_usuarios);


protected p_usuario is
   -- crea un nuevo usuario si este no existe   
   procedure Nuevo_Usuario(id,tlfno,dur: integer ;usuarios: in out T_lista_usuarios ;exito: in out boolean);
end p_usuario;


type T_router is record
   estado: Color_type;   --Light_Gray: en espera; Yellow: activo
   texto: String(1..15);
   x, y: integer;        --esquina superior izquierda
end record;

-------------
-- Router  --
-------------

procedure inicializar_router(router: in out T_router);



------------------------
-- Lineas de telefono --
------------------------

type T_telefono is record
   id: integer;           -- 1: para el 961; ... 5: Para el 965;
   numero: String(1..3);
   estado: Color_type;    -- Green: libre; Red: ocupado;
   x,y: integer;          -- extremo izquierdo de la línea de la llamada  
end record;     

type T_lista_tlfno is array(1..5) of T_telefono;

procedure inicializar_telefonos(telefonos: in out T_lista_tlfno);

 
  
----------------------------------------------------
-- Tipo mensaje a dejar en el contestador         --
----------------------------------------------------
  
type Mensaje is record
     id: integer;       -- usuario que deja el mensaje
     numero: integer;   -- número al que llama
     dur: duration;     -- duración del mensaje
end record;
  
type T_lista_mensajes is array(1..5) of Mensaje;


---------------------------------------
-- Declaración de variables globales --
---------------------------------------

   usuarios      : T_lista_usuarios;
   router        : T_router;
   telefonos     : T_lista_tlfno;
   finalizado    : integer;


end var_globales;