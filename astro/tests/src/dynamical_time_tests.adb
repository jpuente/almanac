-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with AUnit.Assertions; use AUnit.Assertions;

with Astro.Generic_Dynamical_Time;

package body Dynamical_Time_Tests is

   ---------------
   -- Framework --
   ---------------

   type Real is new Long_Long_Float;

   package Dynamical_Time is
      new Astro.Generic_Dynamical_Time (Real);

   use Dynamical_Time;
   use Julian_Time;     -- instantiated in Dynamical_Time

   ----------
   -- Name --
   ----------

   overriding function Name
      (T : Dynamical_Time_Test_Case) return Message_String is
   begin
      return Format ("Dynamical time tests");
   end Name;

   ------------
   -- Set_Up --
   ------------

   overriding procedure Set_Up
      (T : in out Dynamical_Time_Test_Case) is
   begin
      null;
   end Set_Up;

   --------------------
   --  Test routines --
   --------------------

   --  Compare real values  --

   function Equals (X, Y : Real; Error : Real := 1.0E-6) return Boolean is
   begin
      return abs (X - Y) <= Error;
   end Equals;

   procedure Test_TT (T : in out AUnit.Test_Cases.Test_Case'Class) is
      TDB1 : constant Date := 2460833.136910;   -- 2025.06.06. 15:18:14 TDB
      TT1  : constant Date := 2460833.136909;   -- 2025.06.06. 15:17:09 TT
      TT0  : constant Date := TT (TDB1);
   begin
      Assert (Equals (TT0, TT1, 1.0E-5), "Invalid TT" & TT0'Image);
   end Test_TT;

   procedure Test_TDB (T : in out AUnit.Test_Cases.Test_Case'Class) is
      TT1  : constant Date := 2460833.136910;   -- 2025.06.06. 15:17:09 TT
      TDB1 : constant Date := 2460833.136911;   -- 2025.06.06. 15:18:14 TDB
      TDB0 : constant Date := TDB (TT1);
   begin
      Assert (Equals (TDB0, TDB1, 1.0E-5), "Invalid TDB" & TDB0'Image);
   end Test_TDB;

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests (T : in out Dynamical_Time_Test_Case) is
      use Test_Cases.Registration;
   begin
      Register_Routine
        (T, Test_TT'Access, "TT");
      Register_Routine
        (T, Test_TDB'Access, "TDB");
   end Register_Tests;

end Dynamical_Time_Tests;