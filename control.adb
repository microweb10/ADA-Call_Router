with var_globales;
with dibujar;
with gnat.io;
with Ada.Numerics.Discrete_Random;


package body control is

   
   --establece cual sera el maximo de usuarios en el sistema
   procedure Establecer_maximo_usuarios(max: in out integer) is
   begin
      gnat.io.put_line("Escribe el numero maximo de usuarios que quieres que tenga el sistema (debe estar entre 1 y 16)");
      gnat.io.get(max);
      if(max<1 or max>16) then
         loop
            gnat.io.put_line("NUMERO INCORRECTO (debe estar entre 1 y 16) INTRODUZCA OTRO");
            gnat.io.get(max);
            exit when (max>=1 and max<=16);
         end loop;
      end if;
   end Establecer_maximo_usuarios;
   
   
   --establece cada cuantos segundos sera vaciado el contestador
   procedure Establecer_tiempo_vaciar_contestador(vaciar: in out integer) is
   begin
      gnat.io.put_line("Escribe cada cuantos segundos quieres que se vacie el contestador (debe ser un valor positivo)");
      gnat.io.get(vaciar);
      if(vaciar<1) then
         loop
            gnat.io.put_line("NUMERO INCORRECTO (debe ser un valor positivo) INTRODUZCA OTRO");
            gnat.io.get(vaciar);
            exit when (vaciar>=1);
         end loop;
      end if;
   end Establecer_tiempo_vaciar_contestador;
   

   -- crea un nuevo usuario que no exista
   procedure generar_usuario(max_usuarios: integer; usuarios: in out var_globales.T_lista_usuarios ; id: in out integer) is
        subtype T_max_usuario is integer range 1..max_usuarios;
        package Numeros_Aleatorios_Id_Usuario is
                new Ada.Numerics.Discrete_Random(T_max_usuario);
        Generador_Id_Usuario: Numeros_Aleatorios_Id_Usuario.Generator;
        
        package Numeros_Aleatorios_Tlfno_Usuario is
                new Ada.Numerics.Discrete_Random(var_globales.T_numero_telefono);
        Generador_Tlfno_Usuario: Numeros_Aleatorios_Tlfno_Usuario.Generator;
        
        package Numeros_Aleatorios_Dur_Usuario is
                new Ada.Numerics.Discrete_Random(var_globales.T_duracion_llamada);
        Generador_Dur_Usuario: Numeros_Aleatorios_Dur_Usuario.Generator;
        
        exito : boolean;
        num,dur : integer;
   begin
      exito := false;
      Numeros_Aleatorios_Tlfno_Usuario.Reset(Generador_Tlfno_Usuario);
      num := Numeros_Aleatorios_Tlfno_Usuario.Random(Generador_Tlfno_Usuario);
      Numeros_Aleatorios_Dur_Usuario.Reset(Generador_Dur_Usuario);
      dur := Numeros_Aleatorios_Dur_Usuario.Random(Generador_Dur_Usuario);
      
      loop
         Numeros_Aleatorios_Id_Usuario.Reset(Generador_Id_Usuario);
         id := Numeros_Aleatorios_Id_Usuario.Random(Generador_Id_Usuario);
         var_globales.p_usuario.Nuevo_Usuario(id,num,dur,usuarios,exito);
         exit when exito=true;
      end loop;
      
      dibujar.U.Dibujar_Usuario(usuarios,id,usuarios(id).estado,2);
      
   end Generar_Usuario;

   
   -- finaliza un usuario
   procedure Finalizar_Usuario(usuarios:in out var_globales.T_lista_usuarios ; id: in integer) is
   begin
      usuarios(id).presente := false;
      dibujar.U.Dibujar_Usuario(usuarios,id,usuarios(id).estado,0);
   end Finalizar_Usuario;
   
end control;


