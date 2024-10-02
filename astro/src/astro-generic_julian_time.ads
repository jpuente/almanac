-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  This package provides abstractions for Julian time.              --
-----------------------------------------------------------------------
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with Ada.Calendar;

generic
   type Real is digits <>;
package Astro.Generic_Julian_Time is
   --  Julian time is counted in days from noon on January 1, 4713 BC.
   --  This way of counting time was proposed by J. J. Scaliger
   --  in 1583 and is commonly used in astronomical calculations.

   subtype Date is Real range 0.0 .. 3_000_000.0;

   Epoch : constant Date := 2_451_545.0;   -- J2000.0 epoch

   --  J2000.0 is the julian date 2451545.0 TT (Terrestrial Time),
   --          or 1st January 2000, noon TT
   --          (equivalent to 1st January 2000 11:58:55.816 UTC)

   function Date_Of (T : Ada.Calendar.Time) return Date;
   function Time_Of (D : Date) return Ada.Calendar.Time;
   --  Ada.Calendar.Time is assumed to be UTC

end Astro.Generic_Julian_Time;
