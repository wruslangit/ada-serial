
-- ==========================================================

-- ADA STANDARD PACKAGES
with Ada.Text_IO;
with GNAT.Serial_Communications;

-- USER CREATED PACKAGES
with pkg_ada_dtstamp;

-- ========================================================
procedure main_ada_serial_port is

   package ATIO  renames Ada.Text_IO;
   package GSC   renames GNAT.Serial_Communications;
   package PADTS renames pkg_ada_dtstamp;
   
   type Byte is mod 2**8;
   type Byte_Array is array (Natural range <>) of Byte;

   package Byte_IO is
      new ATIO.Modular_IO (Byte);

   SPort_1 : aliased GSC.Serial_Port;
   SPort_2 : aliased GSC.Serial_Port;

   End_Token : constant := 16#FF#;

   Buffer_Out : Byte_Array (0 .. 8) := (0, 1, 2, 3, 4, 5, 6, 7, End_Token);
   Buffer_In  : Byte;

begin

   PADTS.dtstamp;
   ATIO.Put_Line ("Bismillah 3 times WRY");
 
   -- Open the ports.
   GSC.Open (SPort_1, "/dev/ttyS0");  -- SUCCESS MOTHERBOARD SERIAL PORT
   GSC.Open (SPort_2, "/dev/ttyS4");  -- SUCCESS MOTHERBOARD SERIAL PORT

   -- GSC.Open (SPort_1, "/dev/ttyUSB0");  -- SUCCESS USB-to-Serial cable
   -- GSC.Open (SPort_2, "/dev/ttyUSB1");  -- SUCCESS USB-to-Serial cable

   --  Write the byte array (packet) to port 1 in one go.
   Byte_Array'Write (SPort_1'Access, Buffer_Out);

   PADTS.dtstamp; ATIO.Put_Line ("Begin loop ");
   --  Read the byte array (packet) back from port 2, byte-by-byte.
   loop
   
      Byte'Read (SPort_2'Access, Buffer_In);
      exit when Buffer_In = End_Token;

      Byte_IO.Put (Buffer_In); ATIO.Put (" "); 

      PADTS.dtstamp; ATIO.Put_Line ("Inside the loop");
      
   end loop;
   
   PADTS.dtstamp; ATIO.Put_Line ("End loop.");

   --  Close the ports.
   GSC.Close (SPort_1);
   GSC.Close (SPort_2);

   PADTS.dtstamp; ATIO.Put_Line ("Alhamdulillah 3 times WRY");

end main_ada_serial_port;
-- ================================================

