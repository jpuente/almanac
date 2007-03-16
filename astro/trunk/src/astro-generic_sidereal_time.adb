-----------------------------------------------------------------------
-- Astro - Ada 2005 library for astrometry.                          --
--                                                                   --
-- This package provides abstractions for sidereal time.             --
--                                                                   --
-----------------------------------------------------------------------
--  Copyright (C) 2006 Juan A. de la Puente  <jpuente@dit.upm.es>    --
--  This unit was originally developed by Juan A. de la Puente.      --
-----------------------------------------------------------------------
-- This library is free software; you can redistribute it and/or     --
-- modify it under the terms of the GNU General Public               --
-- License as published by the Free Software Foundation; either      --
-- version 2 of the License, or (at your option) any later version.  --
--                                                                   --
-- This library is distributed in the hope that it will be useful,   --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of    --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
-- General Public License for more details.                          --
--                                                                   --
-- You should have received a copy of the GNU General Public         --
-- License along with this library; if not, write to the             --
-- Free Software Foundation, Inc., 59 Temple Place - Suite 330,      --
-- Boston, MA 02111-1307, USA.                                       --
-----------------------------------------------------------------------

package body Astro.Generic_Sidereal_Time is
   -- Reference: Explanatory Supplemment to the Astronomical Almanac (ESAA),
   -- pp. 50-53 & 109-120

   -- use Numerics;
   package Julian renames Julian_Time;
   use type Julian.Date;

   function Floor(X : Real) return Real
                  renames Real'Base'Floor;

   T0    : constant Julian.Date := Julian.Epoch;

   ----------
   -- GMST --
   ----------

   function GMST (D : Julian.Date) return Time
   is
      T    : Real;
      S    : Real;
   begin
      T := (D - T0)/36525.0;         -- Julian centuries (UT) since epoch
      S := 67_310.54841
        + 8_640_184.812866*T
          + 3_155_760_000.0*T
            + 0.093_104*T**2
              - 6.2E-6*T**3;         -- Sidereal time in seconds
      if S < 0.0 or S >= 86400.0 then
         S := S - Floor(S/86400.0)*86400.0;
      end if;

      return S;

   end GMST;

   -------------------------------
   -- Equation of the equinoxes --
   -------------------------------

   function Equinoxes(D: Julian.Date) return Real
   is
      use Frame_Transformations;
      use Real_Functions;

      deg : constant := 360.0;

      Epsilon, Epsilon_0       : Real;
      Delta_Psi, Delta_Epsilon : Real;
      T  : Real;
      EE : Real;
   begin
      -- Mean obliquity of ecliptic
      T := (D - Julian_Time.Epoch)/36525.0; -- Julian centuries
      Epsilon_0 := 23.439291 - 0.0130042*T
        - 0.163889E-6*T**2 + 0.503611E-6*T**3;

      -- Nutation angles and true obliquity
      Get_Nutation_Angles(D, Delta_Psi, Delta_Epsilon);
      Epsilon   := Epsilon_0 + Delta_Epsilon;

      -- Equation of the equinoxes in seconds
      EE := Delta_Psi*cos(Epsilon,360.0)*86_400.0/360.0;
      return EE;
   end Equinoxes;

   ----------
   -- GST --
   ----------

   function GST (D: Julian.Date)  return Time is
      Theta : Time;
   begin
      Theta     := GMST(D) + Equinoxes(D);
      return Theta;
   end GST;

end Astro.Generic_Sidereal_Time;
