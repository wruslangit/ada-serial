-- File   : main_ada_plplot.adb
-- Date   : Wed 30 Dec 2020 01:52:41 PM +08
-- Env	   : Linux HPEliteBook8470p-Ub2004-rt38 5.4.66-rt38
-- #1 SMP PREEMPT_RT Sat Sep 26 16:51:59 +08 2020 x86_64 x86_64 x86_64 GNU/Linux
-- Author: WRY wruslandr@gmail.com
-- ========================================================
-- GNAT Studio Community 2020 (20200427) hosted on x86_64-pc-linux-gnu
-- GNAT 9.3.1 targetting x86_64-linux-gnu
-- SPARK Community 2020 (20200818)
--
--
-- ==========================================================
-- ADA STANDARD PACKAGES
with Ada.Text_IO;

-- USER CREATED PACKAGES
with pkg_ada_dtstamp;
with pkg_plplot_auxiliary;
with pkg_plplot_standard;
with pkg_plplot_thin;
with pkg_plplot_traditional;

-- ========================================================
procedure main_ada_plplot is
-- ========================================================
   package ATIO    renames Ada.Text_IO;
   
   package PADTS     renames pkg_ada_dtstamp;
   package PPLAUX    renames pkg_plplot_auxiliary;
   package PPLSTD    renames pkg_plplot_standard;
   package PPLTHN    renames pkg_plplot_thin;
   package PPLTRD    renames pkg_plplot_traditional;
      
   
   
begin

   PADTS.dtstamp; ATIO.Put_Line ("Bismillah 3 times WRY");
   PADTS.dtstamp; ATIO.Put_Line ("Started main_ada_plplot.adb program.");
   ATIO.New_Line;
   -- =====================================================
   
      
   -- =====================================================   
   ATIO.New_Line;
   PADTS.dtstamp; ATIO.Put_Line ("Ended main_ada_plplot.adb program.");
   PADTS.dtstamp; ATIO.Put_Line ("Alhamdulillah 3 times WRY");

-- ========================================================
end main_ada_plplot;
-- ========================================================

