with dibujar;
with var_globales;
with Control;
with procesos;


procedure main is
   
   
   -- ******** Declaración de variables GLOBALES *********
      id_usuario: integer;
      max_usuarios: integer;
      vaciar: integer;

-- *********************** CUERPO PRINCIPAL ************************

begin
   var_globales.finalizado:=0;
   control.Establecer_maximo_usuarios(max_usuarios);
   control.Establecer_tiempo_vaciar_contestador(vaciar);
   
   var_globales.inicializar_usuarios(var_globales.usuarios);
   var_globales.inicializar_router(var_globales.router);
   Var_Globales.Inicializar_Telefonos(Var_Globales.Telefonos);
   
   procesos.Crear_Router;
   procesos.Inicializar_Telefonos;
   procesos.Inicializar_Contestadores;
   procesos.Inicializar_Vacia_Contestadores(vaciar);
   
   dibujar.DibujarTodo(var_globales.router,var_globales.usuarios,var_globales.telefonos);
   
   for i in 1..100 loop
      control.Generar_Usuario(max_usuarios,var_globales.usuarios,id_usuario);
      procesos.Crear_Usuario(id_usuario,var_globales.usuarios(id_usuario).numero,var_globales.usuarios(id_usuario).dur);
      delay(1.0);
   end loop;
   var_globales.finalizado:=1;
      
   delay(9.0);
   dibujar.Kill_Display;

end main;