-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with AUnit.Assertions; use AUnit.Assertions;

with Astro.Generic_Terrestrial_Time;

package body Terrestrial_Time_Tests is

   ---------------
   -- Framework --
   ---------------

   type Real is new Long_Long_Float;

   package Terrestrial_Time is
      new Astro.Generic_Terrestrial_Time (Real);

   use Terrestrial_Time;
   use Julian_Time;     -- instantiated in Terrestrial_Time

   ----------
   -- Name --
   ----------

   overriding function Name
      (T : Terrestrial_Time_Test_Case) return Message_String is
   begin
      return Format ("Terrestrial time tests");
   end Name;

   ------------
   -- Set_Up --
   ------------

   overriding procedure Set_Up
      (T : in out Terrestrial_Time_Test_Case) is
   begin
      null;
   end Set_Up;

   --------------------
   --  Test routines --
   --------------------

   --  Compare real values  --

   function Equals (X, Y : Real; Error : Real := 1.0E-5) return Boolean is
   begin
      return abs (X - Y) <= Error;
   end Equals;

   procedure Test_UT1 (T : in out AUnit.Test_Cases.Test_Case'Class) is
      UTC1 : constant Date := 2460936.929838; --  2025-09-18T10:18:58.0
      UT11 : constant Date := 2460936.929839;
   begin
      Assert (Equals (UT1 (UTC1), UT11), "Invalid UT1");
   end Test_UT1;

   procedure Test_TT (T : in out AUnit.Test_Cases.Test_Case'Class) is
      UTC1 : constant Date := 2460833.137662;   -- 2025-06-06T15:18:14 UTC
      TT1  : constant Date := 2460833.138463;   -- 2025-06-06T15:19:23 TT
      TT0  : constant Date := TT (UTC1);
   begin
      Assert (Equals (TT0, TT1), "Invalid TT");
   end Test_TT;

   procedure Test_UTC (T : in out AUnit.Test_Cases.Test_Case'Class) is
      TT1  : constant Date := 2460833.138463;   -- 2025-06-06T15:19:23 TT
      UTC1 : constant Date := 2460833.137662;   -- 2025-06-06T15:18:14 UTC
      UTC0 : constant Date := UTC (TT1);
   begin
      Assert (Equals (UTC0, UTC1), "Invalid UTC");
   end Test_UTC;

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests 
      (T : in out Terrestrial_Time_Test_Case) is
         use Test_Cases.Registration;
   begin
      Register_Routine
        (T, Test_UT1'Access, "UT1");
      Register_Routine
        (T, Test_TT'Access, "TT");
      Register_Routine
        (T, Test_UTC'Access, "UTC");
   end Register_Tests;

end Terrestrial_Time_Tests;