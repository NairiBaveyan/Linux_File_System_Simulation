--------------------------------------------------------------------------
--                                                                      --
-- Copyright (c) 1990, 1991, 1992 by Synopsys, Inc.                     --
--                                             All rights reserved.     --
--                                                                      --
-- This source file may be used and distributed without restriction     --
-- provided that this copyright statement is not removed from the file  --
-- and that any derivative work contains this copyright notice.         --
--                                                                      --
--  Package name: STD_LOGIC_SIGNED                                      --
--                                                                      --
--                                                                      --
--      Date:        09/11/91 KN                                        --
--                   10/08/92 AMT change std_ulogic to signed std_logic --
--                   0/28/92 AMT added signed functions, -, ABS         --
--                                                                      --
--  Purpose:                                                            --
--   A set of signed arithemtic, conversion,                            --
--           and comparision functions for STD_LOGIC_VECTOR.            --
--                                                                      --
--  Note:   Comparision of same length std_logic_vector is defined      --
--          in the LRM.  The interpretation is for unsigned vectors     --
--          This package will "overload" that definition.               --
--                                                                      --
--------------------------------------------------------------------------
-- Exemplar :
--       This package requires no synthesis directives, since it calls 
--       the basic functions from std_logic_arith package.
--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

package STD_LOGIC_SIGNED is

    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "+"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
    function "+"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR;
    function "+"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
    function "-"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "+"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "ABS"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "*"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "<"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "<"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "<"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function "<="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "<="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "<="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function ">"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function ">"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function ">"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function ">="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function ">="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function ">="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function "="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function "/="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "/="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "/="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

-- Added 3/03
    function SHL(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function SHR(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    
    function CONV_INTEGER(ARG: STD_LOGIC_VECTOR) return INTEGER;

-- remove this since it is already in std_logic_arith
--    function CONV_STD_LOGIC_VECTOR(ARG: INTEGER; SIZE: INTEGER) return STD_LOGIC_VECTOR;

end STD_LOGIC_SIGNED;



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

package body STD_LOGIC_SIGNED is


    function maximum(L, R: INTEGER) return INTEGER is
    begin
        if L > R then
            return L;
        else
            return R;
        end if;
    end;


    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        constant length: INTEGER := maximum(L'length, R'length);
        variable result  : STD_LOGIC_VECTOR (length-1 downto 0);
    begin
        result  := SIGNED(L) + SIGNED(R);
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (L'range);
        attribute IS_SIGNED of L:constant is TRUE ;
        attribute SYNTHESIS_RETURN of result:variable is "ADD" ;
    begin
        result  := SIGNED(L) + R;
        return   std_logic_vector(result);
    end;

    function "+"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (R'range);
        attribute IS_SIGNED of R:constant is TRUE ;
        attribute SYNTHESIS_RETURN of result:variable is "ADD" ;
    begin
        result  := L + SIGNED(R);
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (L'range);
        attribute IS_SIGNED of L:constant is TRUE ;
        attribute IS_SIGNED of R:constant is TRUE ;
        attribute SYNTHESIS_RETURN of result:variable is "ADD" ;
    begin
        result  := SIGNED(L) + R;
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (R'range);
        attribute IS_SIGNED of L:constant is TRUE ;
        attribute IS_SIGNED of R:constant is TRUE ;
        attribute SYNTHESIS_RETURN of result:variable is "ADD" ;
    begin
        result  := L + SIGNED(R);
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        constant length: INTEGER := maximum(L'length, R'length);
        attribute IS_SIGNED of L:constant is TRUE ;
        attribute IS_SIGNED of R:constant is TRUE ;
        variable result  : STD_LOGIC_VECTOR (length-1 downto 0);
    begin
        result  := SIGNED(L) - SIGNED(R);
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (L'range);
        attribute IS_SIGNED of L:constant is TRUE ;
        attribute SYNTHESIS_RETURN of result:variable is "SUB" ;
    begin
        result  := SIGNED(L) - R;
        return   std_logic_vector(result);
    end;

    function "-"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (R'range);
        attribute IS_SIGNED of R:constant is TRUE ;
        attribute SYNTHESIS_RETURN of result:variable is "SUB" ;
    begin
        result  := L - SIGNED(R);
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (L'range);
        attribute IS_SIGNED of L:constant is TRUE ;
        attribute IS_SIGNED of R:constant is TRUE ;
        attribute SYNTHESIS_RETURN of result:variable is "SUB" ;
    begin
        result  := SIGNED(L) - R;
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (R'range);
        attribute IS_SIGNED of L:constant is TRUE ;
        attribute IS_SIGNED of R:constant is TRUE ;
        attribute SYNTHESIS_RETURN of result:variable is "SUB" ;
    begin
        result  := L - SIGNED(R);
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (L'range);
        -- no attribute added as modelsim also returns L'range in optimize and non optimize mode.
        -- Even modelsim package source reveals no mti pragma for this function
    begin
        result  := + SIGNED(L);
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (L'range);
        attribute IS_SIGNED of L:constant is TRUE ;
        attribute SYNTHESIS_RETURN of result:variable is "UMINUS" ;
    begin
        result  := - SIGNED(L);
        return   std_logic_vector(result);
    end;

    function "ABS"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (L'range);
        attribute IS_SIGNED of L:constant is TRUE ;
        attribute SYNTHESIS_RETURN of result:variable is "ABS" ;
    begin
        result  := ABS( SIGNED(L));
        return   std_logic_vector(result);
    end;

    function "*"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        constant length: INTEGER := maximum(L'length, R'length);
        variable result  : STD_LOGIC_VECTOR ((L'length+R'length-1) downto 0);
    begin
        result  := SIGNED(L) * SIGNED(R);
        return   std_logic_vector(result);
    end;
        
    function "<"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
        constant length: INTEGER := maximum(L'length, R'length);
    begin
        return   SIGNED(L) < SIGNED(R);
    end;

    function "<"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
    begin
        return   SIGNED(L) < R;
    end;

    function "<"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   L < SIGNED(R);
    end;

    function "<="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   SIGNED(L) <= SIGNED(R);
    end;

    function "<="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
    begin
        return   SIGNED(L) <= R;
    end;

    function "<="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   L <= SIGNED(R);
    end;

    function ">"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   SIGNED(L) > SIGNED(R);
    end;

    function ">"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
    begin
        return   SIGNED(L) > R;
    end;

    function ">"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   L > SIGNED(R);
    end;

    function ">="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   SIGNED(L) >= SIGNED(R);
    end;

    function ">="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
    begin
        return   SIGNED(L) >= R;
    end;

    function ">="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   L >= SIGNED(R);
    end;

    function "="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   SIGNED(L) = SIGNED(R);
    end;

    function "="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
    begin
        return   SIGNED(L) = R;
    end;

    function "="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   L = SIGNED(R);
    end;

    function "/="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   SIGNED(L) /= SIGNED(R);
    end;

    function "/="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
    begin
        return   SIGNED(L) /= R;
    end;

    function "/="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   L /= SIGNED(R);
    end;

-- Added 3/03
    function SHL(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
    begin
       return STD_LOGIC_VECTOR(SHL(SIGNED(ARG),UNSIGNED(COUNT)));
    end;

    function SHR(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
    begin
       return STD_LOGIC_VECTOR(SHR(SIGNED(ARG),UNSIGNED(COUNT)));
    end;

--  This function converts std_logic_vector to a signed integer value
--  using a conversion function in std_logic_arith
    function CONV_INTEGER(ARG: STD_LOGIC_VECTOR) return INTEGER is
        variable result    : SIGNED(ARG'range);
    begin
        result    := SIGNED(ARG);
        return   CONV_INTEGER(result);
    end;
end STD_LOGIC_SIGNED;

