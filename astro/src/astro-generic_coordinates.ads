-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- Root package for  oordinates.                                     --
--                                                                   --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Generic_Real_Arrays;

generic
   type Real is digits <>;
package Astro.Generic_Coordinates is

   package Real_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Real);
   package Real_Arrays is
     new Ada.Numerics.Generic_Real_Arrays (Real);

   subtype Degrees is Real;
   subtype Hours   is Real;

end Astro.Generic_Coordinates;