+================================================
+                                                
+ G Code - Vectric machine output configuration file   
+                                                
+================================================
+                                                
+ History                                        
+                                                
+ Who    When       What                         
+ ======== ========== ===========================
+ MikeK     13/12/2015 Written   
+ JohnP     02/03/2017 Added multi-tool with pause                   
+================================================

POST_NAME = "Marlin (mm) (*.gcode)"

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

"; [TP_FILENAME]"
"; Safe Z height: [SAFEZ]"
"; Tools: [TOOLS_USED]"
"; Notes: [FILE_NOTES]"
"; Generated [DATE] [TIME]"
" "
"G90"
"M84 S0"
"M03 [S]"
"G21"
"G00 X0.000 Y0.000 Z0.000"
"G1 [SAFEZ]"
"G1 [XH] [YH] [F]"
" "
"; Tool [T]: [TOOLNAME]"
"; Path: [TOOLPATH_NAME] [PATHNAME]"
"; [TOOLPATH_NOTES]"


+---------------------------------------------------
+  Commands output for rapid moves 
+---------------------------------------------------

begin RAPID_MOVE

"G0 [X] [Y] [Z]"


+---------------------------------------------------
+  Commands output for the first feed rate move
+---------------------------------------------------

begin FIRST_FEED_MOVE

"G1 [X] [Y] [Z] [F]"


+---------------------------------------------------
+  Commands output for feed rate moves
+---------------------------------------------------

begin FEED_MOVE

"G1 [X] [Y] [Z]"

+---------------------------------------------------
+  Commands output for tool changes
+---------------------------------------------------

begin TOOLCHANGE

"; Tool change:"
"; Tool [T]: [TOOLNAME]"
"M05"
"M25"

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

"G1 [SAFEZ] ;goto safe z"

