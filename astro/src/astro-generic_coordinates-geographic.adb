-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- Geographic coordinates.                                           --
--                                                                   --
-- Reference: P.K. Seildemann (ed.), Explanatory Supplement to the   --
-- Astronomical Almanac, 3.244(1992)                          --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Astro.Constants;

package body Astro.Generic_Coordinates.Geographic is
      use Real_Functions;

   ---------------------------
   --  Geocentric_Position  --
   ---------------------------

   function Geocentric_Position (P : Geographic_Coordinates; H : Real)
      return Vector
   is
      Phi    : Real renames P.Latitude;
      Lambda : Real renames P.Longitude;

      F    : constant := Astro.Constants.F;
      --  Earth flattening factor
      A    : constant := Astro.Constants.R * 1000.0;
      --  Earth' equatorial radius (m)
      deg  : constant := 360.0;

      C, S : Real;
      R    : Vector;
   begin
      C := 1.0 / Sqrt (Cos (Phi, deg)**2 + ((1.0 - F)**2) * Sin (Phi, deg)**2);
      S := ((1.0 - F)**2) * C;
      R := ((A * C + H) * Cos (Phi, deg) * Cos (Lambda, deg),
            (A * C + H) * Cos (Phi, deg) * Sin (Lambda, deg),
            (A * S + H) * Sin (Phi, deg));
      return R;
   end Geocentric_Position;

end Astro.Generic_Coordinates.Geographic;