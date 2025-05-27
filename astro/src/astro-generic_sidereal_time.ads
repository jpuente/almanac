-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  This package provides abstractions for sidereal time.            --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Generic_Real_Arrays;

with Astro.Generic_Julian_Time;
with Astro.Generic_Frame_Transformations;

generic

   type Real is digits <>;

   with package Real_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Real);
   with package Real_Arrays is
     new Ada.Numerics.Generic_Real_Arrays (Real);
   with package Julian_Time is
     new Astro.Generic_Julian_Time (Real);
   with package Frame_Transformations is
     new Astro.Generic_Frame_Transformations
       (Real, Real_Functions, Real_Arrays, Julian_Time);

package Astro.Generic_Sidereal_Time is
   --  Julian dates are assumed to be UTC

   subtype Time is Real range 0.0 .. 86_400.0;
   --  Sidereal time in seconds. Equals the number of seconds elapsed since
   --  the transit of the vernal point (Aries).

   function GMST (JD : Julian_Time.Date) return Time;
   --  Greenwich Mean Sidereal Time in seconds.

   function GAST  (JD : Julian_Time.Date) return Time;
   --  Greenwich Apparent Sidereal Time in seconds.

end Astro.Generic_Sidereal_Time;
