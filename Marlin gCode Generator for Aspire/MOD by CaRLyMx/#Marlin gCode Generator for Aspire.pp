+===========================================================+
+                                                			+
+ 			Marlin gCode Generator for Vectric Aspire		+
+						'CaRLyMx MOD'						+
+   						GitHub:							+
+ https://github.com/carlymx/Marlin-gCode-Generator-Aspire	+
+                                                			+
+===========================================================+
+           
+ Versión: 12052019-001
+                                    
+ History:                                        
+                                                
+ Who    	When       	What                         
+ ======== 	========== 	===========================================================
+	MikeK	13/12/2015	Written   
+	JohnP	02/03/2017	Added multi-tool with pause 
+	CaRLyMx	08/05/2019	Todos los movimientos con 'G0' (consumen menos memoria)
+						Modificado el comando 'begin HEADER'
+			09/05/2019	Añadido en 'begin HEADER':
+						Pausas G4 para poder encender el Spindle Motor
+						Mensajes en Pantalla
+			10/05/2019	Cambio de Herramienta 'begin TOOLCHANGE' Mas Completo
+			20/05/2019	Al finalizar un trabajo suenan unos tonos
+			28/05/2019	Modificado los 'G0 Z10' y 'G92 Z10' de 'begin HEADER' y 'begin TOOLCHANGE' por 'G0 [SAFEZ]' y 'G92 [SAFEZ]'
+							*Así, se permite variar la altura de zona segura desde el programa.
+
+==================================================================================

POST_NAME = "Marlin [CaRLyMx MOD] (mm) (*.gcode)"

FILE_EXTENSION = "gcode"

UNITS = "MM"

+------------------------------------------------
+    Line terminating characters                 
+------------------------------------------------

LINE_ENDING = "[13][10]"

+------------------------------------------------
+    Block numbering                             
+------------------------------------------------

LINE_NUMBER_START     = 0
LINE_NUMBER_INCREMENT = 10
LINE_NUMBER_MAXIMUM = 999999

+================================================
+                                                
+    Formating for variables                     
+                                                
+================================================

VAR LINE_NUMBER = [N|A|N|1.0]
VAR SPINDLE_SPEED = [S|A|S|1.0]
VAR FEED_RATE = [F|C|F|1.1]
VAR X_POSITION = [X|C|X|1.3]
VAR Y_POSITION = [Y|C|Y|1.3]
VAR Z_POSITION = [Z|C|Z|1.3]
VAR X_HOME_POSITION = [XH|A|X|1.3]
VAR Y_HOME_POSITION = [YH|A|Y|1.3]
VAR Z_HOME_POSITION = [ZH|A|Z|1.3]

+================================================
+                                                
+    Block definitions for toolpath output       
+                                                
+================================================

+---------------------------------------------------
+  Commands output at the start of the file
+---------------------------------------------------

begin HEADER

"; *************************************"
"; **            PROYECTO             **"
"; *************************************"
"; [TP_FILENAME]"
"; Safe Z height: [SAFEZ]"
"; Tools: [TOOLS_USED]"
"; Notes: [FILE_NOTES]"
"; Generated [DATE] [TIME]"
"; Tool [T]: [TOOLNAME]"
"; Path: [TOOLPATH_NAME] [PATHNAME]"
"; [TOOLPATH_NOTES]"
" "
"; *************************************"
"; **           INICIO GCODE          **"
"; *************************************"
" "
" "
"G90 		; Coordenadas en Posiciones absolutas."
"G21 		; Unidades en Milimetros."
";M84 	; Apagar Motores Paso a paso."
";M03 S12000 ; Iniciar Spindle Motor."
" "
"G0 [SAFEZ] 	; Subir Z para ir a Origen y que no rasque la broca el material"
"G28 X Y		; Ir a Origen X Y"
"G92 [SAFEZ]	; Marcar Punto CERO a Z=[SAFEZ]"
"M117 ENCIENDA EL SPINDLE Motor	; MENSAJE"
"G4 S5			; Hace Una Pausa de 5 Segundos para poder encender el motor manualmente"
" "
" "
"; *************************************"
"; **         INICIO DE CORTE         **"
"; *************************************"
" "
"M117 EN PROCESO...	; MENSAJE"
";-----> "

+---------------------------------------------------
+  Commands output for rapid moves 
+---------------------------------------------------

begin RAPID_MOVE

"G0 [X] [Y] [Z]"


+---------------------------------------------------
+  Commands output for the first feed rate move
+---------------------------------------------------

begin FIRST_FEED_MOVE

"G0 [X] [Y] [Z] [F]"


+---------------------------------------------------
+  Commands output for feed rate moves
+---------------------------------------------------

begin FEED_MOVE

"G0 [X] [Y] [Z]"

+---------------------------------------------------
+  Commands output for tool changes
+---------------------------------------------------

begin TOOLCHANGE

"; +++++++++++++++++++++++++++++++++++++++++++++++++++"
"; +				CAMBIO DE HERRAMIENTA				+"
"; +													+"
"; + 		Tool [T]: [TOOLNAME]		+"
"; +++++++++++++++++++++++++++++++++++++++++++++++++++"
" "
" "
"; ---> Para la Maquina y Cambia Heramienta:"
"G0 [SAFEZ]			; Subir Z para cambiar de herramienta"
"M05				; Para el Spindle Motor"
"M84 				; Apagar Motores Paso a paso."
"M300 S2349 P60		; Tono Musical"
"M300 S2349 P460	; Tono Musical"
" "
"; ---> Prepara Origen Z:"
"M117 CAMBIE HER. Y BUSQUE EL ORIGEN Z"
"M25		; Hace una Pausa"
" "
"; ---> Busca el Origen XY y encienda el Spindle Motor"
"M03 S12000 	; Iniciar Spindle Motor." 
"G0 [SAFEZ]		; Subir Z para ir a Origen y que no rasque la broca el material"
"G28 X Y		; Ir a Origen X Y"
"G92 [SAFEZ]	; Marcar Punto CERO a Z=[SAFEZ]"
"M117 ENCIENDA EL SPINDLE Motor	; MENSAJE"
"G4 S5			; Hace Una Pausa de 5 Segundos para poder encender el motor manualmente"
" "
" "
"; ---> Inicia Proceso:"
"M117 EN PROCESO..."
" "


+---------------------------------------------------
+  Commands output for toolpath changes
+---------------------------------------------------

begin NEW_SEGMENT

"; Path: [TOOLPATH_NAME] [PATHNAME]"
"; [TOOLPATH_NOTES]"
"M03 [S]"


+---------------------------------------------------
+  Commands output at the end of the file
+---------------------------------------------------

begin FOOTER

"G0 [SAFEZ] ;goto safe z"
"M300 S2349 P60		; Tono Musical"
"M300 S2349 P460	; Tono Musical"
"M300 S2349 P60		; Tono Musical"
"M300 S2349 P460	; Tono Musical"
"M300 S2349 P60		; Tono Musical"
"M300 S2349 P460	; Tono Musical"
"M117 TERMINADO!"
