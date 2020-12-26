with Ada.Text_IO;
with Interfaces.C; use  Interfaces.C;
with Interfaces.C.Extensions; use  Interfaces.C.Extensions;

with pkg_ada_rs232;  -- THe C-CODE INTERFACED TO ADA SPECIFICATIONS

package pkg_aada_rs232 is
-- ========================================================

   package AATIO    renames Ada.Text_IO;
   package AIFaceC  renames Interfaces.C;
   package AIFaceCE renames Interfaces.C.Extensions;

   package PARS232 renames pkg_ada_rs232;

   
   


-- LIST OF FUNCTIONS FOR ADA_PPDEV
-- ========================================================
   -- (1) to (2)
   function GetA_open_parport (port : in AIFaceC.char_array; fd : in AIFaceC.int) return AIFaceC.int;
   -- function GetA_ppclaim_parport (fd : in AIFaceC.int) return AIFaceC.int;

   
   -- (23) to (24)
   -- function GetA_pprelease_parport return AIFaceC.int;
   -- function GetA_close_parport (fd : in AIFaceC.int) return AIFaceC.int;
   

-- ========================================================
end pkg_aada_rs232;

