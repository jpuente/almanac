-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  This package provides conversion functions between               --
--  barycentric dynamical time (TDB and terrestrial time (TT)        --
--                                                                   --
--  Reference:                                                       --
--  Explanatory Supplement to the Astronomical Almanac,  2.222       --                                                            --
-----------------------------------------------------------------------
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Ada.Numerics.Generic_Elementary_Functions;
with Astro.Constants;

package body Astro.Generic_Dynamical_Time is

   package Real_Functions is
      new Ada.Numerics.Generic_Elementary_Functions (Real);
   use Real_Functions;

   Pi  : constant := Astro.Constants.Pi;
   deg : constant := 360.0;

   ----------
   --  TT  --
   ----------

   function TT (TDB : Date) return Date is
      T, M, S : Real;
   begin
      T := (TDB - Epoch) / 36525.0;
      --  centuries since J2000.0 epoch
      M := (357.528 + 35999.050 * T);
      --  mean anomaly of the Earth (degrees)
      S := 0.001658 * Sin (M, deg) + 0.000014 * Sin (2.0 * M, deg);
      --  TDB-TT (seconds)
      return TDB - S / 86400.0; --  TT (Julian days)
   end TT;

   -----------
   --  TDB  --
   -----------

   function TDB (TT : Date) return Date
   is
      T, M, S : Real;
   begin
      T := (TT - Epoch) / 36525.0;
      --  centuries since J2000.0 epoch
      M := (357.528 + 35999.050 * T);
      --  mean anomaly of the Earth (degrees)
      S := 0.001658 * Sin (M, deg) + 0.000014 * Sin (2.0 * M, deg);
      --  TDB-TT (seconds)
      return TT + S / 86400.0;
   end TDB;

end Astro.Generic_Dynamical_Time;
