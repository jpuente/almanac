with AUnit.Test_Cases.Registration;
use AUnit.Test_Cases.Registration;
with AUnit.Assertions; use AUnit.Assertions;

with Julian_Time;
with Ada.Calendar;

package body PR_Julian_Time_000 is

   use Julian_Time;
   use Ada.Calendar;

   Noon     : constant Day_Duration := 43_200.0;
   Midnight : constant Day_Duration := 0.0;

   -- Fixture elements;

   T0, T1, T2 : Time;
   D0, D1, D2 : Date;

   procedure Set_Up (T : in out Test_Case) is
   begin
      T0 := Time_Of(2000,1,1,Noon);     D0 := 2_451_545.0;
      T1 := Time_Of(1901,1,1,Midnight); D1 := 2_415_385.5;
      T2 := Time_Of(2099,12,31,Noon);   D2 := 2_488_069.0;
   end Set_Up;

   -- Test routines

   procedure Test_Date
     (T : in out Aunit.Test_Cases.Test_Case'Class) is
   begin
      Assert((Date_Of(T0) = D0)
        and (Date_Of(T1) = D1)
        and (Date_Of(T2) = D2),
      "conversion to Julian date is incorrect");
   end Test_Date;

   procedure Test_Time
     (T : in out Aunit.Test_Cases.Test_Case'Class) is
   begin
      Assert((Time_Of(D0) = T0)
        and (Time_Of(D1) = T1)
        and (Time_Of(D2) = T2),
      "conversion from Julian date is incorrect");
   end Test_Time;

   ----------
   -- Name --
   ----------

   function Name (T : Test_Case) return String_Access is
   begin
      return new String'("Test Julian_time package");
   end Name;

   --------------------
   -- Register_Tests --
   --------------------

   procedure Register_Tests (T : in out Test_Case) is
   begin
      Register_Routine
        (T, Test_Date'Access, "Test conversion to Julian date");
      Register_Routine
        (T, Test_Time'Access, "Test conversion from Julian date");
   end Register_Tests;

end PR_Julian_Time_000;
