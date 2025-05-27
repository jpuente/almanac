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

   overriding procedure Set_Up
      (T : in out Julian_Time_Test_Case) is
   begin
      null;
   end Set_Up;

   -------------------
   -- Test routines --
   -------------------

   procedure Test_Date (T : in out AUnit.Test_Cases.Test_Case'Class) is
      UT : Time;
      JD : Date;
   begin

      UT := Time_Of (2000, 1, 1, Noon);
      JD := 2_451_545.0;
      Assert (Date_Of (UT) = JD, "invalid Julian date");

      UT := Time_Of (1901,  1,  1, Midnight);
      JD := 2_415_385.5;
      Assert (Date_Of (UT) = JD, "invalid Julian date");

      UT := Time_Of (2024,  2, 29, Noon);
      JD := 2_460_370.0;
      Assert (Date_Of (UT) = JD, "invalid Julian date");

      UT := Time_Of (2099, 12, 31, Noon);
      JD := 2_488_069.0;
      Assert (Date_Of (UT) = JD, "invalid Julian date");
   end Test_Date;

   procedure Test_Time (T : in out AUnit.Test_Cases.Test_Case'Class) is
      UT : Time;
      JD : Date;
   begin
      UT := Time_Of (2000, 1, 1, Noon);
      JD := 2_451_545.0;
      Assert (Time_Of (JD) = UT, "invalid time");

      UT := Time_Of (1901,  1,  1, Midnight);
      JD := 2_415_385.5;
      Assert (Time_Of (JD) = UT, "invalid time");

      UT := Time_Of (2024,  2, 29, Noon);
      JD := 2_460_370.0;
      Assert (Time_Of (JD) = UT, "invalid time");

      UT := Time_Of (2099, 12, 31, Noon);
      JD := 2_488_069.0;
      Assert (Time_Of (JD) = UT, "invalid time");
   end Test_Time;

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests (T : in out Julian_Time_Test_Case) is
      use Test_Cases.Registration;
   begin
      Register_Routine
        (T, Test_Date'Access, "Date_Of");
      Register_Routine
        (T, Test_Time'Access, "Time_Of");
   end Register_Tests;

end Julian_Time_Tests;
