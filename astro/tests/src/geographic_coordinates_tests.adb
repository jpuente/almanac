-----------------------------------------------------------------------
-- Astro - Ada library for astronomical calculations.                --
--                                                                   --
--  Copyright (C) 2024 Juan A. de la Puente                          --
--  Distributed under GPL 3.0                                        --
-----------------------------------------------------------------------
with AUnit.Assertions; use AUnit.Assertions;

with Astro.Generic_Coordinates.Geographic;

package body Geographic_Coordinates_Tests is

   -----------------
   --  Framework  --
   -----------------

   type Real is new Long_Long_Float;

   package Coordinates is
     new Astro.Generic_Coordinates (Real);

   package Geographic is
      new Coordinates.Geographic;
   use Geographic;

   ----------
   -- Name --
   ----------

   overriding function Name
      (T : Geographic_Coordinates_Test_Case) return Message_String is
   begin
      return Format ("Geographic_Coordinates tests");
   end Name;

   -----------
   -- Setup --
   -----------

   overriding procedure Set_Up
      (T : in out Geographic_Coordinates_Test_Case) is
   begin
      null;
   end Set_Up;

   -------------------------
   -- Auxiliary function  --
   -------------------------

   function Equals (X, Y : Real; Error : Real := 1.0E-6) return Boolean is
   begin
      return abs (X - Y) <= Error;
   end Equals;

   -------------------
   -- Test routines --
   -------------------

   procedure Test_Geocentric_Position (T : in out Test_Case'Class) is
      G : constant Geographic_Coordinates := (36.0, -6.0);
      H : constant Real := 10.0;
      U : Vector;

      U1 : constant Real :=  5.137707E+6;
      U2 : constant Real := -0.539994E+6;
      U3 : constant Real :=  3.728198E+6;
   begin
      U := Geocentric_Position (G, H);
      Assert (Equals (U (1), U1, 1.0),
         "Invalid position - U (1) = " & U (1)'Image);
      Assert (Equals (U (2), U2, 1.0),
         "Invalid position - U (2) = " & U (2)'Image);
      Assert (Equals (U (3), U3, 1.0),
         "Invalid position - U (3) = " & U (3)'Image);
   end Test_Geocentric_Position;

   --------------------
   -- Register_Tests --
   --------------------

   overriding procedure Register_Tests
      (T : in out Geographic_Coordinates_Test_Case)
   is
      use Test_Cases.Registration;
   begin
      Register_Routine
        (T, Test_Geocentric_Position'Access, "Geocentric position");
   end Register_Tests;

end Geographic_Coordinates_Tests;
