with AUnit.Test_Cases.Registration;
use AUnit.Test_Cases.Registration;

with AUnit.Assertions; use AUnit.Assertions;

with Julian_Time;
with Sidereal_Time;

package body Pr_Sidereal_Time_000 is

   use Julian_Time, Sidereal_Time;

   -- Fixture elements;

   T0 : Time;
   D0 : Date;

   -- test routines

   procedure Test_GST
     (T : in out Aunit.Test_Cases.Test_Case'Class) is
   begin
      Assert( (GST(D0) = T0),
      "GST calculation is incorrect");
   end Test_GST;


   ----------
   -- Name --
   ----------

   function Name (T : Test_Case) return String_Access is
   begin
      return new String'("Test sidereal time package");
   end Name;

   --------------------
   -- Register_Tests --
   --------------------

   procedure Register_Tests (T : in out Test_Case) is
   begin
      Register_Routine
        (T, Test_GST'Access, "Test GST calculation");
   end Register_Tests;

   ------------
   -- Set_Up --
   ------------

   procedure Set_Up (T : in out Test_Case) is
   begin
      D0 := 2_451_545.0;  -- J2000.0 = 2000.01.01 12:00:00
      T0 := 67311.0;      -- GAST 18:41:51
   end Set_Up;

end Pr_Sidereal_Time_000;
