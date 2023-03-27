with AUnit; use AUnit.Test_Suites;
with Julian_Time_Test;
--with Pr_Frame_Transformations_000;
--with Pr_Sidereal_Time_000;

function Astro_Tests return Access_Test_Suite is
   Result : Access_Test_Suite := new Test_Suite;
begin
   Add_Test (Result, new Julian_Time_Test.Test_Case);
--   Add_Test (Result, new Pr_Frame_Transformations_000.Test_Case);
--   Add_Test (Result, new Pr_Sidereal_Time_000.Test_Case);
   return Result;
end Astro_Tests;
