-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
-- This package provides definitions for various types of            --
-- coordinates.                                                      --
-----------------------------------------------------------------------
--  Copyright (C) 2025 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
package body Astro.Generic_Coordinates is

   -----------
   --  GHA  --
   -----------

   function GHA (RA : Real; TU : Julian.Date)
      return Degrees
   is
      use Sidereal_Time;
      HA : Degrees;
   begin
      HA := (GMST (TU) / 86400.0 - RA / 24.0) * 360.0;
      if HA < 0.0 then
         HA := HA + 360.0;
      end if;
      return HA;
   end GHA;

   -----------
   --  LHA  --
   -----------

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

   -----------------
   --  Spherical  --
   -----------------

   function Spherical (U : Vector)
      return Spherical_Coordinates
   is
   begin
      return Spherical_Coordinates'(0.0, 0.0, 0.0);
   end Spherical;

   ------------------
   --  Horizontal  --
   -------------------

   function Horizontal (E : Equatorial_Coordinates; P : Geographic_Coordinates)
      return Horizontal_Coordinates
   is
      use Real_Functions;

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

end Astro.Generic_Coordinates;