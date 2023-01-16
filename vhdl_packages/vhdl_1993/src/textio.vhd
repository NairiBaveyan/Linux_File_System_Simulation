
---------------------------------------------------------------------------
---------------------------------------------------------------------------
--  This is Package TEXTIO as defined in Chapter 14 of the 
--  IEEE Standard VHDL Language Reference Manual (IEEE Std. 1076-1993)
----------------------------------------------------------------------------
-- 
--  Verific : Added body/pragma's to handle file interfacing functions for synthesis
--
---------------------------------------------------------------------------
---------------------------------------------------------------------------

package TEXTIO is

    -- Type definitions for Text I/O

    type LINE is access string;
    type TEXT is file of string;
    type SIDE is (right, left);
    subtype WIDTH is natural;

    -- Standard Text Files

    file input : TEXT open READ_MODE is "STD_INPUT";
    file output : TEXT open WRITE_MODE is "STD_OUTPUT";

    -- Input Routines for Standard Types

    procedure READLINE(file F: TEXT; L: out LINE);

    procedure READ(L:inout LINE; VALUE: out bit; GOOD : out BOOLEAN);
    procedure READ(L:inout LINE; VALUE: out bit);

    procedure READ(L:inout LINE; VALUE: out bit_vector; GOOD : out BOOLEAN);
    procedure READ(L:inout LINE; VALUE: out bit_vector);

    procedure READ(L:inout LINE; VALUE: out BOOLEAN; GOOD : out BOOLEAN);
    procedure READ(L:inout LINE; VALUE: out BOOLEAN);

    procedure READ(L:inout LINE; VALUE: out character; GOOD : out BOOLEAN);
    procedure READ(L:inout LINE; VALUE: out character);

    procedure READ(L:inout LINE; VALUE: out integer; GOOD : out BOOLEAN);
    procedure READ(L:inout LINE; VALUE: out integer);

    procedure READ(L:inout LINE; VALUE: out real; GOOD : out BOOLEAN);
    procedure READ(L:inout LINE; VALUE: out real);

    procedure READ(L:inout LINE; VALUE: out string; GOOD : out BOOLEAN);
    procedure READ(L:inout LINE; VALUE: out string);

    procedure READ(L:inout LINE; VALUE: out time; GOOD : out BOOLEAN);
    procedure READ(L:inout LINE; VALUE: out time);

    -- Output Routines for Standard Types

    procedure WRITELINE(file F : TEXT; L : inout LINE);

    procedure WRITE(L : inout LINE; VALUE : in bit;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0);

    procedure WRITE(L : inout LINE; VALUE : in bit_vector;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0);

    procedure WRITE(L : inout LINE; VALUE : in BOOLEAN;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0);

    procedure WRITE(L : inout LINE; VALUE : in character;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0);

    procedure WRITE(L : inout LINE; VALUE : in integer;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0);

    procedure WRITE(L : inout LINE; VALUE : in real;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0;
	      DIGITS: in NATURAL := 0);

    procedure WRITE(L : inout LINE; VALUE : in string;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0);

    procedure WRITE(L : inout LINE; VALUE : in time;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0;
	      UNIT: in TIME := ns);

    -- File Position Predicates

    -- function ENDLINE(variable L : in LINE) return BOOLEAN;

    -- Function ENDLINE as declared cannot be legal VHDL, and
    --   the entire function was deleted from the definition
    --   by the Issues Screening and Analysis Committee (ISAC),
    --   a subcommittee of the VHDL Analysis and Standardization
    --   Group (VASG) on 10 November, 1988.  See "The Sense of
    --   the VASG", October, 1989, VHDL Issue Number 0032.

    -- function ENDFILE (file f: TEXT) return BOOLEAN ;
    
    -------------------------------------------------------------------    
    -- Declare the textio directive attribute; to be set on 
    -- basic functions that have a 'builtin' implementation for elaboration
    -------------------------------------------------------------------    
    ATTRIBUTE synthesis_return : string ;

end;

package body TEXTIO is
    -- The subprograms declared in the TEXTIO package are
    -- ignored for synthesis.
    -- Assertion warnings will be generated when these
    -- functions are called unconditionally.

    procedure READLINE(file f: TEXT; L: out LINE) is
        ATTRIBUTE synthesis_return OF L:variable IS "readline" ;
       -- verific synthesis readline
    begin
       assert (FALSE) 
          report "Procedure call to READLINE ignored for synthesis" 
          severity WARNING ;
    end READLINE ;

    procedure READ(L:inout LINE; VALUE: out bit; GOOD : out BOOLEAN) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin 
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;
    procedure READ(L:inout LINE; VALUE: out bit) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;

    procedure READ(L:inout LINE; VALUE: out bit_vector; GOOD : out BOOLEAN) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;
    procedure READ(L:inout LINE; VALUE: out bit_vector) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;

    procedure READ(L:inout LINE; VALUE: out BOOLEAN; GOOD : out BOOLEAN) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;
    procedure READ(L:inout LINE; VALUE: out BOOLEAN) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;

    procedure READ(L:inout LINE; VALUE: out character; GOOD : out BOOLEAN) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;
    procedure READ(L:inout LINE; VALUE: out character) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;

    procedure READ(L:inout LINE; VALUE: out integer; GOOD : out BOOLEAN) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;
    procedure READ(L:inout LINE; VALUE: out integer) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;

    procedure READ(L:inout LINE; VALUE: out real; GOOD : out BOOLEAN) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;
    procedure READ(L:inout LINE; VALUE: out real) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;

    procedure READ(L:inout LINE; VALUE: out string; GOOD : out BOOLEAN) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;
    procedure READ(L:inout LINE; VALUE: out string) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;

    procedure READ(L:inout LINE; VALUE: out time; GOOD : out BOOLEAN) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;
    procedure READ(L:inout LINE; VALUE: out time) is
        ATTRIBUTE synthesis_return OF L:variable IS "read" ;
       -- verific synthesis read
    begin
       assert (FALSE) 
          report "Procedure call to READ ignored for synthesis" 
          severity WARNING ;
    end READ ;


    procedure WRITELINE(file F : TEXT; L : inout LINE) is
        ATTRIBUTE synthesis_return OF L:variable IS "writeline" ;
       -- verific synthesis writeline
    begin
       assert (FALSE) 
          report "Procedure call to WRITELINE ignored for synthesis" 
          severity WARNING ;
    end WRITELINE ;

    procedure WRITE(L : inout LINE; VALUE : in bit;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0) is
        ATTRIBUTE synthesis_return OF L:variable IS "write" ;
       -- verific synthesis write
    begin
       assert (FALSE) 
          report "Procedure call to WRITE ignored for synthesis" 
          severity WARNING ;
    end WRITE ;

    procedure WRITE(L : inout LINE; VALUE : in bit_vector;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0) is
        ATTRIBUTE synthesis_return OF L:variable IS "write" ;
       -- verific synthesis write
    begin
       assert (FALSE) 
          report "Procedure call to WRITE ignored for synthesis" 
          severity WARNING ;
    end WRITE ;

    procedure WRITE(L : inout LINE; VALUE : in BOOLEAN;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0) is
        ATTRIBUTE synthesis_return OF L:variable IS "write" ;
       -- verific synthesis write
    begin
       assert (FALSE) 
          report "Procedure call to WRITE ignored for synthesis" 
          severity WARNING ;
    end WRITE ;

    procedure WRITE(L : inout LINE; VALUE : in character;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0) is
        ATTRIBUTE synthesis_return OF L:variable IS "write" ;
       -- verific synthesis write
    begin
       assert (FALSE) 
          report "Procedure call to WRITE ignored for synthesis" 
          severity WARNING ;
    end WRITE ;

    procedure WRITE(L : inout LINE; VALUE : in integer;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0) is
        ATTRIBUTE synthesis_return OF L:variable IS "write" ;
       -- verific synthesis write
    begin
       assert (FALSE) 
          report "Procedure call to WRITE ignored for synthesis" 
          severity WARNING ;
    end WRITE ;

    procedure WRITE(L : inout LINE; VALUE : in real;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0;
	      DIGITS: in NATURAL := 0) is
        ATTRIBUTE synthesis_return OF L:variable IS "write" ;
       -- verific synthesis write
    begin
       assert (FALSE) 
          report "Procedure call to WRITE ignored for synthesis" 
          severity WARNING ;
    end WRITE ;

    procedure WRITE(L : inout LINE; VALUE : in string;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0) is
        ATTRIBUTE synthesis_return OF L:variable IS "write" ;
       -- verific synthesis write
    begin
       assert (FALSE) 
          report "Procedure call to WRITE ignored for synthesis" 
          severity WARNING ;
    end WRITE ;

    procedure WRITE(L : inout LINE; VALUE : in time;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0;
	      UNIT: in TIME := ns) is
        ATTRIBUTE synthesis_return OF L:variable IS "write" ;
       -- verific synthesis write
    begin
       assert (FALSE) 
          report "Procedure call to WRITE ignored for synthesis" 
          severity WARNING ;
    end WRITE ;

--    function ENDFILE (f: in TEXT) return BOOLEAN is
--    begin
--       assert (FALSE) 
--          report "Function call to ENDFILE returns TRUE for synthesis" 
--          severity WARNING ;
--       return TRUE ;
--    end ENDFILE ;
end ;

