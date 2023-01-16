
---------------------------------------------------------------------------
---------------------------------------------------------------------------
--  This is Package TEXTIO as defined in Chapter 16.4 of the 
--  IEEE Standard VHDL Language Reference Manual (IEEE Std. 1076-2008)
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

    function JUSTIFY(VALUE: STRING;
                     JUSTIFIED: SIDE := RIGHT;
                     FIELD: WIDTH := 0) return STRING;

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

    procedure SREAD (L: inout LINE; VALUE: out STRING; STRLEN: out NATURAL);
    alias STRING_READ is SREAD [LINE, STRING, NATURAL];

    alias BREAD is READ [LINE, BIT_VECTOR, BOOLEAN];
    alias BREAD is READ [LINE, BIT_VECTOR];

    alias BINARY_READ is READ [LINE, BIT_VECTOR, BOOLEAN];
    alias BINARY_READ is READ [LINE, BIT_VECTOR];

    procedure OREAD (L: inout LINE; VALUE: out BIT_VECTOR; GOOD: out BOOLEAN);
    procedure OREAD (L: inout LINE; VALUE: out BIT_VECTOR);

    alias OCTAL_READ is OREAD [LINE, BIT_VECTOR, BOOLEAN];
    alias OCTAL_READ is OREAD [LINE, BIT_VECTOR];

    procedure HREAD (L: inout LINE; VALUE: out BIT_VECTOR; GOOD: out BOOLEAN);
    procedure HREAD (L: inout LINE; VALUE: out BIT_VECTOR);

    alias HEX_READ is HREAD [LINE, BIT_VECTOR, BOOLEAN];
    alias HEX_READ is HREAD [LINE, BIT_VECTOR];

    -- Output Routines for Standard Types

    procedure WRITELINE(file F : TEXT; L : inout LINE);

    procedure TEE (file F: TEXT; L: inout LINE);
 
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

    alias SWRITE is WRITE [LINE, STRING, SIDE, WIDTH];
    alias STRING_WRITE is WRITE [LINE, STRING, SIDE, WIDTH];

    alias BWRITE is WRITE [LINE, BIT_VECTOR, SIDE, WIDTH];
    alias BINARY_WRITE is WRITE [LINE, BIT_VECTOR, SIDE, WIDTH];

    procedure OWRITE (L: inout LINE; VALUE: in BIT_VECTOR;
                      JUSTIFIED: in SIDE := RIGHT;
                      FIELD: in WIDTH := 0);

    alias OCTAL_WRITE is OWRITE [LINE, BIT_VECTOR, SIDE, WIDTH];

    procedure HWRITE (L: inout LINE; VALUE: in BIT_VECTOR;
                      JUSTIFIED: in SIDE := RIGHT;
                      FIELD: in WIDTH := 0);

    alias HEX_WRITE is HWRITE [LINE, BIT_VECTOR, SIDE, WIDTH];

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

    function JUSTIFY(VALUE: STRING;
                     JUSTIFIED: SIDE := RIGHT;
                     FIELD: WIDTH := 0) return STRING is
        variable ret_str : string(1 to FIELD) := (others => ' ') ;
        variable len : integer := VALUE'length ;
    begin
        -- 1076-2008 section 16.4
        -- actual field width will always be at least large 
        -- enough to hold the string value, the default value 0 
        -- for the FIELD parameter has the effect of causing the 
        -- string value to be contained in a field of exactly 
        -- the right width
        if (FIELD <= len) then
          return VALUE ;
        end if ;

        -- write 'value' left or right justified
        -- space for the remaining characters in the field
        if (JUSTIFIED = LEFT) then
          ret_str(1 to len) := VALUE ;
        else
          ret_str(FIELD-len+1 to FIELD) := VALUE ;
        end if ;

        return ret_str ;
    end JUSTIFY ;

  
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
    procedure OREAD(L:inout LINE; VALUE: out BIT_VECTOR; GOOD: out BOOLEAN) is
        ATTRIBUTE synthesis_return OF L:variable IS "oread" ;
       -- verific synthesis oread
    begin
       assert (FALSE) 
          report "Procedure call to OREAD ignored for synthesis" 
          severity WARNING ;
    end OREAD ;
    procedure OREAD(L:inout LINE; VALUE: out BIT_VECTOR) is
        ATTRIBUTE synthesis_return OF L:variable IS "oread" ;
       -- verific synthesis oread
    begin
       assert (FALSE) 
          report "Procedure call to OREAD ignored for synthesis" 
          severity WARNING ;
    end OREAD ;
    procedure HREAD(L:inout LINE; VALUE: out BIT_VECTOR; GOOD: out BOOLEAN) is
        ATTRIBUTE synthesis_return OF L:variable IS "hread" ;
       -- verific synthesis hread
    begin
       assert (FALSE) 
          report "Procedure call to HREAD ignored for synthesis" 
          severity WARNING ;
    end HREAD ;
    procedure HREAD(L:inout LINE; VALUE: out BIT_VECTOR) is
        ATTRIBUTE synthesis_return OF L:variable IS "hread" ;
       -- verific synthesis hread
    begin
       assert (FALSE) 
          report "Procedure call to HREAD ignored for synthesis" 
          severity WARNING ;
    end HREAD ;
    procedure SREAD(L:inout LINE; VALUE: out STRING; STRLEN: out NATURAL) is
        ATTRIBUTE synthesis_return OF L:variable IS "sread" ;
       -- verific synthesis sread
    begin
       assert (FALSE) 
          report "Procedure call to SREAD ignored for synthesis" 
          severity WARNING ;
    end SREAD ;


    procedure WRITELINE(file F : TEXT; L : inout LINE) is
        ATTRIBUTE synthesis_return OF L:variable IS "writeline" ;
       -- verific synthesis writeline
    begin
       assert (FALSE) 
          report "Procedure call to WRITELINE ignored for synthesis" 
          severity WARNING ;
    end WRITELINE ;

    procedure TEE(file F : TEXT; L : inout LINE) is
        ATTRIBUTE synthesis_return OF L:variable IS "tee" ;
       -- verific synthesis writeline
    begin
       assert (FALSE) 
          report "Procedure call to TEE ignored for synthesis" 
          severity WARNING ;
    end TEE ;

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

    procedure OWRITE(L : inout LINE; VALUE : in BIT_VECTOR;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0) is
        ATTRIBUTE synthesis_return OF L:variable IS "owrite" ;
       -- verific synthesis owrite
    begin
       assert (FALSE) 
          report "Procedure call to OWRITE ignored for synthesis" 
          severity WARNING ;
    end OWRITE ;

    procedure HWRITE(L : inout LINE; VALUE : in BIT_VECTOR;
	      JUSTIFIED: in SIDE := right;
	      FIELD: in WIDTH := 0) is
        ATTRIBUTE synthesis_return OF L:variable IS "hwrite" ;
       -- verific synthesis hwrite
    begin
       assert (FALSE) 
          report "Procedure call to HWRITE ignored for synthesis" 
          severity WARNING ;
    end HWRITE ;

--    function ENDFILE (f: in TEXT) return BOOLEAN is
--    begin
--       assert (FALSE) 
--          report "Function call to ENDFILE returns TRUE for synthesis" 
--          severity WARNING ;
--       return TRUE ;
--    end ENDFILE ;
end ;

