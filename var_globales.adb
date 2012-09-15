with adagraph; use adagraph;

package body var_globales is
 
   ------------------------------------------------------------------
   -- Para cada usuario, inicializa:
   -- su identificador (id)
   -- su estado (Light_Gray, que significa ausente)
   -- sus coordenadas x,y (coor_x y coor_y)   
   ------------------------------------------------------------------
   procedure inicializar_usuarios(usuarios:in out T_lista_usuarios) is
   x,y: integer; 
   begin
     x:=100;
     y:=20; 
     for i in 1..16 loop 
       usuarios(i).id:=i;
       usuarios(i).estado:= Light_Gray;
       usuarios(i).x:=x;
       usuarios(i).y:=y;
       usuarios(i).presente:=false;
       y:=y+35;        
     end loop;             
   end;
   
   
   protected body p_usuario is
   
      -- crea un nuevo usuario si este no existe
      procedure Nuevo_Usuario(id,tlfno,dur: integer ;usuarios: in out T_lista_usuarios ;exito: in out boolean) is
      begin
         if(usuarios(id).presente=false) then
            usuarios(id).presente:=true;
            usuarios(id).numero:=tlfno;
            usuarios(id).dur:=duration(dur);
            exito:=true;            
         else
            exito:=false;
         end if;
      end Nuevo_Usuario;
      
   end p_usuario;
   
   
   procedure inicializar_router(router: in out T_router) is
   begin
     router.estado:= Light_Gray;
     router.x:=250;
     router.y:=150;
     router.texto:= "  En espera!!  "; 
   end;
   
   
   procedure inicializar_telefonos(telefonos: in out T_lista_tlfno) is
   x,y: integer;
   numeros: array(1..5) of string(1..3):=("961","962","963","964","965");
   begin
     x:=401+25;
     y:=150+20;
     for i in 1..5 loop 
       telefonos(i).id:=i;
       telefonos(i).estado:=Light_Green;  -- libre
       telefonos(i).x:=x;
       telefonos(i).y:=y;
       telefonos(i).numero:=numeros(i);          
       y:=y+30;        
     end loop;
   end;    
   
end var_globales;