-----------------------------------------------------------------------
-- Astro - Ada 2005 library for astrometry.                          --
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
with Astro.Constants;

package body Astro.Generic_Frame_Transformations is

   use Astro.Constants;
   use Real_Functions;

   -- subtype Vector is Real_Arrays.Real_Vector(1..3);
   subtype Matrix is Real_Arrays.Real_Matrix(1..3,1..3);

   ------------------------------
   -- Correct light deflection --
   ------------------------------

   -- Reference: Explanatory Supllement to Astronomical Almanac, 3.26 & 3.316

   procedure Correct_Light_Deflection
     (U  : in out Vector;  -- geocentric position of the body
      Q  :        Vector;  -- heliocentric position of the body
      EH :        Vector)  -- heliocentric position of the Earth
   is
      use type Real_Arrays.Real_Vector;

      C  : constant := Constants.C*1000.0;     -- Light speed in m/s
      Mu : constant := Constants.Mu;           -- Gravitational constant m3/s2
      AU : constant := Constants.AU;           -- Astronomical Unit in km

      U1, Q1, E1 : Vector; -- unit vectors
      Em, G1, G2 : Real;
      UQ, EU     : Real;
   begin
      U1 := U/abs(U);           -- geocentric direction of the body
      Q1 := Q/abs(Q);           -- heliocentric direction of the body
      E1 := EH/abs(EH);         -- heliocentric direction of Earth
      Em := abs(EH)*AU*1000.0;  -- Earth-Sun distance in m
      G1 := 2.0*Mu/(C**2*Em);
      G2 := 1.0 + Q1*E1;
      UQ := U1*Q1;
      EU := E1*U1;
      U  := abs(U)*(U1 + G1/G2*UQ*E1 - EU*Q1);
   end Correct_Light_Deflection;


   ------------------------
   -- Correct aberration --
   ------------------------

   -- Reference: Explanatory Supplement to the Astronomical Almanac, 3.317.

   procedure Correct_Aberration (U       : in out Vector; -- geo. position
                                 VEB     :        Vector) -- bary. Earth vel.
   is
      use type Real_Arrays.Real_Vector;

      AU : constant := Constants.AU;           -- Astronomical Unit in km
      C  : constant := Constants.C/AU*86400.0; -- Light speed in AU/day

      P, V   : Vector;
      Beta   : Real;
      F1, F2 : Real;

   begin
      P     := U/abs(U);         -- Unit vector on the direction of U.
      V     := VEB/C;            -- Earth velocity in units of C.
      Beta  := sqrt(1.0 - V*V);
      F1    := P*V;
      F2    := 1.0 + F1/(1.0 + Beta);
      U     := (Beta*U + F2*abs(U)*V)/(1.0 + F1);
   end Correct_Aberration;


   ----------------------
   -- Apply precession --
   ----------------------

   -- Reference: Explanatory Supplement to the Astronomical Almanac, 3.318
   --            and 3.211

   procedure Precess
     (U    : in out Vector;      -- geocentric position vector
      TDB0 : Julian_Time.Date;
      TDB1 : Julian_Time.Date)
   is
      use type Real_Arrays.Real_Matrix;

      E0      : constant Real := Julian_Time.Epoch;
      SEC2RAD : constant := 2.0*Pi/(360.0*60.0*60.0);

      T0, T   : Real; -- Julian centuries
      Zeta_A  : Real; -- Fundamental angles in radians
      Z_A     : Real;
      Theta_A : Real;

      P       : Matrix;

   begin

      T0 := (TDB0 - E0)/36525.0;
      T  := (TDB1 - TDB0)/36525.0;

      -- Compute fundamental angles
      Zeta_A  := ((2306.2181 + 1.39656*T0 - 0.000139*T0**2)*T
        + (0.30188 - 0.000344*T0)*T**2 + 0.017998*T**3)*SEC2RAD;
      Z_A     := ((2306.2181 + 1.39656*T0 - 0.000139*T0**2)*T
        + (1.09468 + 0.000066*T0)*T**2 + 0.018203*T**3)*SEC2RAD;
      Theta_A := ((2004.3109 - 0.85330*T0 - 0.000217*T0**2)*T
        + (-0.42665 - 0.000217*T0)*T**2 - 0.041833*T**3)*SEC2RAD;

      -- Make precesion matrix
      P := ((cos(Z_A)*cos(Theta_A)*cos(Zeta_A) - sin(Z_A)*sin(Zeta_A),
               -cos(Z_A)*cos(Theta_A)*sin(Zeta_A) - sin(Z_A)*cos(Zeta_A),
               -cos(Z_A)*sin(Theta_A)),

            (sin(Z_a)*cos(Theta_A)*cos(Zeta_A) + cos(Z_A)*sin(Zeta_A),
               -sin(Z_A)*cos(Theta_A)*sin(Zeta_A) + cos(Z_A)*cos(Zeta_A),
               -sin(Z_A)*sin(Theta_A)),

            (sin(Theta_A)*cos(Zeta_A),
               -sin(Theta_A)*sin(Zeta_A),
             cos(Theta_A)));

      -- Apply precession matrix to position vector
      U := P*U;

   end Precess;

   --------------------
   -- Apply nutation --
   --------------------

   -- Reference: Explanatory Supplement to the Astronomical Almanac, 3.319
   --            and 3.222.

   procedure Nutate
     (U   : in out Vector;
      JD  :        Julian_Time.Date)
   is
      use type Real_Arrays.Real_Matrix;
      deg : constant := 360.0;

      Epsilon_0, Epsilon       : Real; -- Mean and true obliquity, degrees.
      Delta_Psi, Delta_Epsilon : Real; -- Nutation angles, degrees.

      T : Real;
      N : Matrix;
   begin
      -- Mean obliquity of ecliptic
      T := (JD - Julian_Time.Epoch)/36525.0; -- Julian centuries
      Epsilon_0 := 23.439291 - 0.0130042*T
        - 0.163889E-6*T**2 + 0.503611E-6*T**3;

      -- Nutation angles and true obliquity
      Get_Nutation_Angles(JD, Delta_Psi, Delta_Epsilon);
      Epsilon := Epsilon_0 + Delta_Epsilon;

      -- Make nutation matrix
      N := ((cos(Delta_Psi,deg),
               -sin(Delta_Psi,deg)*cos(Epsilon_0,deg),
               -sin(Delta_Psi,deg)*sin(Epsilon_0,deg)),

            (sin(Delta_Psi,deg)*cos(Epsilon,deg),
             cos(Delta_Psi,deg)*cos(Epsilon,deg)*cos(Epsilon_0,deg)
               + sin(Epsilon,deg)*sin(Epsilon_0,deg),
             cos(Delta_Psi,deg)*cos(Epsilon,deg)*sin(Epsilon_0,deg)
               - sin(Epsilon,deg)*cos(Epsilon_0,deg)),

            (sin(Delta_Psi,deg)*sin(Epsilon,deg),
             cos(Delta_Psi,deg)*sin(Epsilon,deg)*cos(Epsilon_0,deg)
               - cos(Epsilon,deg)*sin(Epsilon_0,deg),
             cos(Delta_Psi,deg)*sin(Epsilon,deg)*sin(Epsilon_0,deg)
               + cos(Epsilon,deg)*cos(Epsilon_0,deg)));

      U := N*U;
   end Nutate;

   -----------------------------
   -- Compute nutation angles --
   -----------------------------
   -- Approximate method, see ESAA 3.225

   procedure Get_Nutation_Angles
     (JD        :     Julian_Time.Date;
      Delta_Psi : out Real;             -- nutation in longitude
      Delta_Eps : out Real)
   is
      deg : constant := 360.0;
      T : Real;
   begin
      T := JD - Julian_Time.Epoch;     -- days since epoch
      Delta_Psi := -0.0048*sin(125.0 - 0.05295*T,deg)
        - 0.0004*sin(200.9 + 1.97129*T,deg);
      Delta_Eps := 0.0026*cos(125.0 - 0.05295*T,deg)
        + 0.0002*cos(200.9 + 1.97129*T,deg);
   end Get_Nutation_Angles;

end Astro.Generic_Frame_Transformations;
