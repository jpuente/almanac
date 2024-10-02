-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------

with Ada.Calendar; use Ada.Calendar;

with AUnit.Assertions; use AUnit.Assertions;

with Astro.Generic_Julian_Time;

package body Julian_Time_Tests is

   package Julian_Time is
     new Astro.Generic_Julian_Time (Long_Long_Float);
   use Julian_Time;

   ----------
   -- Name --
   ----------

   overriding function Name
      (T : Julian_Time_Test_Case) return Message_String is
   begin
      return Format ("Julian_Time tests");
   end Name;

   -----------
   -- Setup --
   -----------

   Noon     : constant Day_Duration := 43_200.0;
   Midnight : constant Day_Duration := 0.0;
   T0, T1, T2 : Time;
   D0, D1, D2 : Date;

   overriding procedure Set_Up
      (T : in out Julian_Time_Test_Case) is
   begin
      T0 := Time_Of (2000,  1,  1, Noon);     D0 := 2_451_545.0;
      T1 := Time_Of (1901,  1,  1, Midnight); D1 := 2_415_385.5;
      T2 := Time_Of (2099, 12, 31, Noon);     D2 := 2_488_069.0;
   end Set_Up;

   -------------------
   -- Test routines --
   -------------------

   procedure Test_Date
     (T : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Assert ((Date_Of (T0) = D0)
        and then (Date_Of (T1) = D1)
        and then (Date_Of (T2) = D2),
        "conversion to Julian date is incorrect");
   end Test_Date;

   procedure Test_Time
     (T : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Assert ((Time_Of (D0) = T0)
        and then (Time_Of (D1) = T1)
        and then (Time_Of (D2) = T2),
        "conversion from Julian date is incorrect");
   end Test_Time;

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests (T : in out Julian_Time_Test_Case) is
      use Test_Cases.Registration;
   begin
      Register_Routine
        (T, Test_Date'Access, "Conversion to Julian date");
      Register_Routine
        (T, Test_Time'Access, "Conversion from Julian date");
   end Register_Tests;

end Julian_Time_Tests;
