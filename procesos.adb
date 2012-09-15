with var_globales;
with dibujar;
with control;
with gnat.io;
with Ada.Exceptions;


package body procesos is
   
   
   -- *** Tipo Tarea Telefono (servidor) ***
   task body Telefono is
   
   -- variables del Telefono
   id    : integer;   -- identificador de telefono (1 para 961 - 5 para 965)
   
   begin
      id := identificador;
      loop
         select
            accept Establecer_Llamada(num: var_globales.T_numero_telefono; dur: duration; usuario: var_globales.T_numero_max_usuario) do
               dibujar.T.Dibujar_Telefono(var_globales.telefonos,id,usuario);
               for i in 1..integer(dur) loop
                  Dibujar.U.Dibujar_Usuario (Var_Globales.Usuarios,usuario,Var_Globales.Usuarios(usuario).Estado,1);
                  Var_Globales.Usuarios(usuario).dur := Var_Globales.Usuarios(usuario).dur - 1.0;
                  delay(1.0);
               end loop;
               dibujar.T.Dibujar_Telefono(var_globales.telefonos,id,0);
               control.Finalizar_Usuario(var_globales.usuarios,usuario);
            end Establecer_Llamada;
         or
              terminate;
         end select;
      end loop;
   end Telefono;
   
   
   -- inicializa las tareas telefono
   procedure Inicializar_Telefonos is
   begin
      for i in 1..5 loop 
         telefonos(i) := new Telefono(i);
      end loop; 
   end Inicializar_Telefonos;
   

   -- inicializa una tarea router
   procedure Crear_Router is
   begin
      Routter := new Router;
   end Crear_Router;
     
     
   -- *** Tipo Tarea Router (cliente) ***
   task body Router is   
   begin
      loop
         select
            accept Enrutar(num: var_globales.T_numero_telefono; dur: duration; usuario: var_globales.T_numero_max_usuario) do
               requeue telefonos(num-960).Establecer_Llamada with abort;        
            end Enrutar;
         or
            terminate;
         end select;
      end loop;
              
   end Router;



   
      -- inicializa una tarea usuario
   procedure Crear_Usuario(identificador, numero_tlfno: integer; duracion_llamada: duration) is
      Usu: Usuario_Ptr;
      Dur: var_globales.P_Dur;
   begin
      Dur := new duration;
      Dur.all :=duracion_llamada;
      Usu := new Usuario(identificador, numero_tlfno, Dur);
   end Crear_Usuario;
     
     
   -- *** Tipo Tarea Usuario (cliente) ***
   task body Usuario is
   -- variables del Usuario
   id    : var_globales.T_numero_max_usuario;  -- numero de usuario
   num   : var_globales.T_numero_telefono;     -- numero de telefono al que llama
   dur   : duration;                           -- duracion de la llamada
   
   begin
      id  := identificador;
      num := numero_tlfno;
      dur := duracion_llamada.all;
            select
               Routter.Enrutar(num,dur,id);
            or
               delay(3.0);
               select
                  contestadores(num-960).Dejar_Mensaje(id,num-960,dur);
               else
                  control.Finalizar_Usuario(var_globales.usuarios,id);
               end select;
            end select;   
      exception when event: others =>
         gnat.io.put_line("Mensaje de Excepcion: " & ada.Exceptions.exception_message(event));
         
   end Usuario;
   
   
      -- *** Tipo Tarea Contestador (servidor) ***
   task body Contestador is
   
   -- variables del Contestador
   id       : integer;                       -- identificador de Contestador (1 para 961 - 5 para 965)
   mensajes : var_globales.T_lista_mensajes; -- mensajes que contiene el contestador
   num_mens : integer;                       -- numero de mensajes en el contestador
   
   begin
      id := identificador;
      num_mens := 0;
      loop
         select
            accept Dejar_Mensaje(usuario, num: integer; duracion: duration) do
               if(num_mens < 5) then
                  num_mens := num_mens+1;
                  mensajes(num_mens).id     := usuario; 
                  mensajes(num_mens).numero := num;
                  mensajes(num_mens).dur    := duracion;
                  dibujar.C.dibujar_contestador(var_globales.telefonos,id,num_mens,0);
               end if;
               control.Finalizar_Usuario(var_globales.usuarios,usuario);
            end Dejar_Mensaje;
         or
            accept Vaciar_Mensajes do
               num_mens:=0;
               dibujar.C.dibujar_contestador(var_globales.telefonos,id,num_mens,0);
            end Vaciar_Mensajes;
         or
              terminate;
         end select;
      end loop;
   end Contestador;
   
   
   -- inicializa las tareas contestador
   procedure Inicializar_Contestadores is
   begin
      for i in 1..5 loop 
         contestadores(i) := new Contestador(i);
      end loop; 
   end Inicializar_Contestadores;
   
   
   -- inicializa las tareas Vacia_Contestadores
   procedure Inicializar_Vacia_Contestadores(time: integer) is
   begin
      for i in 1..5 loop
         Vacia_Contest(i):=new Vacia_Contestadores(i,time);
      end loop;
   end Inicializar_Vacia_Contestadores;
   
   -- *** Tipo Tarea Vacia_Contestadores (cliente) ***
   task body Vacia_Contestadores is
      tiempo_vaciar : integer;
      Ide : Integer;   
   begin
      tiempo_vaciar := tiempo;
      Ide := Iden;
      loop
         delay duration(tiempo_vaciar);
         select
            Contestadores(ide).Vaciar_Mensajes;
         or
            delay(0.2);
         end select;
      exit when var_globales.finalizado=1;
      end loop;
   end Vacia_Contestadores;
   
end procesos;


