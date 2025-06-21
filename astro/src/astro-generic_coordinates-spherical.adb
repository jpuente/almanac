-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- Spherical coordinates.                                            --
--                                                                   --
-- Reference: P.K. Seildemann (ed.), Explanatory Supplement to the   --
-- Astronomical Almanac, ch. 1 and 4 (1992)                          --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
--  with Astro.Generic_Frame_Transformations;
with Astro.Generic_Sidereal_Time;

package body Astro.Generic_Coordinates.Spherical is

   package Sidereal is
      new Astro.Generic_Sidereal_Time (Real);

   ---------------------------
   -- Auxiliary definitions --
   ---------------------------

   subtype Vector2 is Real_Arrays.Real_Vector (1 .. 2);

   --------------------------
   -- Conversion functions --
   --------------------------

   function GHA (RA : Real; TU : Julian.Date)
      return Degrees
   is
      use Sidereal;
      HA : Degrees;
   begin
      HA := (GMST (TU) / 86400.0 - RA / 24.0) * 360.0;
      if HA < 0.0 then
         HA := HA + 360.0;
      end if;
      return HA;
   end GHA;

   function Spherical (U : Vector)
      return Spherical_Coordinates
    is
      XY        : constant Vector2 := U (1 .. 2);
      XY_Module : constant Real := Sqrt (XY * XY);
      P         : Spherical_Coordinates;
   begin
      if XY_Module = 0.0  then
         P.Right_Ascension := 0.0;
         if U (3) = 0.0 then
            P.Declination := 0.0;
         elsif U (3) < 0.0 then
            P.Declination := -90.0;
         else
            P.Declination := +90.0;
         end if;
      else
         P.Right_Ascension := Arctan (U (2), U (1), 24.0);
         if P.Right_Ascension < 0.0 then
            P.Right_Ascension := P.Right_Ascension + 24.0;
         end if;
         P.Declination := Arctan (U (3), XY_Module, 360.0);
      end if;

      P.Distance := Sqrt (U * U);

      return P;
   end Spherical;

end Astro.Generic_Coordinates.Spherical;