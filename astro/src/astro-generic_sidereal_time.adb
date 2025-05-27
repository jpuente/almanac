-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
--                                                                   --
--  References :                                                     --
--  Kaplan, G. (2005), US Naval Observatory Circular 179.            --
-----------------------------------------------------------------------

package body Astro.Generic_Sidereal_Time is

   --  References :  
   --  Kaplan, G. (2005), US Naval Observatory Circular 179.

   package Julian renames Julian_Time;

   function Floor (X : Real) return Real
      renames Real'Base'Floor;

   JD0     : constant Julian.Date := Julian.Epoch;

   ------------------
   --  Time scales --
   ------------------

   --  difference TT - UT in seconds;
   Delta_T : constant Real := 32.184 + 37.000 + 0.1;

   --  source: IERS bulletin A 2024.10.03
   --  TT := TAI + 32.184 s
   --  DUT1= (UT1-UTC) transmitted with time signals                         
   --          = +0.1 seconds beginning 5 September 2024 at 0000 UTC             
   --      Beginning 1 January 2017:                                             
   --         TAI-UTC = 37.000 000 seconds 
   --  TDB is approximated by TT  

   ----------
   -- GMST --
   ----------

   function GMST (JD : Julian.Date) return Time
   is
      JD_TT, JD_TDB : Julian.Date;
      DT, T         : Julian.Date;
      Theta, S      : Real;
   begin
      --  Time scales
      JD_TT  := JD + (Delta_T / 86_400.0); -- days
      JD_TDB := JD_TT;  

      --  Julian days (UT) since epoch
      DT := JD - JD0;

      --  Julian centuries (TT) since epoch
      T := (JD_TDB - JD0) / 36525.0;

      --  Earth rotation angle
      Theta := 0.7790572732640 + 1.00273781191135448 * DT; -- rotations
      Theta := ( Theta - Floor (Theta) ) * 360.0;          -- degrees 

      --  Precession in RA of the equinox in arcseconds
      S := 0.014506 + 4612.156534 * T + 1.3915817 * T**2
         - 0.00000044 * T**3 - 0.000029956 * T**4 - 0.0000000368 * T**5; 

      --  GMST 
      S := S / 3600.0 + Theta;                    -- degrees
      S := (S - Floor (S/360.0) * 360.0) / 15.0;  -- hours
      S := S*3600.0;                              -- seconds

      -- Normalize
      if S < 0.0 or else S >= 86400.0 then
         S := S - Floor (S / 86400.0) * 86400.0;
      end if;

      return S;

   end GMST;

   -------------------------------
   -- Equation of the equinoxes --
   -------------------------------

   function Equinoxes (JD : Julian.Date) return Real
   is

      use Frame_Transformations;
      use Real_Functions;

      T  : Julian.Date;

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

   function GAST (JD : Julian.Date) return Time is
      Theta : Time;
   begin
      Theta := GMST (JD) + Equinoxes (JD);
      return Theta;
   end GAST;

end Astro.Generic_Sidereal_Time;
