-- File: pkg_ada_dtstamp.ads
-- Date: Sun 20 Dec 2020 10:34:19 AM +08
-- Author: WRY
-- Version: 1.2 Fri 30 Oct 2020 10:17:22 AM +08

with Ada.Real_Time;         use Ada.Real_Time;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package pkg_ada_dtstamp is
   
   package AART renames Ada.Real_Time;
   package AASU renames Ada.Strings.Unbounded;

   procedure dtstamp;
   function  get_datestamp (RTNow : in AART.Time) return AASU.Unbounded_String;
   function  get_timestamp (RTNow : in AART.Time) return AASU.Unbounded_String;
   
   procedure RTdelay_sec  (sec  : in Positive);
   procedure RTdelay_msec (msec : in Positive);
   procedure RTdelay_usec (usec : in Positive);
   procedure RTdelay_nsec (nsec : in Positive);

   procedure looptest10_RTdelay_sec (sec  : in Positive);
   procedure looptest10_RTdelay_msec(msec : in Positive);
   procedure looptest10_RTdelay_usec(usec : in Positive);
   procedure looptest10_RTdelay_nsec(nsec : in Positive);

end pkg_ada_dtstamp;

