-- -----------------------------------------------------------------
-- 
-- Copyright 2019 IEEE P1076 WG Authors
-- 
-- See the LICENSE file distributed with this work for copyright and
-- licensing information and the AUTHORS file.
-- 
-- This file to you under the Apache License, Version 2.0 (the "License").
-- You may obtain a copy of the License at
-- 
--     http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
-- implied.  See the License for the specific language governing
-- permissions and limitations under the License.
-- 
--   Library   :  This package shall be compiled into a library
--             :  symbolically named std.
--             :
--   Developers:  IEEE P1076 Working Group
--             :
--   Purpose   :  This packages defines subprograms for file I/O
--             :
--   Note      :  This package may be modified to include additional data
--             :  required by tools, but it must in no way change the
--             :  external interfaces or simulation behavior of the
--             :  description. It is permissible to add comments and/or
--             :  attributes to the package declarations, but not to change
--             :  or delete any original lines of the package declaration.
--             :  The package body may be changed only in accordance with
--             :  the terms of Clause 16 of this standard.
--             :
-- --------------------------------------------------------------------

package TEXTIO is
  -- Type definitions for text I/O:
  type LINE is access STRING; -- A LINE is a pointer to a STRING value.
  -- The predefined operations for this type are as follows:
  -- function"=" (anonymous, anonymous: LINE) return BOOLEAN;
  -- function"/=" (anonymous, anonymous: LINE) return BOOLEAN;
  -- procedure DEALLOCATE (P: inout LINE);

 type LINE_VECTOR is array(NATURAL range <>) of LINE;
  -- The predefined operations for this type are as follows:
  -- function "="(anonymous, anonymous: LINE_VECTOR) return BOOLEAN;
  -- function "/="(anonymous, anonymous: LINE_VECTOR) return BOOLEAN;
  -- function "&"(anonymous: LINE_VECTOR; anonymous: LINE_VECTOR) return LINE_VECTOR;
  -- function "&"(anonymous: LINE_VECTOR; anonymous: LINE) return LINE_VECTOR;
  -- function "&"(anonymous: LINE; anonymous: LINE_VECTOR) return LINE_VECTOR;
  -- function "&"(anonymous: LINE; anonymous: LINE) return LINE_VECTOR;

  type TEXT is file of STRING; -- A file of variable-length ASCII records.
  -- The predefined operations for this type are as follows:
  -- procedure FILE_OPEN (file F: TEXT; External_Name; in STRING; Open_Kind: in FILE_OPEN_KIND := READ_MODE);
  -- procedure FILE_OPEN (Status: out FILE_OPEN_STATUS; file F: TEXT; External_Name: in STRING; Open_Kind: in FILE_OPEN_KIND := READ_MODE);
  -- procedure FILE_REWIND (file F: FT);
  -- procedure FILE_SEEK (file F: FT; Offset : INTEGER; Origin : FILE_ORIGIN_KIND := FILE_ORIGIN_BEGIN);
  -- procedure FILE_TRUNCATE (file F: FT; Size : INTEGER; Origin : FILE_ORIGIN_KIND := FILE_ORIGIN_BEGIN);
  -- function  FILE_MODE (file F: FT) return FILE_OPEN_KIND;
  -- function  FILE_TELL (file F: FT; Origin : FILE_ORIGIN_KIND := FILE_ORIGIN_BEGIN) return INTEGER;
  -- function  FILE_SIZE (file F: FT) return INTEGER;
  -- procedure FILE_CLOSE (file F: TEXT);
  -- procedure READ (file F: TEXT; VALUE: out STRING);
  -- procedure WRITE (file F: TEXT; VALUE: in STRING);
  -- procedure FLUSH (file F: TEXT);
  -- function  ENDFILE (file F: TEXT) return BOOLEAN;

  type SIDE is (RIGHT, LEFT); -- For justifying output data within fields.
  -- The predefined operations for this type are as follows:
  -- function "=" (anonymous, anonymous: SIDE) return BOOLEAN;
  -- function "/=" (anonymous, anonymous: SIDE) return BOOLEAN;
  -- function "<" (anonymous, anonymous: SIDE) return BOOLEAN;
  -- function "<=" (anonymous, anonymous: SIDE) return BOOLEAN;
  -- function ">" (anonymous, anonymous: SIDE) return BOOLEAN;
  -- function ">=" (anonymous, anonymous: SIDE) return BOOLEAN;
  -- function MINIMUM (L, R: SIDE) return SIDE;
  -- function MAXIMUM (L, R: SIDE) return SIDE;
  -- function TO_STRING (VALUE: SIDE) return STRING;

  subtype WIDTH is NATURAL; -- For specifying widths of output fields.
  function JUSTIFY (VALUE: STRING; JUSTIFIED: SIDE := RIGHT; FIELD: WIDTH := 0 ) return STRING;
  -- Standard text files:
  file INPUT: TEXT open READ_MODE is "STD_INPUT";
  file OUTPUT: TEXT open WRITE_MODE is "STD_OUTPUT";

  -- Input routines for standard types:
  procedure READLINE (file F: TEXT; L: inout LINE);
  
  procedure READ (L: inout LINE; VALUE: out BIT; GOOD: out BOOLEAN);
  procedure READ (L: inout LINE; VALUE: out BIT);
  
  procedure READ (L: inout LINE; VALUE: out BIT_VECTOR; GOOD: out BOOLEAN);
  procedure READ (L: inout LINE; VALUE: out BIT_VECTOR);
  
  procedure READ (L: inout LINE; VALUE: out BOOLEAN; GOOD: out BOOLEAN);
  procedure READ (L: inout LINE; VALUE: out BOOLEAN);
  
  procedure READ (L: inout LINE; VALUE: out CHARACTER; GOOD: out BOOLEAN);
  procedure READ (L: inout LINE; VALUE: out CHARACTER);
  
  procedure READ (L: inout LINE; VALUE: out INTEGER; GOOD: out BOOLEAN);
  procedure READ (L: inout LINE; VALUE: out INTEGER);
  
  procedure READ (L: inout LINE; VALUE: out REAL; GOOD: out BOOLEAN);
  procedure READ (L: inout LINE; VALUE: out REAL);
  
  procedure READ (L: inout LINE; VALUE: out STRING; GOOD: out BOOLEAN);
  procedure READ (L: inout LINE; VALUE: out STRING);
  
  procedure READ (L: inout LINE; VALUE: out TIME; GOOD: out BOOLEAN);
  procedure READ (L: inout LINE; VALUE: out TIME);
  
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

  -- Output routines for standard types:
  procedure WRITELINE (file F: TEXT; L: inout LINE);
  
  procedure TEE (file F: TEXT; L: inout LINE);
  
  procedure WRITE (L: inout LINE; VALUE: in BIT; JUSTIFIED: in SIDE:= RIGHT; FIELD: in WIDTH := 0);
  procedure WRITE (L: inout LINE; VALUE: in BIT_VECTOR; JUSTIFIED: in SIDE:= RIGHT; FIELD: in WIDTH := 0);
  procedure WRITE (L: inout LINE; VALUE: in BOOLEAN; JUSTIFIED: in SIDE:= RIGHT; FIELD: in WIDTH := 0);
  procedure WRITE (L: inout LINE; VALUE: in CHARACTER; JUSTIFIED: in SIDE:= RIGHT; FIELD: in WIDTH := 0);
  procedure WRITE (L: inout LINE; VALUE: in INTEGER; JUSTIFIED: in SIDE:= RIGHT; FIELD: in WIDTH := 0);
  procedure WRITE (L: inout LINE; VALUE: in REAL; JUSTIFIED: in SIDE:= RIGHT; FIELD: in WIDTH := 0; DIGITS: in NATURAL:= 0);
  procedure WRITE (L: inout LINE; VALUE: in REAL; FORMAT: in STRING);
  procedure WRITE (L: inout LINE; VALUE: in STRING; JUSTIFIED: in SIDE:= RIGHT; FIELD: in WIDTH := 0);
  procedure WRITE (L: inout LINE; VALUE: in TIME; JUSTIFIED: in SIDE:= RIGHT; FIELD: in WIDTH := 0; UNIT: in TIME:= ns);
  
  alias SWRITE is WRITE [LINE, STRING, SIDE, WIDTH];
  alias STRING_WRITE is WRITE [LINE, STRING, SIDE, WIDTH];
  
  alias BWRITE is WRITE [LINE, BIT_VECTOR, SIDE, WIDTH];
  alias BINARY_WRITE is WRITE [LINE, BIT_VECTOR, SIDE, WIDTH];
  
  procedure OWRITE (L: inout LINE; VALUE: in BIT_VECTOR; JUSTIFIED: in SIDE := RIGHT; FIELD: in WIDTH := 0);
  alias OCTAL_WRITE is OWRITE [LINE, BIT_VECTOR, SIDE, WIDTH];
  procedure HWRITE (L: inout LINE; VALUE: in BIT_VECTOR; JUSTIFIED: in SIDE := RIGHT; FIELD: in WIDTH := 0);
  alias HEX_WRITE is HWRITE [LINE, BIT_VECTOR, SIDE, WIDTH];

    -------------------------------------------------------------------    
    -- Declare the textio directive attribute; to be set on 
    -- basic functions that have a 'builtin' implementation for elaboration
    -------------------------------------------------------------------    
    ATTRIBUTE synthesis_return : string ;
  
end package TEXTIO;


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

    procedure READLINE(file f: TEXT; L: inout LINE) is
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

    procedure WRITE(L : inout LINE; VALUE : in real;
	      FORMAT: in STRING) is
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

end ;

