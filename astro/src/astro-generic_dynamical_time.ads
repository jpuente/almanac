-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  This package provides abstractions for dynamical time.           --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Astro.Generic_Julian_Time;

generic
   type Real is digits <>;

package Astro.Generic_Dynamical_Time is

   package Julian_Time is new Astro.Generic_Julian_Time (Real);
   use Julian_Time;

   ----------------------------
   --  Conversion functions  --
   ----------------------------

   function TT (TU : Date) return Date;
   --  Terrestrial time from UT1

   function TU (TT : Date) return Date;
   --  Universal time (UT1) from terrestrial dynamical time.

   function TDB (TT : Date) return Date;
   --  Barycentric dynamical time from terrestrial dynamical time.

end Astro.Generic_Dynamical_Time;