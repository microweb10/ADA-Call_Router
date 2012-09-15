with adagraph; use adagraph;
with var_globales; use var_globales;

package Dibujar is
       
   -- Inicializa la pantalla
   procedure Init_Display;

   -- Cierra la pantalla;
   procedure Kill_Display;
   
   -- Dibuja el router;
   procedure Dibujar_Router(r: T_router; color: Color_Type; texto: String);

 protected T is
   
   -- Dibuja la línea de teléfono número id de un cierto color y muestra el id del usuario que está llamando (user)
   procedure Dibujar_telefono(l_tlfno: T_lista_tlfno; id:integer; user:integer);

 end T;

 protected C is
   -- Dibuja el contestador de una determinada línea de telefono id y muestra el número de mensajes almacenados
   procedure dibujar_contestador(l_tlfno: T_lista_tlfno; id:integer; num_mensajes: integer; modo: integer);
   
 end C;  
 
   -- Dibuja el router, usuarios y lineas de telefono
   procedure DibujarTodo(r: T_router; usuarios: T_lista_usuarios; telefonos: T_lista_tlfno);

   -- Muestra el tiempo que se va consumiendo en la llamada
   procedure Dibujar_tiempo(l_usu: T_lista_usuarios; id:integer; t: duration);


 protected U is

   -- Dibuja un usuario de la lista de usuarios un cierto color
   -- Si line=0 borramos la línea al router, si line=1 la dibujamos
   procedure Dibujar_Usuario (l_usu: T_lista_usuarios; id:integer; color: Color_type;line: integer);
   
   procedure Dibujar_Estado_Usuario(l_usu: T_lista_usuarios; id:integer; color : Color_Type);
 
 end U;

private
   X_Size : constant Integer := 750;    -- Horizontal window size
   Y_Size : constant Integer := 600;    -- Vertical window size

   X_Max,  Y_Max  : Integer;  -- Maximum screen coordinates
   X_Char, Y_Char : Integer;  -- Character size
   
   --tipo para convertir un duration a un escalar   
   type escalar is delta 0.1 range 0.0 .. 25.0;
      
end Dibujar;
