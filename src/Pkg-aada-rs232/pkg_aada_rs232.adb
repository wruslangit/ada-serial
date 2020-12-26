
package body pkg_aada_rs232 is

-- ========================================================
-- (01) OPEN PARPORT
-- ========================================================
  function GetA_open_parport(port : in AIFaceC.char_array; fd : in AIFaceC.int) return AIFaceC.int is
  begin

      
	     
      -- fd := 1;

    return(fd);
  end GetA_open_parport;
   
   
   
   -- =====================================================
   -- (24)
   -- =====================================================
  --  function GetA_close_parport(fd : in AIFaceC.int) return AIFaceC.int is
  --  begin

  --  ret24 := PAPPDEV.GetC_ada_ioctl_close_parport(fd);
  --  if (ret24 /= 0) then
--	  AATIO.Put ("ERROR. CLOSE PARPORT: ret24 = ");
--		  AATIO.Put (AIFaceC.int'Image(ret24)); AATIO.New_Line;
	   -- end if;

      -- return ret24;
   -- end GetA_close_parport;
   -- =====================================================
  

  -- ======================================================
  begin

    null;
   -- =====================================================
end pkg_aada_rs232;

