-----------------------------------------------------------------------
-- Ephemeris - Ada 2005 library for the JPL ephemerides.             --
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
with Ephemeris.Generic_Data_File;
package body Ephemeris.Generic_State_Functions is

   package Data_File is
     new Generic_Data_File (Real, Ephemeris_Number);
   use Data_File;

   --  Internal data
   Pointers         : Polynomial_Pointers;
   Interval         : Real;
   AU_Value         : Real;
   EM_Ratio_Value   : Real;
   Start_Date_Value : Real;
   End_Date_Value   : Real;

   --  Internal procedures
   procedure Interpolate (T        : Real; -- relative time (0.0..1.0)
                         TS       : Real; -- time span for the full interval
                         Target   : Object;
                         Data     : Data_Record;
                         X        : out State);

   -----------------------
   -- Barycentric_State --
   -----------------------

   function Barycentric_State
     (Target   : Object;
      Date     : Real)
      return State
   is
      N_Record  : Natural;
      Data      : Data_Record;
      T0        : Real renames Data (1);    -- start time for data record
      T1        : Real renames Data (2);    -- end time for data record
      T         : Real;                    -- relative time
      TS        : Real renames Interval;   -- time span of data record
      XT        : State;                   -- target state
      XM        : State;                   -- Moon state
      EM_Factor : constant Real   := 1.0/(1.0 + EM_Ratio);
   begin
      --  Check that there are ephemeris data for the given date.
      if Date < Start_Date or Date > End_Date then
         raise Date_Error;
      end if;

      --  Get ephemeris data record.
      if Date < End_Date then
         N_Record := Natural (Real'Floor ((Date - Start_Date)/Interval)) + 1;
      else
         N_Record := Natural (Real'Floor ((Date - Start_Date)/Interval));
      end if;
      Get_Data (N_Record, Data);

      --  Compute relative time within data record interval.
      T := (Date - T0)/(T1 - T0);

      --  Interpolate barycentric state of object
      case Target is
         when Mercury .. Venus | Mars .. Pluto | Sun =>
            Interpolate (T, TS, Target, Data, XT);
         when Earth =>
            Interpolate (T, TS, Earth, Data, XT);
            Interpolate (T, TS, Moon, Data, XM);
            XT.Position := XT.Position - XM.Position*EM_Factor;
            XT.Velocity := XT.Velocity - XM.Velocity*EM_Factor;
         when Moon =>
            Interpolate (T, TS, Earth, Data, XT);
            Interpolate (T, TS, Moon, Data, XM);
            XT.Position := XT.Position + XM.Position*(1.0 - EM_Factor);
            XT.Velocity := XT.Velocity + XM.Velocity*(1.0 - EM_Factor);
      end case;

      --  Return normalized position and velocity values
      XT.Position := XT.Position / AU;
      XT.Velocity := XT.Velocity / AU;
      return XT;

   end Barycentric_State;

   --------
   -- AU --
   --------

   function AU return Real is
   begin
      return AU_Value;
   end AU;

   --------------
   -- EM_Ratio --
   --------------

   function EM_Ratio return Real is
   begin
      return EM_Ratio_Value;
   end EM_Ratio;

   ----------------
   -- Start_Date --
   ----------------

   function Start_Date return Real is
   begin
      return Start_Date_Value;
   end Start_Date;

   --------------
   -- End_Date --
   --------------

   function End_Date return Real is
   begin
      return End_Date_Value;
   end End_Date;

   -----------------
   -- Interpolate --
   -----------------

   procedure Interpolate (T        : Real; -- relative time (0.0..1.0)
                         TS       : Real; -- time span for the full interval
                         Target   : Object;
                         Data     : Data_Record;
                         X        : out State)
   is
      --  target object index (1..11)
      I     : constant Natural := Object'Pos (Target) + 1;
      --  index to coefficients
      Index : Natural;
      --  beginning of coefficients
      I0    : constant Natural := Pointers (1, I);
      --  no. of coefficients
      NC    : constant Natural := Pointers (2, I);
      --  no. of granules
      NG    : constant Natural := Pointers (3, I);
      --  no. of components
      NM    : constant Natural := 3;

      type Polynomial   is array (1 .. NC) of Real;
      type Coefficients is array (1 .. NM) of Polynomial;

      G    : Natural;                 -- granule within data record
      TC   : Real;                    -- normalized time (-1.0..+1.0);

      P    : Polynomial;              -- Chebyshev polynomial evaluated at TC
      PP   : Polynomial;              -- derivative polynomial evaluated at TC
      C    : Coefficients;            -- Chebyshev coefficients
   begin
      --  granule and normalized time
      G  :=
        Natural (Real'Truncation ((Real (NG) * T - Real'Truncation (T)))) + 1;
      TC :=
        2.0*((Real (NG) * T - Real'Truncation (Real (NG) * T))
             + Real'Truncation (T)) - 1.0;

      --  evaluate Chebyshev polynomials and derivatives
      P := (1.0, TC, others => 0.0);
      for K in 3 .. NC loop
         P (K) := 2.0*TC*P (K - 1) - P (K - 2);
      end loop;

      PP := (0.0, 1.0, 4.0*TC, others => 0.0);
      for k in 4 .. NC loop
         PP (k) := 2.0*TC*PP (k - 1) + 2.0*P (k - 1) - PP (k - 2);
      end loop;

      --  copy Chebyshev coefficients from data record
      Index := I0 + (G - 1)*NM*NC;
      for j in 1 .. NM loop
         for k in 1 .. NC loop
            C (j)(k) := Data (Index);
            Index := Index + 1;
         end loop;
      end loop;

      --  interpolate position and velocity components
      for J in 1 .. NM loop
         X.Position (J) := 0.0;
         for K in 1 .. NC loop
            X.Position (J) := X.Position (J) + C (J)(K)*P (K);
         end loop;
         X.Velocity (J) := 0.0;
         for K in 1 .. NC loop
            X.Velocity (J) := X.Velocity (J) + C (J)(K)*PP (K);
         end loop;
         X.Velocity (J) := X.Velocity (J) * 2.0 * Real (NG) / TS;
      end loop;

   end Interpolate;

   ----------------
   -- Initialize --
   ----------------

   procedure Open_Data (Data_File_Name : in String)
   is
      Parameters : Parameter_Record;
   begin
      Data_File.Open (Data_File_Name);
      Get_Parameters (Parameters);
      Start_Date_Value := Parameters.Start_Date;
      End_Date_Value   := Parameters.End_Date;
      Interval         := Parameters.Interval;
      AU_Value         := Parameters.AU;
      EM_Ratio_Value   := Parameters.EM_Ratio;
      Pointers   := Parameters.Pointers;
   end Open_Data;

   --------------
   -- Finalize --
   --------------

   procedure Close_Data is
   begin
      Data_File.Close;
   end Close_Data;

end Ephemeris.Generic_State_Functions;
