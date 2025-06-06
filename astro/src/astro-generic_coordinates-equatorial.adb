-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- Equatorial coordinates.                                           --
--                                                                   --
-- Reference: P.K. Seildemann (ed.), Explanatory Supplement to the   --
-- Astronomical Almanac, ch. 1 and 4 (1992)                          --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
package body Astro.Generic_Coordinates.Equatorial is

   --------------------------
   -- Conversion functions --
   --------------------------

   function LHA (GHA : Degrees; Longitude : Degrees)
      return Degrees
   is
      HA : Degrees;
   begin
      HA := GHA + Longitude;
      --  normalize
      if HA > 180.0 then
         HA := HA - 360.0;
      elsif HA < -180.0 then
         HA := HA + 360.0;
      end if;
      return HA;
   end LHA;

end Astro.Generic_Coordinates.Equatorial;
