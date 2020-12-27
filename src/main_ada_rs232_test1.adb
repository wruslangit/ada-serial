-- File   : main_ada_rs232_test1.adb
-- Date   : Thu 24 Dec 2020 12:04:15 PM +08
-- Env	   : Linux HPEliteBook8470p-Ub2004-rt38 5.4.66-rt38
-- #1 SMP PREEMPT_RT Sat Sep 26 16:51:59 +08 2020 x86_64 x86_64 x86_64 GNU/Linux
-- Author: WRY wruslandr@gmail.com
-- ========================================================
-- GNAT Studio Community 2020 (20200427) hosted on x86_64-pc-linux-gnu
-- GNAT 9.3.1 targetting x86_64-linux-gnu
-- SPARK Community 2020 (20200818)
--
-- http://man7.org/linux/man-pages/man4/tty_ioctl.4.html
-- Constant  Description
-- TIOCM_LE        DSR (data set ready/line enable)
-- TIOCM_DTR       DTR (data terminal ready)
-- TIOCM_RTS       RTS (request to send)
-- TIOCM_ST        Secondary TXD (transmit)
-- TIOCM_SR        Secondary RXD (receive)
-- TIOCM_CTS       CTS (clear to send)
-- TIOCM_CAR       DCD (data carrier detect)
-- TIOCM_CD        see TIOCM_CAR
-- TIOCM_RNG       RNG (ring)
-- TIOCM_RI        see TIOCM_RNG
-- TIOCM_DSR       DSR (data set ready)

-- https://www.bb-elec.com/Learning-Center/All-White-Papers/Serial/FAQ-RS-232-Connections-That-Work.aspx

-- Ring Indicator (RI) is a signal sent from the DCE to the DTE device. It indicates to the terminal device that the phone line is ringing.

-- ==========================================================
-- ADA STANDARD PACKAGES
with Ada.Text_IO;
with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions; use Interfaces.c.Extensions;
with Ada.Strings.Unbounded;

-- USER CREATED PACKAGES
with pkg_ada_dtstamp;
with pkg_ada_rs232;
with pkg_aada_rs232;

-- ========================================================
procedure main_ada_rs232_test1 is
-- ========================================================
   package ATIO    renames Ada.Text_IO;
   package IFaceC  renames Interfaces.C; 
   package IFaceCE renames Interfaces.C.Extensions;
   package ASU     renames Ada.Strings.Unbounded;  

   package PADTS     renames pkg_ada_dtstamp;
   package PARS232   renames pkg_ada_rs232;
   package PAARS232  renames pkg_aada_rs232;
   
-- SERIAL DEVICE SETTINGS FOR AVAILABLE HARDWARE
-- dmesg for serial devices
-- [    0.135277] printk: console [tty0] enabled
-- [    1.301387] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
-- [    1.324103] 0000:00:16.3: ttyS4 at I/O 0x4090 (irq = 17, base_baud = 115200) is a 16550A

   -- dev_string    : IFaceC.char_array    := "/dev/ttyS0";
   dev_string    : IFaceC.char_array := "/dev/ttyS4";
  
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
   
   the_chars : IFaceC.char_array := "Bismillah Hirrahma Nirrahim 3 times WRY";
   
   ret_isDCD_enabled  : IFaceC.int := 999;
   ret_isRING_enabled : IFaceC.int := 999;
   ret_isCTS_enabled  : IFaceC.int := 999;
   ret_isDSR_enabled  : IFaceC.int := 999;
   
   ret_read_buffer : IFaceC.int := 999;  -- return value no of bytes read
   ret_send_buffer : IFaceC.int := 999;  -- return value no of bytes read
   ret_send_byte   : IFaceC.int := 999;  -- return value no of bytes sent
      
   the_byte : IFaceC.unsigned_char := 119;  -- ASCII Equivalent = w
   buffer : IFaceC.char_array := "01234567890123456789ABCDEFGH";  
   buffer_size : IFaceC.int  := 25;
   
begin

   PADTS.dtstamp; ATIO.Put_Line ("Bismillah 3 times WRY");
   PADTS.dtstamp; PARS232.ExeC_ada_current_working_directory;
   PADTS.dtstamp; PARS232.ExeC_ada_display_date_only;
   PADTS.dtstamp; ATIO.Put_Line ("Started main_ada_rs232_test1.adb program.");
   ATIO.New_Line;
   
   -- ===================================================== 
   -- TEST NO. 1 GET DEVICE NUMBER FROM INPUT DEVICE STRING
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
   -- TEST NO. 2 OPEN SERIAL DEVICE WITH CORRECT SETTINGS
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
   PADTS.dtstamp; ret_open_device := PARS232.GetC_adars232_open_device(serialdev_num, baudrate, the_mode, flowctrl);
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
   -- TEST NO. 3 
   -- =====================================================
   PADTS.dtstamp; PARS232.ExeC_adars232_enable_DTR(serialdev_num);
   PADTS.dtstamp; PARS232.ExeC_adars232_disable_DTR(serialdev_num);
   PADTS.dtstamp; PARS232.ExeC_adars232_enable_RTS(serialdev_num);
   PADTS.dtstamp; PARS232.ExeC_adars232_disable_RTS(serialdev_num);
   ATIO.New_Line;   
   
   -- =====================================================
   -- TEST NO. 4 
   -- =====================================================   
   PADTS.dtstamp; PARS232.ExeC_adars232_flush_RX(serialdev_num);
   PADTS.dtstamp; PARS232.ExeC_adars232_flush_TX(serialdev_num);
   PADTS.dtstamp; PARS232.ExeC_adars232_flush_RXTX(serialdev_num);
   ATIO.New_Line;   

   -- =====================================================   
   -- TEST NO. 5
   -- =====================================================
   PADTS.dtstamp; ret_isDCD_enabled := PARS232.GetC_adars232_isDCD_enabled(serialdev_num);
   PADTS.dtstamp; ATIO.Put_Line("Data Carrier Detect ret_isDCD_enabled = " & IFaceC.int'Image(ret_isDCD_enabled));
   PADTS.dtstamp; ret_isRING_enabled := PARS232.GetC_adars232_isRING_enabled(serialdev_num);
   PADTS.dtstamp; ATIO.Put_Line("Ringing Indicator ret_isRING_enabled = " & IFaceC.int'Image(ret_isRING_enabled));
   PADTS.dtstamp; ret_isCTS_enabled := PARS232.GetC_adars232_isCTS_enabled(serialdev_num);
   PADTS.dtstamp; ATIO.Put_Line("Clear To Send ret_isCTS_enabled = " & IFaceC.int'Image(ret_isCTS_enabled));
   PADTS.dtstamp; ret_isDSR_enabled := PARS232.GetC_adars232_isDSR_enabled(serialdev_num);
   PADTS.dtstamp; ATIO.Put_Line("Data Set Ready ret_isDSR_enabled = " & IFaceC.int'Image(ret_isDSR_enabled));
   ATIO.New_Line;
      
   -- =====================================================   
   -- TEST NO. 8
   -- =====================================================
   PADTS.dtstamp; ret_send_buffer := PARS232.GetC_adars232_send_buffer(serialdev_num, buffer, buffer_size);
   PADTS.dtstamp; ATIO.Put_Line("ret_send_buffer = " & IFaceC.int'Image(ret_send_buffer));
    
   PADTS.dtstamp; ret_read_buffer := PARS232.GetC_adars232_read_buffer(serialdev_num, buffer, buffer_size);
   PADTS.dtstamp; ATIO.Put_Line("ret_read_buffer = " & IFaceC.int'Image(ret_read_buffer));
   PADTS.dtstamp; ret_send_buffer := PARS232.GetC_adars232_send_buffer(serialdev_num, buffer, buffer_size);
   PADTS.dtstamp; ATIO.Put_Line("ret_send_buffer = " & IFaceC.int'Image(ret_send_buffer));
   PADTS.dtstamp; ret_send_byte := PARS232.GetC_adars232_send_byte(serialdev_num, the_byte);
   PADTS.dtstamp; ATIO.Put_Line("ret_send_byte = " & IFaceC.int'Image(ret_send_byte));
   PADTS.dtstamp; ret_read_buffer := PARS232.GetC_adars232_read_buffer(serialdev_num, buffer, buffer_size);
   PADTS.dtstamp; ATIO.Put_Line("ret_read_buffer = " & IFaceC.int'Image(ret_read_buffer));
   ATIO.New_Line;
   
   -- =====================================================
   -- TEST NO. 6 WRITE A STRING OF CHARACTERS
   -- =====================================================
   PADTS.dtstamp; PARS232.ExeC_adars232_chars_put(serialdev_num, the_chars); 
   ATIO.New_Line;
   
   -- CLOSE SERIAL DEVICE 
   -- =====================================================
   PADTS.dtstamp; PARS232.ExeC_adars232_close_device(serialdev_num); -- WORKS
      
   -- =====================================================   
   ATIO.New_Line;
   PADTS.dtstamp; ATIO.Put_Line ("Ended main_ada_rs232_test1.adb program.");
   PADTS.dtstamp; ATIO.Put_Line ("Alhamdulillah 3 times WRY");

-- ========================================================
end main_ada_rs232_test1;
-- ========================================================

