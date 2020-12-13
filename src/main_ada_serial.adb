-- File	: main_ada_serial.adb
-- Date	: Sat 12 Dec 2020 01:32:03 PM +08
-- Env	: Linux HPEliteBook8470p-Ub2004-rt38 5.4.66-rt38 
-- #1 SMP PREEMPT_RT Sat Sep 26 16:51:59 +08 2020 x86_64 x86_64 x86_64 GNU/Linux
-- Author: WRY wruslandr@gmail.com
-- ========================================================
-- GNAT Studio Community 2020 (20200427) hosted on x86_64-pc-linux-gnu
-- GNAT 9.3.1 targetting x86_64-linux-gnu
-- SPARK Community 2020 (20200818)

-- ADA STANDARD PACKAGES
with Ada.Text_IO;
with Interfaces.C; 
use  Interfaces.C; 
with Interfaces.C.Extensions;
use  Interfaces.C.Extensions;

-- WRY CREATED PACKAGES 
with pkg_ada_dtstamp;
-- with pkg_ada_serial; 

procedure main_ada_serial is
   
-- RENAMING PACKAGES FOR CONVENIENCE
   package ATIO    renames Ada.Text_IO;
   package IFaceC  renames Interfaces.C;
   package IFaceCE renames Interfaces.C.Extensions;
   
   package PADTS   renames pkg_ada_dtstamp;
   -- package PASER renames pkg_ada_serial; 
   
-- IMPORTANT NOTE:   
-- ALL INITIALIZATIONS ARE SET TO 999 BECAUSE ALMOST ALL 
-- FUNCTION CALLS RETURN 0 FOR SUCCESS. SO IF FUNCTION CALLS 
-- ARE EXECUTED, THE RETURN VALUES MUST CHANGE FROM 999, WHETHER
-- RETURNS ARE SUCCESSFUL OR NOT. HA HA HA.

-- VARIABLES USED FOR PACKAGE Interfaces.C	    
   
     
begin
   
-- INITIALIZE INTEGER RETURN VALUES FOR ADA_PPDEV (IOCTL) FUNCTION CALLS   
           
   PADTS.dtstamp; ATIO.Put_Line ("Bismillah 3 times WRY");
   PADTS.dtstamp; ATIO.Put_Line ("Running inside GNAT Studio Community (20200427)");
   -- =====================================================  
  
   
   ATIO.New_Line;
   ATIO.Put_Line ("USING INTERFACE API ada_serial.c AND ada_serial.h "); 
   ATIO.Put_Line ("=================================================");     
   
   
 
   -- =====================================================      
   ATIO.New_Line;
   PADTS.dtstamp; ATiO.Put_Line ("Alhamdulillah 3 times WRY");
   
-- Catch every possible error using built-in package Ada.Standard
exception
	when Constraint_Error =>
		ATIO.Put_Line("Constraint_Error raised.");
	when Program_Error =>
		ATIO.Put_Line("Program_Error raised.");
	when Storage_Error =>
		ATIO.Put_Line("Storage_Error raised.");
	when Tasking_Error =>
		ATIO.Put_Line("Task_Error raised.");
	when Others =>
       ATIO.Put_Line("Others raised. Unknown error.");
      
  -- null;
end main_ada_serial;

