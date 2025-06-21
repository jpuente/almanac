-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- Horizontal coordinates.                                           --
--                                                                   --
-- Reference: P.K. Seildemann (ed.), Explanatory Supplement to the   --
-- Astronomical Almanac, ch. 1 and 4 (1992)                          --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

package body Astro.Generic_Coordinates.Horizontal is
   use Real_Functions;

   --------------------------
   -- Conversion functions --
   --------------------------

   function Horizontal (E : Equatorial_Coordinates; P : Geographic_Coordinates)
      return Horizontal_Coordinates
   is

      d   : Degrees renames E.Declination;
      ha  : Degrees renames E.Hour_Angle;

      phi : Degrees renames P.Latitude;

      a : Degrees;  --  altitude
      Z : Degrees;  --  azimuth

      deg : constant := 360.0;

   begin

      a := Arcsin ((Sin (d, deg) * Sin (phi, deg)
            + Cos (d, deg) * Cos (phi, deg) * Cos (ha, deg)), deg);

      Z := Arccos ((Sin (d, deg) - Sin (phi, deg) * Sin (a, deg))
            / (Cos (phi, deg) * Cos (a, deg)), deg);

      if 0.0 <= ha and then ha <= 180.0 then
         Z := 360.0 - Z;
      end if;

      return (Altitude => a, Azimuth => Z);

   end Horizontal;

end Astro.Generic_Coordinates.Horizontal;