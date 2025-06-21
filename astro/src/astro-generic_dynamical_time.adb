-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  This package provides abstractions for dynamical time.           --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Astro.Constants;
with Astro.Generic_Coordinates;

package body Astro.Generic_Dynamical_Time is

   package Coordinates is
      new Generic_Coordinates (Real);
   use Coordinates.Real_Functions;

   Delta_T : constant := 65.184 / 86400.0;  -- days
   --  Terrestrial dynamical time is set to TAI + 32.184s
   --  TAI is currently ahead of UTC by 33 seconds (Jun2 2025)

   Pi : constant := Astro.Constants.Pi;

   ----------
   --  TT  --
   ----------

   function TT (TU : Date) return Date is
   begin
      return TU + Delta_T;
   end TT;
   --  Terrestrial time from UT1 (ESAA 2.221)

   ----------
   --  TU  --
   ----------

   function TU (TT : Date) return Date is
   begin
      return TT - Delta_T;
   end TU;
   --  Universal time (UT1) from terrestrial dynamical time.

   -----------
   --  TDB  --
   -----------

   --  Reference: Explanatory Supplement to the Nautical Almanac, 3.311.

   function TDB (TT : Date) return Date
   is
      T : Real;
      M : Real;
      S : Real;
   begin
      T := (TT - Epoch) / 36525.0;
      --  TDT centuries from J2000.0
      M := (357.528 + 35999.050 * T) * 2.0 * Pi / 360.0;
      --  Earth mean anomaly at T
      S := 0.001658 * Sin (M + 0.01671 * Sin (M));
      --  TDB-TDT seconds
      return TT + S / 86400.0;
   end TDB;
   --  Barycentric dynamical time from terrestrial dynamical time.

end Astro.Generic_Dynamical_Time;
