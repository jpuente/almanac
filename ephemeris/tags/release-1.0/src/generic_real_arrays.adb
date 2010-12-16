with Ada.Numerics.Generic_Elementary_Functions;
package body Generic_Real_Arrays is
   package Real_Functions is
     new Ada.Numerics.Generic_Elementary_Functions(Real);
   use Real_Functions;

   -- Real vector operations

   function "+" (Right : Real_Vector) return Real_Vector is
      Temp : Real_Vector(Right'Range);
   begin
      for I in Right'Range loop
        Temp(I) := +Right(I);
      end loop;
      return Temp;
   end "+";

   function "-" (Right : Real_Vector) return Real_Vector is
      Temp : Real_Vector(Right'Range);
   begin
      for I in Right'Range loop
        Temp(I) := -Right(I);
      end loop;
      return Temp;
   end "-";

   function "abs" (Right : Real_Vector) return Real_Vector is
      Temp : Real_Vector(Right'Range);
   begin
      for I in Right'Range loop
        Temp(I) := abs(Right(I));
      end loop;
      return Temp;
   end "abs";

   function "+" (Left, Right : Real_Vector) return Real_Vector is
       Temp : Real_Vector(Right'Range);
   begin
      for I in Right'Range loop
         Temp(I) := Left(I) + Right(I);
      end loop;
      return Temp;
   end "+";

   function "-" (Left, Right : Real_Vector) return Real_Vector is
       Temp : Real_Vector(Right'Range);
   begin
      for I in Right'Range loop
        Temp(I) := Left(I) - Right(I);
      end loop;
      return Temp;
   end "-";

   function "*" (Left, Right : Real_Vector) return Real'Base is
       Temp : Real'Base := 0.0;
   begin
      for I in Right'Range loop
        Temp := Temp + Left(I)*Right(I);
      end loop;
      return Temp;
   end "*";

    function "abs" (Right : Real_Vector) return Real'Base is
   begin
      return Sqrt(Right*Right);
   end "abs";

   function "*"
     (Left : Real'Base;
      Right : Real_Vector)
      return Real_Vector
   is
       Temp : Real_Vector(Right'Range);
   begin
      for I in Right'Range loop
        Temp(I) := Left*Right(I);
      end loop;
      return Temp;
   end "*";

   function "*"
     (Left : Real_Vector;
      Right : Real'Base)
      return Real_Vector
   is
       Temp : Real_Vector(Left'Range);
   begin
      for I in Left'Range loop
        Temp(I) := Left(I)*Right;
      end loop;
      return Temp;
   end "*";

    function "/"
     (Left : Real_Vector;
      Right : Real'Base)
      return Real_Vector
   is
      Temp : Real_Vector(Left'Range);
   begin
      for I in Left'Range loop
        Temp(I) := Left(I)/Right;
      end loop;
      return Temp;
   end "/";

   -- Real matrix operations

   function "+" (Right : Real_Matrix) return Real_Matrix
   is
      X : Real_Matrix(Right'Range(1),Right'Range(2));
   begin
     for I in X'Range(1) loop
         for j in X'Range(2) loop
            X(I,J) := +Right(I,J);
         end loop;
      end loop;
      return X;
   end "+";

   function "-" (Right : Real_Matrix) return Real_Matrix is
      X : Real_Matrix (Right'Range(1),Right'Range(2));
   begin
      for I in X'Range(1) loop
         for j in X'Range(2) loop
            X(I,J) := -Right(I,J);
         end loop;
      end loop;
      return X;
   end "-";

   function "abs" (Right : Real_Matrix) return Real_Matrix is
      X : Real_Matrix (Right'Range(1),Right'Range(2));
   begin
      for I in X'Range(1) loop
         for j in X'Range(2) loop
            X(I,J) := abs Right(I,J);
         end loop;
      end loop;
      return X;
   end "abs";

   function Transpose (X : Real_Matrix) return Real_Matrix is
      T : Real_Matrix (X'Range(2),X'Range(1));
   begin
      for I in X'Range(1) loop
         for j in X'Range(2) loop
            T(I,J) := X(J,I);
         end loop;
      end loop;
      return X;
   end Transpose;

   function "+" (Left, Right : Real_Matrix) return Real_Matrix is
      X : Real_Matrix (Left'Range(1),Left'Range(2));
   begin
      if Left'Length(1) /= Right'Length(1) or
        Left'Length(2) /= Right'Length(2)
      then
         raise Constraint_Error;
      end if;
      for I in X'Range(1) loop
         for J in X'Range(2) loop
            X(I,J) := Left(I,J) + Right(I,J);
         end loop;
      end loop;
      return X;
   end "+";

   function "-" (Left, Right : Real_Matrix) return Real_Matrix is
      X : Real_Matrix (Left'Range(1),Left'Range(2));
   begin
      if Left'Length(1) /= Right'Length(1) or
        Left'Length(2) /= Right'Length(2)
      then
         raise Constraint_Error;
      end if;
      for I in X'Range(1) loop
         for J in X'Range(2) loop
            X(I,J) := Left(I,J) - Right(I,J);
         end loop;
      end loop;
      return X;
   end "-";

   function "*" (Left, Right : Real_Matrix) return Real_Matrix is
      X : Real_Matrix (Left'Range(1),Right'Range(2));
   begin
      if Left'Length(2) /= Right'Length(1) then
         raise Constraint_Error;
      end if;
      for I in X'Range(1) loop
         for J in X'Range(2) loop
            X(I,J) := 0.0;
            for K in Left'Range(2) loop
               X(I,J) := X(I,J) + Left(I,K)*Right(K,J);
            end loop;
         end loop;
      end loop;
      return X;
      end "*";

   function "*" (Left, Right : Real_Vector) return Real_Matrix is
      X : Real_Matrix (Left'Range,Right'Range);
   begin
      for I in X'Range(1) loop
         for J in X'Range(2) loop
            X(I,J) := Left(I)*Right(J);
         end loop;
      end loop;
      return X;
   end "*";

   function "*" (Left : Real_Vector; Right : Real_Matrix)
                 return Real_Vector
   is
      X : Real_Vector(Right'Range(2));
   begin
      if Left'Length /= Right'Length(1) then
         raise Constraint_Error;
      end if;
      for I in X'Range loop
         X(I) := 0.0;
         for J in Left'Range loop
            X(I) := X(I) + Left(J)*Right(J,I);
         end loop;
      end loop;
      return X;
   end "*";

   function "*" (Left : Real_Matrix; Right : Real_Vector)
                 return Real_Vector
   is
      X : Real_Vector(Left'Range(1));
   begin
      if Left'Length(1) /= Right'Length then
         raise Constraint_Error;
      end if;
      for I in X'Range loop
         X(I) := 0.0;
         for J in Left'Range(1) loop
               X(I) := X(I) + Left(I,J)*Right(J);
         end loop;
      end loop;
      return X;
   end "*";

   -- Matrix scaling operations

   function "*" (Left : Real'Base;   Right : Real_Matrix)
     return Real_Matrix
   is
      X : Real_Matrix (Right'Range(1),Right'Range(2));
   begin
      for I in X'Range(1) loop
         for j in X'Range(2) loop
            X(I,J) := Left*Right(I,J);
         end loop;
      end loop;
      return X;
   end "*";

   function "*" (Left : Real_Matrix; Right : Real'Base)
                 return Real_Matrix
   is
      X : Real_Matrix (Left'Range(1),Left'Range(2));
   begin
      for I in X'Range(1) loop
         for j in X'Range(2) loop
            X(I,J) := Left(I,J)*Right;
         end loop;
      end loop;
      return X;
   end "*";

   function "/" (Left : Real_Matrix; Right : Real'Base)
                 return Real_Matrix
   is
      X : Real_Matrix (Left'Range(1),Left'Range(2));
   begin
      for I in X'Range(1) loop
         for j in X'Range(2) loop
            X(I,J) := Left(I,J)/Right;
         end loop;
      end loop;
      return X;
   end "/";

end Generic_Real_Arrays;
