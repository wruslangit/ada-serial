-- File: pkg_ada_dtstamp.ads
-- Date: Fri 30 Oct 2020 01:13:48 AM +08
-- Author: WRY
-- Version: 1.2 Fri 30 Oct 2020 10:17:22 AM +08

package pkg_ada_dtstamp is

   procedure dtstamp;

   procedure RTdelay_sec  (sec  : in Positive);
   procedure RTdelay_msec (msec : in Positive);
   procedure RTdelay_usec (usec : in Positive);
   procedure RTdelay_nsec (nsec : in Positive);

   procedure test_RTdelay_sec (sec  : in Positive);
   procedure test_RTdelay_msec(msec : in Positive);
   procedure test_RTdelay_usec(usec : in Positive);
   procedure test_RTdelay_nsec(nsec : in Positive);

end pkg_ada_dtstamp;

