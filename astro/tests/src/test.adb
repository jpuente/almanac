with AUnit;
with Astro_Tests;
procedure Test is
   procedure Run is new AUnit.Test_Runner (Astro_Tests);
begin
   Run;
end Test;
