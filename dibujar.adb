package body Dibujar is

   --------------------------
   -- Inicializar pantalla --
   --------------------------   
   procedure Init_Display is
   begin
      Create_Sized_Graph_Window (X_Size, Y_Size, X_Max, Y_Max, X_Char, Y_Char);
      Set_Window_Title ("ROUTER TELEFONICO");
      Clear_Window (White);
   end Init_Display;




protected body U is
  ----------------------------------------------------------------     
  -- Dibuja el usuario id de la lista l_usu, del color color    --
  -- dibuja la línea si line=1, si line=0 o line=3 la borra     --
  -- si line=2 significa que el usuario aun no ha sido atendido --
  ----------------------------------------------------------------
  procedure Dibujar_Usuario (l_usu: T_lista_usuarios; id:integer; color: Color_type; line: integer) is
  dur: escalar;
  begin
    --la cara
    Draw_Circle(l_usu(id).x, l_usu(id).y,15,color,Fill);
    --los ojos
    Draw_Circle(l_usu(id).x-4,l_usu(id).y-3,2,Black,Fill);
    Draw_Circle(l_usu(id).x+4,l_usu(id).y-3,2,Black,Fill);
    --la boca
    Draw_Line(l_usu(id).x-8,l_usu(id).y+6,l_usu(id).x+8,l_usu(id).y+6,Black);

    -- el id 
    Display_Text(l_usu(id).x+10, l_usu(id).y-5, integer'image(id), Black); 

       
    case line is
      when 1 =>  -- el usuario es atendido
         Dibujar_Estado_Usuario(l_usu, id, Light_Green);
         --Borramos el texto anterior
         Draw_Box(l_usu(id).x-100, l_usu(id).y-5,l_usu(id).x-16, l_usu(id).y-5+13,White,Fill);  
         dur:=escalar(l_usu(id).dur);
         --Mostramos el número y la duración de la llamada
         Display_Text(l_usu(id).x-100, l_usu(id).y-5, integer'image(l_usu(id).numero) & "-" & escalar'image(dur),Black); 

      when 2 =>  -- el usuario esta esperando (como maximo esperara 3 seg)
         Dibujar_Estado_Usuario(l_usu, id, Light_Red);
         --Borramos el texto anterior
         Draw_Box(l_usu(id).x-100, l_usu(id).y-5,l_usu(id).x-16, l_usu(id).y-5+13,White,Fill);  
         dur:=escalar(l_usu(id).dur);
         --Mostramos el número y la duración de la llamada
         Display_Text(l_usu(id).x-100, l_usu(id).y-5, integer'image(l_usu(id).numero) & "-" & escalar'image(dur),Black); 

      when 0 => -- el usuario termina de hablar normalmente
         Draw_Line(l_usu(id).x+15,l_usu(id).y, 249,150+90+((id-7)*15),White);
         Draw_Box(l_usu(id).x-100, l_usu(id).y-5,l_usu(id).x-16, l_usu(id).y-5+13,White,Fill);      
         
      when 3 => -- el usuario se cansa de esperar
         Draw_Line(l_usu(id).x+15,l_usu(id).y, 249,150+90+((id-7)*15),White);
         Draw_Box(l_usu(id).x-100, l_usu(id).y-5,l_usu(id).x-16, l_usu(id).y-5+13,White,Fill);      
      when others => null;
    end case;
      
  end Dibujar_usuario;
  
  
    -- Dibuja el estado de un usuario mediante un color determinado
  procedure Dibujar_Estado_Usuario(l_usu: T_lista_usuarios; id:integer; color: Color_Type) is
  begin
    Draw_Line(l_usu(id).x+15,l_usu(id).y, 249,150+90+((id-7)*15),color);
    --la cara
    Draw_Circle(l_usu(id).x, l_usu(id).y,15,color,Fill);
    --los ojos
    Draw_Circle(l_usu(id).x-4,l_usu(id).y-3,2,Black,Fill);
    Draw_Circle(l_usu(id).x+4,l_usu(id).y-3,2,Black,Fill);
    --la boca
    Draw_Line(l_usu(id).x-8,l_usu(id).y+6,l_usu(id).x+8,l_usu(id).y+6,Black);
  end;
  
  
end U;


  -------------------------------------------------
  --  Dibuja el router en la pantalla            --
  -------------------------------------------------
  procedure Dibujar_Router(r: T_router; color: Color_type; texto: String) is
  begin
     Draw_Box(r.x,r.y,r.x+150,r.y+230,color,Fill);
     Draw_Box(r.x,r.y,r.x+150,r.y+230,Black,No_Fill);
     Draw_Box(r.x+1,r.y+1,r.x+150-1,r.y+230-1,Black,No_Fill);

     Display_Text(r.x+15,r.y+100,"  R O U T E R  ",Black); 
     Display_Text(r.x+15,r.y+115,texto,Black);

  end;
  

  protected body T is
  ---------------------------------------------------------------------
  -- Dibuja la línea de telefono número id de un cierto color        --
  -- user = 0 => linea libre, Green                                  --
  -- user <> 0 => linea ocupada, Red                                 --  
  ---------------------------------------------------------------------
  procedure Dibujar_telefono(l_tlfno: T_lista_tlfno; id:integer; user:integer) is
  color: Color_Type;
  begin
     if user = 0 
        then color:= Green; 
        else color:= Light_Red; 
     end if;
     Draw_Line(l_tlfno(id).x, l_tlfno(id).y+(id*15), l_tlfno(id).x + 140, l_tlfno(id).y+(id*15), color);
     Draw_Box(l_tlfno(id).x + 140, l_tlfno(id).y+(id*15)-15, l_tlfno(id).x + 140+60, l_tlfno(id).y+(id*15)+15, color,No_Fill);
     Draw_Box(l_tlfno(id).x+1 + 140, l_tlfno(id).y+1+(id*15)-15, l_tlfno(id).x-1 + 140+60, l_tlfno(id).y-1+(id*15)+15, color,No_Fill);
     Display_Text(l_tlfno(id).x + 140+10, l_tlfno(id).y+(id*15),l_tlfno(id).numero,Black);
     if user = 0
       then
         --Borramos el texto anterior
         Draw_Box(L_Tlfno(Id).X+10,L_Tlfno(Id).Y+(Id*15)-13-13,L_Tlfno(Id).X+10+128,L_Tlfno(Id).Y+(Id*15)-13+11,White,Fill);
         --Escribimos el texto
         Display_Text(l_tlfno(id).x +10, l_tlfno(id).y+(id*15)-20,"Linea libre ("&integer'image(user)&")",color);
       else 
         --Borramos el texto anterior
         Draw_Box(l_tlfno(id).x+10,l_tlfno(id).y+(id*15)-13-13,l_tlfno(id).x+10+128,l_tlfno(id).y+(id*15)-13+11,White,Fill);
         --Escribimos el texto
         Display_Text(l_tlfno(id).x +10, l_tlfno(id).y+(id*15)-20,"Ocupada ("&integer'image(user)&")",color);
     end if;               
      
  end;

 end T;


 protected body C is
   -- Dibuja el contestador de una determinada línea de voz id y muestra el número de mensajes almacenados
   procedure dibujar_contestador(l_tlfno: T_lista_tlfno; id:integer; num_mensajes: integer; modo: integer) is
   colorB,colorF: Color_Type;
   begin
     -- incializamos el color del contestador
     case num_mensajes is
       when 0..4 => -- contestador no lleno
          colorB:= Green; colorF:= Light_Green;
       when 5 =>    -- contestador lleno
          colorB:= Red; colorF:= Light_Red;
       when others => null;
     end case;
     if modo=1 then
        colorB:= Black; colorF:= Yellow;
     end if;
     --Dibujamos el contestador
     Draw_Box(l_tlfno(id).x + 140+75, l_tlfno(id).y+(id*15)-15, l_tlfno(id).x + 140+75+50, l_tlfno(id).y+(id*15)+15, colorB,No_Fill);
     Draw_Box(l_tlfno(id).x+1 + 140+75, l_tlfno(id).y+1+(id*15)-15, l_tlfno(id).x-1 + 140+75+50, l_tlfno(id).y-1+(id*15)+15, colorB,No_Fill);
     Draw_Box(l_tlfno(id).x+1+1 + 140+75, l_tlfno(id).y+1+1+(id*15)-15, l_tlfno(id).x-1 + 140+75+50, l_tlfno(id).y-1-1+(id*15)+15, colorF,Fill);
     Display_Text(l_tlfno(id).x + 140+75+10, l_tlfno(id).y+(id*15),integer'image(num_mensajes),Black);
   end;

 end C;


  -----------------------------------------------------------------------
  -- Dibuja en la pantalla el router, los usuarios y las líneas de     -- 
  -- telefonos                                                         --
  -----------------------------------------------------------------------
  
  procedure DibujarTodo(r: T_router; usuarios: T_lista_usuarios; telefonos: T_lista_tlfno) is
  begin
    dibujar_router(r,Light_Gray,"  En espera!!  ");

    delay 0.5;

    --creamos los 16 usuarios listos para llamar    
    for i in 1..16 loop
      U.dibujar_usuario(usuarios,i,Light_Gray,0);
    end loop;   
   
    delay 0.5;
  
     -- dibujamos las lineas de teléfono y los contestadores
     for i in 1..5 loop
       T.dibujar_telefono(telefonos,i,0);
       C.dibujar_contestador(telefonos,i,0,0);
     end loop;   

   end DibujarTodo;


   -- Muestra el tiempo que se va consumiendo en la llamada
   procedure Dibujar_tiempo(l_usu: T_lista_usuarios; id:integer; t: duration) is
   te: escalar;   
   begin
     --borramos el texto anterior
     Draw_Box(l_usu(id).x-100, l_usu(id).y-5,l_usu(id).x-16, l_usu(id).y-5+13,White,Fill); 
     --mostramos el tiempo
     te:=escalar(t);
     Display_Text(l_usu(id).x-100, l_usu(id).y-5, integer'image(l_usu(id).numero) & "-" & escalar'image(te),Black); 

     if t = 0.0 then      
        --borramos el texto anterior
        Draw_Box(l_usu(id).x-100, l_usu(id).y-5,l_usu(id).x-16, l_usu(id).y-5+13,White,Fill); 
     end if;
   end;


   ----------------------
   -- Cerrar pantalla  --
   ----------------------
   procedure Kill_Display is
   begin
      Display_text(310,570,"Programa finalizado con éxito",Light_Blue);
      delay 3.0;
      Destroy_Graph_Window;
   end Kill_Display;
      
begin
   Init_Display;
end Dibujar;
