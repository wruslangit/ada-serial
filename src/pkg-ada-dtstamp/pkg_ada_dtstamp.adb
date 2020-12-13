-- File   : pkg_ada_dtstamp.adb
-- Date	: Sat 07 Nov 2020 06:25:35 AM +08
-- Env	   : Linux HPEliteBook8470p-Ub2004-rt38 5.4.66-rt38
-- #1 SMP PREEMPT_RT Sat Sep 26 16:51:59 +08 2020 x86_64 x86_64 x86_64 GNU/Linux
-- Author: WRY
-- ========================================================
-- GNAT Studio Community 2020 (20200427) hosted on x86_64-pc-linux-gnu
-- GNAT 9.3.1 targetting x86_64-linux-gnu
-- SPARK Community 2020 (20200818)

with Ada.Text_IO;
with Ada.Calendar;
with Ada.Calendar.Formatting;
with Ada.Real_Time; use Ada.Real_Time;  -- NOTICE THIS use

package body pkg_ada_dtstamp is

    package ATIO   renames Ada.Text_IO;
    package ACal   renames Ada.Calendar;
    package ACalF  renames Ada.Calendar.Formatting;
    package ART    renames Ada.Real_Time;

    -- ALL REQUIRED FOR INITIALIZATION ONLY
     sec_RTInterval  : ART.Time_Span  := ART.Seconds(1);
    msec_RTInterval  : ART.Time_Span  := ART.Milliseconds(1);
    usec_RTInterval  : ART.Time_Span  := ART.Microseconds(1);
    nsec_RTInterval  : ART.Time_Span  := ART.Nanoseconds (1);
    RTNext	         : ART.Time       := ART.Clock;

    -- DEFINE INTERNAL FUNCTION ===========================
    function GetTime(RTNow : ART.Time) return String is
	Seconds  : ART.Seconds_Count;
	Fraction : ART.Time_Span;
    begin
	ART.Split(RTNow, Seconds, Fraction);
            declare
            -- Duration is defined in Standard package.
	    TFraction : constant String := Duration'Image(ART.To_Duration(Fraction));
	    begin
	       -- return TFraction(4..TFraction'Last-2); -- Try 1, 2 and 3 slicing
	       return TFraction(4..TFraction'Last);
	    end;
    end GetTime; -- FUNCTION END

    -- DEFINE PROCEDURE ===================================
    procedure dtstamp is
    begin
 	-- Display date and time
        ATIO.Put( ACal.Formatting.Image(ACal.Clock,True, 0) );
        -- Display RT Clock Time in seconds and in fractions
        ATIO.Put(GetTime(ART.Clock) & " ");
	     -- ATIO.New_Line;
   end dtstamp;

   procedure RTdelay_sec (sec : in Positive) is
   begin
      sec_RTInterval := ART.Seconds(sec);
      RTNext := ART.Clock;
      RTNext := RTNext + sec_RTInterval;
      delay until RTNext;
   end RTdelay_sec;

   procedure RTdelay_msec (msec : in Positive) is
   begin
      msec_RTInterval := ART.Milliseconds(msec);
      RTNext := ART.Clock;
      RTNext := RTNext + msec_RTInterval;
      delay until RTNext;
   end RTdelay_msec;

   procedure RTdelay_usec (usec : in Positive) is
   begin
      usec_RTInterval := ART.Microseconds(usec);
      RTNext := ART.Clock;
      RTNext := RTNext + usec_RTInterval;
      delay until RTNext;
   end RTdelay_usec;

   procedure RTdelay_nsec (nsec : in Positive) is
   begin
      nsec_RTInterval := ART.Nanoseconds(nsec);
      RTNext := ART.Clock;
      RTNext := RTNext + nsec_RTInterval;
      delay until RTNext;
   end RTdelay_nsec;

    procedure test_dtstamp_sec is
    begin
        RTNext	:= ART.Clock;
        for idx in 1..10 loop
         -- Display date and time
         ATIO.Put( ACal.Formatting.Image(ACal.Clock,True, 0) );
         -- Display RT Clock Time in seconds and in fractions
         ATIO.Put( GetTime(ART.Clock) ); ATIO.New_Line;
         RTNext := RTNext + sec_RTInterval;
            delay until RTNext;
        end loop;
    end test_dtstamp_sec;

    -- (1) SET SEC DELAY INPUT ============================
    procedure test_RTdelay_sec(sec : in Positive) is
    begin
	ATIO.Put_Line("Test RTdelay execution: " & sec'Image & " seconds delay loop.");
    	sec_RTInterval := ART.Seconds(sec);
        RTNext := ART.Clock;
        for idx in 1..10 loop
 	    -- Display date and time
	    ATIO.Put( ACal.Formatting.Image(ACal.Clock,True, 0) );
	    -- Display RT Clock Time in seconds and in fractions
	    ATIO.Put( GetTime(ART.Clock) ); ATIO.New_Line;
	    RTNext := RTNext + sec_RTInterval;
            delay until RTNext;
        end loop;
    end test_RTdelay_sec;

    -- (2) SET MSEC DELAY INPUT ===========================
    procedure test_RTdelay_msec(msec : in Positive) is
    begin
	ATIO.Put_Line("Test RTdelay execution: " & msec'Image & " milliseconds delay loop.");
    	msec_RTInterval := ART.Milliseconds(msec);
        RTNext := ART.Clock;
        for idx in 1..10 loop
 	    -- Display date and time
	    ATIO.Put( ACal.Formatting.Image(ACal.Clock,True, 0) );
	    -- Display RT Clock Time in seconds and in fractions
	    ATIO.Put( GetTime(ART.Clock) ); ATIO.New_Line;
	    RTNext := RTNext + msec_RTInterval;
            delay until RTNext;
        end loop;
    end test_RTdelay_msec;

    -- (3) SET USEC DELAY INPUT ===========================
    procedure test_RTdelay_usec(usec : in Positive) is
    begin
 	ATIO.Put_Line("Test RTdelay execution: " & usec'Image & " microseconds delay loop.");
    	usec_RTInterval := ART.Microseconds(usec);
        RTNext := ART.Clock;
        for idx in 1..10 loop
 	    -- Display date and time
	    ATIO.Put( ACal.Formatting.Image(ACal.Clock,True, 0) );
	    -- Display RT Clock Time in seconds and in fractions
	    ATIO.Put( GetTime(ART.Clock) ); ATIO.New_Line;
	    RTNext := RTNext + usec_RTInterval;
            delay until RTNext;
        end loop;
    end test_RTdelay_usec;

    -- (4) SET NSEC DELAY INPUT ===========================
    procedure test_RTdelay_nsec(nsec : in Positive) is
    begin
 	ATIO.Put_Line("Test execution: " & nsec'Image & " nanoseconds delay loop.");
    	nsec_RTInterval := ART.Nanoseconds(nsec);
        RTNext := ART.Clock;
        for idx in 1..10 loop
 	    -- Display date and time
	    ATIO.Put( ACal.Formatting.Image(ACal.Clock,True, 0) );
	    -- Display RT Clock Time in seconds and in fractions
	    ATIO.Put( GetTime(ART.Clock) ); ATIO.New_Line;
	    RTNext := RTNext + nsec_RTInterval;
            delay until RTNext;
        end loop;
    end test_RTdelay_nsec;

-- ========================================================
begin
    null;

end pkg_ada_dtstamp;

