-- File   : main_ada_rs232.adb
-- Date   : Thu 24 Dec 2020 12:04:15 PM +08
-- Env	   : Linux HPEliteBook8470p-Ub2004-rt38 5.4.66-rt38
-- #1 SMP PREEMPT_RT Sat Sep 26 16:51:59 +08 2020 x86_64 x86_64 x86_64 GNU/Linux
-- Author: WRY wruslandr@gmail.com
-- ========================================================
-- GNAT Studio Community 2020 (20200427) hosted on x86_64-pc-linux-gnu
-- GNAT 9.3.1 targetting x86_64-linux-gnu
-- SPARK Community 2020 (20200818)
--
-- Ada strings are fixed length, meaning that the length of a string NEVER changes.
-- A string variable can only be assigned strings that match its length.
-- Array assignment requires arrays of the same length on both sides.


-- ==========================================================
-- ADA STANDARD PACKAGES
with Ada.Text_IO;
with Interfaces.C;
use  Interfaces.C;
with Interfaces.C.Extensions;
use  Interfaces.c.Extensions;
with Ada.Strings.Unbounded;

-- USER CREATED PACKAGES
with pkg_ada_dtstamp;
with pkg_ada_rs232;

-- ========================================================
procedure main_ada_rs232 is

   package ATIO    renames Ada.Text_IO;
   package IFaceC  renames Interfaces.C; 
   package IFaceCE renames Interfaces.C.Extensions;
   package ASU     renames Ada.Strings.Unbounded;  

   package PADTS    renames pkg_ada_dtstamp;
   package PARS232  renames pkg_ada_rs232;
   
-- SERIAL DEVICE SETTINGS FOR AVAILABLE HARDWARE
-- dmesg for serial devices
-- [    0.135277] printk: console [tty0] enabled
-- [    1.301387] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
-- [    1.324103] 0000:00:16.3: ttyS4 at I/O 0x4090 (irq = 17, base_baud = 115200) is a 16550A

   -- dev_string    : IFaceC.char_array    := "/dev/ttyS0";
   dev_string    : IFaceC.char_array := "/dev/ttyS4";
   -- dev_string    : IFaceC.char_array := "/dev/ttyUSB0"; -- FAILED NO HARDWARE
   -- dev_string    : IFaceC.char_array := "/dev/ttyWRY0"; -- FAILED NO HARDWARE
   
   -- The list of serial devices in Cada_rs232.h maps dev_string (string) to
   -- serialdev_number (integer) for each different serial device.
   -- Using (dev_string), we acquire (serialdev_num) from list of serial devices
   serialdev_num   : IFaceC.int := 999; 
   baudrate        : IFaceC.int := 999;
   the_mode        : IFaceC.char_array := "XXX";  
   flowctrl        : IFaceC.int := 999;
   ret_open_device : IFaceC.int := 999;
   
   -- FOR ADA STRING PRINT MANIPULATION
   -- Introduced because we are interfacing C-code "IFaceC.char_array"
   -- with Ada strings in Ada-code. Ha ha ha.
   -- Where no string initialization is needed, created default empty
   UBdev_string  : ASU.Unbounded_string; 
   UBthe_mode    : ASU.Unbounded_string; 
   
begin

   PADTS.dtstamp; ATIO.Put_Line ("Bismillah 3 times WRY");
   PADTS.dtstamp; PARS232.ExeC_ada_current_working_directory;
   PADTS.dtstamp; PARS232.ExeC_ada_display_date_only;
   PADTS.dtstamp; ATIO.Put_Line ("Started main_ada_rs232.adb program.");
   ATIO.New_Line;
-- ======================================================== 
   
   -- STEP NO. 1 GET DEVICE NUMBER FROM INPUT DEVICE STRING
   -- =====================================================
   -- dev_string : IFaceC.char_array := "/dev/ttyS0"; -- REQUIRED TO BE DEFINED ABOVE
   serialdev_num := PARS232.GetC_adars232_Get_Device_Number(dev_string); 
   if (serialdev_num = 999) then 
      PADTS.dtstamp; ATIO.Put("ERROR: ");
   else 
      PADTS.dtstamp; ATIO.Put("SUCCESS: ");
   end if;
   ATIO.Put_Line ("Acquired serialdev_num = " & IFaceC.int'Image(serialdev_num));
   
   -- =====================================================
   -- STEP NO. 2 OPEN SERIAL DEVICE WITH CORRECT SETTINGS
   -- =====================================================
   -- Trick for Ada printing, set first "to_unbounded_string".
   -- Then to print, convert the "to_unbounded_string" back into "to_string".
   -- Ha ha ha. Done because of Ada interfacing to "IFaceC.char_array" C-code 
   UBdev_string := ASU.To_Unbounded_String("/dev/ttyS4"); -- for printing only
   UBthe_mode   := ASU.To_Unbounded_String("8N1");        -- for printing only
   
   -- HARDWARE DEPENDENT SETTINGS FOR SERIAL DEVICE
   baudrate := 115200;  -- Values = {9600, 19200, 38400, 57600, 115200}
   flowctrl := 0;       -- Values = {0, 1}  
   the_mode := "8N1";   -- Values = {"ABC"} where 
            -- A values = {8, 7, 6, 5} number of bits per character
            -- B values = {N, E, 0) parity bit {None, Even, Odd}
            -- C values = {1, 2} number of stop bits
   
   -- EXECUTE OPEN SERIAL DEVICE      
   ret_open_device := PARS232.GetC_adars232_open_device(serialdev_num, baudrate, the_mode, flowctrl);
   if (ret_open_device = 0) then 
      PADTS.dtstamp; ATIO.Put("SUCCESS: ");
   else 
      PADTS.dtstamp; ATIO.Put("ERROR: ");
   end if;
   ATIO.Put("ret_open_device = " & IFaceC.int'Image(ret_open_device));
   ATIO.Put(" for dev_string = " & ASU.To_String(UBdev_string));
   ATIO.Put(", serialdev_num = " & IFaceC.int'Image(serialdev_num));
   ATIO.Put(", baudrate = "      & IFaceC.int'Image(baudrate));
   ATIO.Put(", mode = "          &  ASU.To_String(UBthe_mode));
   ATIO.Put_Line(", flowctrl = " & IFaceC.int'Image(flowctrl));
   ATIO.New_Line;
  
   -- =====================================================
   -- STEP NO. 3
   -- =====================================================
   
   
   -- =====================================================
   -- STEP NO. 4
   -- =====================================================
   
   
   
   -- STEP NO. 
   -- =====================================================
   PARS232.ExeC_adars232_close_device(serialdev_num); -- WORKS
      
   -- ========================================================   
   ATIO.New_Line;
   PADTS.dtstamp; ATIO.Put_Line ("Ended main_ada_rs232.adb program.");
   PADTS.dtstamp; ATIO.Put_Line ("Alhamdulillah 3 times WRY");

end main_ada_rs232;
-- ================================================
