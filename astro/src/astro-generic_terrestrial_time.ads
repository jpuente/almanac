-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  This package provides conversion functioins for terrestrial time.--
--                                                                   --
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Astro.Generic_Julian_Time;

generic
   type Real is digits <>;
package Astro.Generic_Terrestrial_Time is

   --  Julian time notation is used for all time scales
   package Julian_Time is new Astro.Generic_Julian_Time (Real);
   use Julian_Time;

   ---------------------------
   --  Conversion functions --
   ---------------------------

   function UT1 (UTC : Date) return Date;
   --  UT1 from UTC

   function TT (UTC : Date) return Date;
   --  Terrestrial time from UTC

   function UTC (TT : Date) return Date;
   --  UTC from terrestrial time

end Astro.Generic_Terrestrial_Time;