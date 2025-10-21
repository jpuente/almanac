-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
--                                                                   --
--  References :                                                     --
--  Kaplan, G. (2005), US Naval Observatory Circular 179.            --
-----------------------------------------------------------------------
with Ada.Numerics.Generic_Elementary_Functions;

with Astro.Generic_Frame_Transformations;
with Astro.Generic_Terrestrial_Time;
with Astro.Generic_Dynamical_Time;

package body Astro.Generic_Sidereal_Time is

   package Julian renames Julian_Time;

   package Real_Functions is
      new Ada.Numerics.Generic_Elementary_Functions (Real);

   package Frame_Transformations is
      new Generic_Frame_Transformations (Real);

   package Terrestrial_Time is
      new Generic_Terrestrial_Time (Real);

   package Dynamical_Time is
      new Generic_Dynamical_Time (Real);

   function Floor (X : Real) return Real
      renames Real'Base'Floor;

   JD0     : constant Julian.Date := Julian.Epoch;

   --  difference TT - UT in seconds;
   Delta_T : constant Real := 32.184 + 37.000;

   ----------
   -- GMST --
   ----------

   function GMST (UTC : Date) return Time
   is
      UT      : Date;
      DT      : Date;
      TT, TDB : Date;
      T       : Date;

      Theta, S      : Real;
   begin
      --  Time scales
      UT  := Terrestrial_Time.UT1 (UTC);
      TT  := Terrestrial_Time.TT (UTC);
      TDB := Dynamical_Time.TDB (TT);

      --  Julian days (UT) since epoch
      DT := UTC - JD0;

      --  Julian centuries (TT) since epoch
      T := (TT - JD0) / 36525.0;

      --  Earth rotation angle
      Theta := 0.7790572732640 + 1.00273781191135448 * DT; -- rotations
      Theta := (Theta - Floor (Theta)) * 360.0;            -- degrees

      --  Precession in RA of the equinox in arcseconds
      S := 0.014506 + 4612.156534 * T + 1.3915817 * T**2
         - 0.00000044 * T**3 - 0.000029956 * T**4 - 0.0000000368 * T**5;

      --  GMST
      S := S / 3600.0 + Theta;                      -- degrees
      S := (S - Floor (S / 360.0) * 360.0) / 15.0;  -- hours
      S := S * 3600.0;                              -- seconds

      --  Normalize
      if S < 0.0 or else S >= 86400.0 then
         S := S - Floor (S / 86400.0) * 86400.0;
      end if;

      return S;

   end GMST;

   -------------------------------
   -- Equation of the equinoxes --
   -------------------------------

   function Equinoxes (JD : Date) return Real
   is
      use Frame_Transformations;
      use Real_Functions;

      T  : Date;

      Epsilon, Epsilon_0       : Real;
      Delta_Psi, Delta_Epsilon : Real;
      EE                       : Real;

   begin

      T := (JD - Julian.Epoch) / 36525.0; -- Julian centuries

      --  Mean obliquity of ecliptic
      Epsilon_0 := 23.439291 - 0.0130042 * T
        - 0.163889E-6 * T**2 + 0.503611E-6 * T**3;

      --  Nutation angles and true obliquity
      Get_Nutation_Angles (JD, Delta_Psi, Delta_Epsilon);

      Epsilon   := Epsilon_0 + Delta_Epsilon;

      --  Equation of the equinoxes in seconds
      EE := Delta_Psi * Cos (Epsilon, 360.0) * 86_400.0 / 360.0;

      return EE;

   end Equinoxes;

   ----------
   -- GAST --
   ----------

   function GAST (UTC : Date) return Time is
      Theta : Time;
   begin
      Theta := GMST (UTC) + Equinoxes (UTC);
      return Theta;
   end GAST;

end Astro.Generic_Sidereal_Time;
