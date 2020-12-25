-- File   : pkg_ada_rs232.ads
-- Date   : Thu 24 Dec 2020 12:04:15 PM +08
-- Env	   : Linux HPEliteBook8470p-Ub2004-rt38 5.4.66-rt38
-- #1 SMP PREEMPT_RT Sat Sep 26 16:51:59 +08 2020 x86_64 x86_64 x86_64 GNU/Linux
-- Author: WRY wruslandr@gmail.com
-- ========================================================
-- GNAT Studio Community 2020 (20200427) hosted on x86_64-pc-linux-gnu
-- GNAT 9.3.1 targetting x86_64-linux-gnu
-- SPARK Community 2020 (20200818)
--
-- ==========================================================
with Interfaces.C;
with Interfaces.C.Extensions;

-- TO INTERFACE TO C, just create the spec ads file, not the adb file, 
-- Otherwise, we have an infinite recursion. Just spec and no body.

-- ========================================================
package pkg_ada_rs232 is

   package IFaceC  renames Interfaces.C; 
   package IFaceCE renames Interfaces.C.Extensions;
   
   -- Aspect specification only (ads file) and not body (adb file).
   -- Convention used in this specification
   -- (1) For Ada to call void C-function, use "ExeC_" as prefix 
   -- (2) For Ada to call return-value C-function, use "GetC_" prefix.
 
 -- SECTION ON ADA INTERFACE TO C-PROCEDURES 
 -- ======================================================
 
 -- void current_working_directory(void)  
 procedure ExeC_ada_current_working_directory
     with Import => True, Convention => C,
     External_Name => "current_working_directory";    
 
 -- void display_date_only(void)  
 procedure ExeC_ada_display_date_only
     with Import => True, Convention => C,
     External_Name => "display_date_only";    
 
 -- void crs232_chars_put(int serialdev_num, const char *the_chars);
 procedure ExeC_adars232_chars_put(dev_num : in IFaceC.int; the_chars : IFaceC.char_array) 
     with Import => True, Convention => C,
     External_Name => "crs232_chars_put";    
   
 -- void crs232_enable_DTR(int serialdev_num);
 procedure ExeC_adars232_enable_DTR(dev_num : in IFaceC.int) 
     with Import => True, Convention => C,
     External_Name => "crs232_enable_DTR";      
    
-- void crs232_disable_DTR(int serialdev_num);
procedure ExeC_adars232_disable_DTR(dev_num : in IFaceC.int) 
     with Import => True, Convention => C,
     External_Name => "crs232_disable_DTR";      

-- void crs232_enable_RTS(int serialdev_num);
procedure ExeC_adars232_enable_RTS(dev_num : in IFaceC.int) 
     with Import => True, Convention => C,
     External_Name => "crs232_enable_RTS";    
   
-- void crs232_disable_RTS(int serialdev_num);
procedure ExeC_adars232_disable_RTS(dev_num : in IFaceC.int) 
     with Import => True, Convention => C,
     External_Name => "crs232_disable_RTS";    
   
-- void crs232_flush_RX(int serialdev_num);
procedure ExeC_adars232_flush_RX(dev_num : in IFaceC.int) 
     with Import => True, Convention => C,
     External_Name => "crs232_flush_RX";    
   
   -- void crs232_flush_TX(int serialdev_num);
procedure ExeC_adars232_flush_TX(dev_num : in IFaceC.int) 
     with Import => True, Convention => C,
     External_Name => "crs232_flush_TX";    
   
-- void crs232_flush_RXTX(int serialdev_num);
procedure ExeC_adars232_flush_RXTX(dev_num : in IFaceC.int) 
     with Import => True, Convention => C,
     External_Name => "crs232_flush_RXTX";    
   
-- void crs232_close_device(int serialdev_num);   
procedure ExeC_adars232_close_device(dev_num : in IFaceC.int) 
     with Import => True, Convention => C,
     External_Name => "crs232_close_device";       
  
   
-- SECTION ON ADA INTERFACE TO C-FUNCTIONS
-- =====================================================
 
-- int crs232_open_device(int serialdev_num, int baudrate, const char *mode, int flowctrl);
function GetC_adars232_open_device(dev_num, baudrate : in IFaceC.int; mode : in IfaceC.char_array; flowctrl : in IFaceC.int) return IFaceC.int    
     with Import => True, Convention => C, 
     External_Name => "crs232_open_device";   

-- int crs232_poll_device(int serialdev_num, unsigned char *buffer, int size);
function GetC_adars232_poll_device(dev_num : in IFaceC.int; buffer : in IfaceC.char_array; size : in IFaceC.int) return IFaceC.int    
     with Import => True, Convention => C, 
     External_Name => "crs232_poll_device";   
   
-- int crs232_send_byte(int serialdev_num, unsigned char byte);
function GetC_adars232_send_byte(dev_num : in IFaceC.int; byte : in IfaceC.unsigned_char) return IFaceC.int    
     with Import => True, Convention => C, 
     External_Name => "crs232_send_byte";   
   
-- int crs232_send_buffer(int serialdev_num, unsigned char *buffer, int size);
function GetC_adars232_send_buffer(dev_num : in IFaceC.int; buffer : in IfaceC.char_array; size : in IFaceC.int) return IFaceC.int    
     with Import => True, Convention => C, 
     External_Name => "crs232_send_buffer";  
   
-- int crs232_isDCD_enabled(int serialdev_num);
function GetC_adars232_isDCD_enabled(dev_num : in IFaceC.int) return IFaceC.int    
     with Import => True, Convention => C, 
     External_Name => "crs232_isDCD_enabled";   
   
-- int crs232_isRING_enabled(int serialdev_num);
function GetC_adars232_isRING_enabled(dev_num : in IFaceC.int) return IFaceC.int    
     with Import => True, Convention => C, 
     External_Name => "crs232_isRING_enabled";   
   
-- int crs232_isCTS_enabled(int serialdev_num);
function GetC_adars232_isCTS_enabled(dev_num : in IFaceC.int) return IFaceC.int    
     with Import => True, Convention => C, 
     External_Name => "crs232_isCTS_enabled";   
   
-- int crs232_isDSR_enabled(int serialdev_num);
function GetC_adars232_isDSR_enabled(dev_num : in IFaceC.int) return IFaceC.int    
     with Import => True, Convention => C, 
     External_Name => "crs232_isDSR_enabled";   
   
-- int crs232_Get_Device_Number(const char *dev_string);  
function GetC_adars232_Get_Device_Number(dev_string : in IFaceC.char_array) return IFaceC.int    
     with Import => True, Convention => C, 
     External_Name => "crs232_Get_Device_Number";      
   

-- ========================================================      
end pkg_ada_rs232;
 
