-----------------------------------------------------------------------
-- Ephemeris - Ada 2005 library for the JPL ephemerides              --
--                                                                   --
-- This package provides vector and matrix types. It is a            --
-- provisional substitute for Ada.Numerics.Generic_Real_Arrays       --
--                                                                   --
-----------------------------------------------------------------------

generic
   type Real is digits <>;
package Generic_Real_Arrays is
   pragma Pure(Generic_Real_Arrays);

   -- Types

   type Real_Vector is array (Integer range <>) of Real'Base;
   type Real_Matrix is array (Integer range <>, Integer range <>) of Real'Base;

   -- Subprograms for Real_Vector types

   -- Real_Vector arithmetic operations

   function "+"   (Right : Real_Vector)       return Real_Vector;
   function "-"   (Right : Real_Vector)       return Real_Vector;
   function "abs" (Right : Real_Vector)       return Real_Vector;

   function "+"   (Left, Right : Real_Vector) return Real_Vector;
   function "-"   (Left, Right : Real_Vector) return Real_Vector;

   function "*"   (Left, Right : Real_Vector) return Real'Base;

   function "abs" (Right : Real_Vector)       return Real'Base;

   -- Real_Vector scaling operations

   function "*" (Left : Real'Base;   Right : Real_Vector) return Real_Vector;
   function "*" (Left : Real_Vector; Right : Real'Base)   return Real_Vector;
   function "/" (Left : Real_Vector; Right : Real'Base)   return Real_Vector;

   -- Subprograms for Real_Matrix types

   -- Real_Matrix arithmetic operations

    function "+"       (Right : Real_Matrix) return Real_Matrix;
    function "-"       (Right : Real_Matrix) return Real_Matrix;
    function "abs"     (Right : Real_Matrix) return Real_Matrix;
    function Transpose (X     : Real_Matrix) return Real_Matrix;

    function "+" (Left, Right : Real_Matrix) return Real_Matrix;
    function "-" (Left, Right : Real_Matrix) return Real_Matrix;
    function "*" (Left, Right : Real_Matrix) return Real_Matrix;

    function "*" (Left, Right : Real_Vector) return Real_Matrix;

    function "*" (Left : Real_Vector; Right : Real_Matrix) return Real_Vector;
    function "*" (Left : Real_Matrix; Right : Real_Vector) return Real_Vector;

   -- Real_Matrix scaling operations

    function "*" (Left : Real'Base;   Right : Real_Matrix) return Real_Matrix;
    function "*" (Left : Real_Matrix; Right : Real'Base)   return Real_Matrix;
    function "/" (Left : Real_Matrix; Right : Real'Base)   return Real_Matrix;

end Generic_Real_Arrays;
