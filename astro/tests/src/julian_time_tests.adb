-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with Ada.Calendar;            use Ada.Calendar;
with Ada.Calendar.Arithmetic; use Ada.Calendar.Arithmetic;

with AUnit.Assertions;        use AUnit.Assertions;

with Astro.Generic_Julian_Time;

package body Julian_Time_Tests is

   ---------------
   -- Framework --
   ---------------

   type Real is new Long_Long_Float;

   package Julian_Time is
     new Astro.Generic_Julian_Time (Real);
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

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests (T : in out Julian_Time_Test_Case) is
      use Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Date'Access, "Date_Of");
      Register_Routine (T, Test_Time'Access, "Time_Of");
   end Register_Tests;

   --------------------------
   -- Auxiliary functions --
   -------------------------

   --  Compare real values  --

   function Equals (X, Y : Real; Error : Real := 1.0E-6) return Boolean is
   begin
      return abs (X - Y) <= Error;
   end Equals;

   --  Compare time values  --

   function Equals (X, Y : Time; Error : Duration := 1.0E-2) return Boolean is
      D : Day_Count; S : Duration; L : Integer;
   begin
      Difference (X, Y, D, S, L);
      return (D = 0 and then abs (S) < Error);
   end Equals;

   -------------------
   -- Test routines --
   -------------------

   procedure Test_Date (T : in out AUnit.Test_Cases.Test_Case'Class) is
      UT : Time;
      JD : Date;
   begin
      UT := Time_Of (2000, 1, 1, Noon);
      JD := 2_451_545.0;
      Assert (Equals (Date_Of (UT), JD), "invalid Julian date" & JD'Image);

      UT := Time_Of (1901,  1,  1, Midnight);
      JD := 2_415_385.5;
      Assert (Equals (Date_Of (UT), JD), "invalid Julian date" & JD'Image);

      UT := Time_Of (2024,  2, 29, Noon);
      JD := 2_460_370.0;
      Assert (Equals (Date_Of (UT), JD), "invalid Julian date" & JD'Image);

      UT := Time_Of (2025,  9, 18, 37138.0); -- 10:18:58
      JD := 2_460_936.929838;
      Assert (Equals (Date_Of (UT), JD), "invalid Julian date" & JD'Image);

      UT := Time_Of (2099, 12, 31, Noon);
      JD := 2_488_069.0;
      Assert (Equals (Date_Of (UT), JD), "invalid Julian date" & JD'Image);
   end Test_Date;

   procedure Test_Time (T : in out AUnit.Test_Cases.Test_Case'Class) is
      UT     : Time;
      JD     : Date;
      JT     : Time;
      JS     : Day_Duration;
   begin
      UT := Time_Of (2000, 1, 1, Noon);
      JD := 2_451_545.0;
      JT := Time_Of (JD); JS := Seconds (JT);
      Assert (Equals (JT, UT), "invalid time " & JS'Image & " s");

      UT := Time_Of (1901,  1,  1, Midnight);
      JD := 2_415_385.5;
      JT := Time_Of (JD); JS := Seconds (JT);
      Assert (Equals (JT, UT), "invalid time " & JS'Image & " s");

      UT := Time_Of (2024,  2, 29, Noon);
      JD := 2_460_370.0;
      JT := Time_Of (JD); JS := Seconds (JT);
      Assert (Equals (JT, UT), "invalid time " & JS'Image & " s");

      UT := Time_Of (2025,  9, 18, 37138.0); -- 10:18:58
      JD := 2_460_936.929838;
      JT := Time_Of (JD); JS := Seconds (JT);
      Assert (Equals (JT, UT), "invalid time " & JS'Image & " s");

      UT := Time_Of (2099, 12, 31, Noon);
      JD := 2_488_069.0;
      JT := Time_Of (JD); JS := Seconds (JT);
      Assert (Equals (JT, UT), "invalid time " & JS'Image & " s");
   end Test_Time;

end Julian_Time_Tests;
