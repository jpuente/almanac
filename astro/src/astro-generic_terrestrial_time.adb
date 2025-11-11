-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  This package provides conversion functioins for terrestrial time.--
--                                                                   --
--  Source: IERS Bulletin A                                          --
--                                                                   --
--                                                                   --
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
--  with Astro.Generic_Julian_Time;

package body Astro.Generic_Terrestrial_Time is

   --  package Julian renames Julian_Time;

   Day_Duration : constant Real := 86_400.0;

   -----------------
   --  Parameters --
   -----------------

   --  Difference TAI - UTC (leap seconds)
   --  Beginning 1 January 2017 at 0000 UTC
   --  Check with IERS Bulletin A for possible changes
   LS  : constant Real := 37.000;  -- s

   --  Difference UT1 - UTC
   --  Beginning 10 July 2025 at 0000 UTC
   --  Check with IERS Bulletin A for possible changes
   DUT1 : constant Real := +0.1;   -- s

   --  Difference TT - TAI
   DTT  : constant Real := 32.184; -- s

   -----------
   --  UT1  --
   -----------

   function UT1 (UTC : Date) return Date is
   begin
      return UTC + DUT1 / Day_Duration;
   end UT1;

   ----------
   --  TT  --
   ----------

   function TT (UTC : Date) return Date is
   begin
      return UTC + LS / Day_Duration + DTT / Day_Duration;
   end TT;

   -----------
   --  UTC  --
   -----------

   function UTC (TT : Date) return Date is
   begin
      return TT - LS / Day_Duration - DTT / Day_Duration;
   end UTC;

end Astro.Generic_Terrestrial_Time;