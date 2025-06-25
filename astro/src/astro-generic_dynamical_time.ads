-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  This package provides conversion functions between               --
--  barycentric dynamical time (TDB and terrestrial time (TT)        --
--                                                                   --
--  Copyright (C) 2025 Juan A. de la Puente                          --
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

   function TT (TDB : Date) return Date;
   --  Terrestrial time from barycenctric dynamical time

   function TDB (TT : Date) return Date;
   --  Barycentric dynamical time from terrestrial time.

end Astro.Generic_Dynamical_Time;