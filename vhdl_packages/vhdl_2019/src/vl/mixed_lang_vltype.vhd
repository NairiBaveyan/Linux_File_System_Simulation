---------------------------------------------------------------------
-- [$Revision: 1.1 $ - $Date: 2021/05/04 09:56:44 $]
--
-- (c) Copyright 1999 - 2015 Verific Design Automation Inc.
-- All rights reserved.
--
-- This source code belongs to Verific Design Automation Inc.
-- It is considered trade secret and confidential, and is not to be used
-- by parties who have not received written authorization
-- from Verific Design Automation Inc.
-- 
-- Only authorized users are allowed to use, copy and modify
-- this software provided that the above copyright notice
-- remains in all copies of this software.
--
-- This Package vl_types is used to define vl_ulogic and vl_logic
-- type which is used to connect Verilog types with Vhdl types in
-- mixed language designs.
-- It will be compiled into VHDL library 'vl'
---------------------------------------------------------------------

PACKAGE vl_types IS

    -------------------------------------------------------------------    
    -- logic state system  (unresolved)
    -------------------------------------------------------------------    
    TYPE vl_ulogic IS ( 'U',  -- Uninitialized
                         'X',  -- Forcing  Unknown
                         '0',  -- Forcing  0
                         '1',  -- Forcing  1
                         'Z',  -- High Impedance   
                         'W',  -- Weak     Unknown
                         'L',  -- Weak     0       
                         'H',  -- Weak     1       
                         '-'   -- Don't care
                       );

      -------------------------------------------------------------------    
    -- Directives for synthesis of 
    -- Declare the type encoding attribute and set the value for std_ulogic
    -- Directives for the resolution function and all other function are 
    -- in the package body
    -------------------------------------------------------------------    
    ATTRIBUTE logic_type_encoding : string ;
    ATTRIBUTE logic_type_encoding of vl_ulogic:type is
                 -- ('U','X','0','1','Z','W','L','H','-') 
                    ('X','X','0','1','Z','X','0','1','X') ; 

    -------------------------------------------------------------------    
    -- Declare the synthesis-directive attribute; to be set on 
    -- basic functions that are difficult for synthesis 
    -------------------------------------------------------------------    
    ATTRIBUTE synthesis_return : string ;
    ATTRIBUTE is_signed : boolean ;

    -------------------------------------------------------------------
    -- Declare a attribute to identify this to be a vl_ulogic ---------
    ATTRIBUTE verific_is_vltype : boolean ;
    ATTRIBUTE verific_is_vltype of vl_ulogic:type is (true) ;
    -------------------------------------------------------------------
    -------------------------------------------------------------------    
    -- unconstrained array of std_ulogic for use with the resolution function
    -------------------------------------------------------------------    
    TYPE vl_ulogic_vector IS ARRAY ( NATURAL RANGE <> ) OF vl_ulogic;
                                    
    -------------------------------------------------------------------    
    -- resolution function
    -------------------------------------------------------------------    
    FUNCTION resolved ( s : vl_ulogic_vector ) RETURN vl_ulogic;


    -------------------------------------------------------------------    
    -- *** industry standard logic type ***
    -------------------------------------------------------------------    
    SUBTYPE vl_logic IS resolved vl_ulogic;

    -------------------------------------------------------------------    
    -- unconstrained array of vl_logic for use in declaring signal arrays
    -------------------------------------------------------------------    
    TYPE vl_logic_vector IS ARRAY ( NATURAL RANGE <>) OF vl_logic;

    -------------------------------------------------------------------
    -- conversion functions
    -------------------------------------------------------------------
    FUNCTION To_bit       ( s : vl_ulogic;        xmap : BIT := '0') RETURN BIT;
    FUNCTION To_bitvector ( s : vl_logic_vector ; xmap : BIT := '0') RETURN BIT_VECTOR;
    FUNCTION To_bitvector ( s : vl_ulogic_vector; xmap : BIT := '0') RETURN BIT_VECTOR;

    FUNCTION To_VlULogic       ( b : BIT               ) RETURN vl_ulogic;
    FUNCTION To_VlLogicVector  ( b : BIT_VECTOR        ) RETURN vl_logic_vector;
    FUNCTION To_VlLogicVector  ( s : vl_ulogic_vector ) RETURN vl_logic_vector;
    FUNCTION To_VlULogicVector ( b : BIT_VECTOR        ) RETURN vl_ulogic_vector;
    FUNCTION To_VlULogicVector ( s : vl_logic_vector  ) RETURN vl_ulogic_vector;
    FUNCTION to_BitVectorFromCharEnum (s : character) RETURN bit_VECTOR;
    FUNCTION to_BitVectorFromIntegerEnum(s : integer) RETURN BIT_VECTOR;
    FUNCTION to_CharEnumFromBitVector (s : bit_vector) RETURN CHARACTER;
    FUNCTION to_IntegerEnumFromBitVector (s : bit_vector) RETURN INTEGER;

END vl_types;

PACKAGE BODY vl_types IS
    -------------------------------------------------------------------    
    -- local types
    -------------------------------------------------------------------    
    TYPE vllogic_1d IS ARRAY (vl_ulogic) OF vl_ulogic;
    TYPE vllogic_table IS ARRAY(vl_ulogic, vl_ulogic) OF vl_ulogic;

    -------------------------------------------------------------------    
    -- resolution function
    -------------------------------------------------------------------    
    CONSTANT resolution_table : vllogic_table := (
    --      ---------------------------------------------------------
    --      |  U    X    0    1    Z    W    L    H    -        |   |  
    --      ---------------------------------------------------------
            ( 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U' ), -- | U |
            ( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X' ), -- | X |
            ( 'U', 'X', '0', 'X', '0', '0', '0', '0', 'X' ), -- | 0 |
            ( 'U', 'X', 'X', '1', '1', '1', '1', '1', 'X' ), -- | 1 |
            ( 'U', 'X', '0', '1', 'Z', 'W', 'L', 'H', 'X' ), -- | Z |
            ( 'U', 'X', '0', '1', 'W', 'W', 'W', 'W', 'X' ), -- | W |
            ( 'U', 'X', '0', '1', 'L', 'W', 'L', 'W', 'X' ), -- | L |
            ( 'U', 'X', '0', '1', 'H', 'W', 'W', 'H', 'X' ), -- | H |
            ( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X' )  -- | - |
        );
        
    FUNCTION resolved ( s : vl_ulogic_vector ) RETURN vl_ulogic IS
        VARIABLE result : vl_ulogic := 'Z';  -- weakest state default
        ATTRIBUTE synthesis_return OF result:VARIABLE IS "WIRED_THREE_STATE" ;
    BEGIN
        -- the test for a single driver is essential otherwise the
        -- loop would return 'X' for a single driver of '-' and that
        -- would conflict with the value of a single driver unresolved
        -- signal.
        IF    (s'LENGTH = 1) THEN    RETURN s(s'LOW);
        ELSE
            FOR i IN s'RANGE LOOP
                result := resolution_table(result, s(i));
            END LOOP;
        END IF;
        RETURN result;
    END resolved;

    -------------------------------------------------------------------    
    -- conversion functions
    -------------------------------------------------------------------    
    FUNCTION To_bit       ( s : vl_ulogic;        xmap : BIT := '0') RETURN BIT IS
    BEGIN
            CASE s IS
                WHEN '0' | 'L' => RETURN ('0');
                WHEN '1' | 'H' => RETURN ('1');
                WHEN OTHERS => RETURN xmap;
            END CASE;
    END;
    --------------------------------------------------------------------
    FUNCTION To_bitvector ( s : vl_logic_vector ; xmap : BIT := '0') RETURN BIT_VECTOR IS
        ALIAS sv : vl_logic_vector ( s'LENGTH-1 DOWNTO 0 ) IS s;
        VARIABLE result : BIT_VECTOR ( s'LENGTH-1 DOWNTO 0 );
        ATTRIBUTE synthesis_return OF result:VARIABLE IS "FEED_THROUGH" ;
    BEGIN
        FOR i IN result'RANGE LOOP
            CASE sv(i) IS
                WHEN '0' | 'L' => result(i) := '0';
                WHEN '1' | 'H' => result(i) := '1';
                WHEN OTHERS => result(i) := xmap;
            END CASE;
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_bitvector ( s : vl_ulogic_vector; xmap : BIT := '0') RETURN BIT_VECTOR IS
        ALIAS sv : vl_ulogic_vector ( s'LENGTH-1 DOWNTO 0 ) IS s;
        VARIABLE result : BIT_VECTOR ( s'LENGTH-1 DOWNTO 0 );
        ATTRIBUTE synthesis_return OF result:VARIABLE IS "FEED_THROUGH" ;
    BEGIN
        FOR i IN result'RANGE LOOP
            CASE sv(i) IS
                WHEN '0' | 'L' => result(i) := '0';
                WHEN '1' | 'H' => result(i) := '1';
                WHEN OTHERS => result(i) := xmap;
            END CASE;
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_VlULogic       ( b : BIT               ) RETURN vl_ulogic IS
    BEGIN
        CASE b IS
            WHEN '0' => RETURN '0';
            WHEN '1' => RETURN '1';
        END CASE;
    END;
    --------------------------------------------------------------------
    FUNCTION To_VlLogicVector  ( b : BIT_VECTOR        ) RETURN vl_logic_vector IS
        ALIAS bv : BIT_VECTOR ( b'LENGTH-1 DOWNTO 0 ) IS b;
        VARIABLE result : vl_logic_vector ( b'LENGTH-1 DOWNTO 0 );
        ATTRIBUTE synthesis_return OF result:VARIABLE IS "FEED_THROUGH" ;
    BEGIN
        FOR i IN result'RANGE LOOP
            CASE bv(i) IS
                WHEN '0' => result(i) := '0';
                WHEN '1' => result(i) := '1';
            END CASE;
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_VlLogicVector  ( s : vl_ulogic_vector ) RETURN vl_logic_vector IS
        ALIAS sv : vl_ulogic_vector ( s'LENGTH-1 DOWNTO 0 ) IS s;
        VARIABLE result : vl_logic_vector ( s'LENGTH-1 DOWNTO 0 );
        ATTRIBUTE synthesis_return OF result:VARIABLE IS "FEED_THROUGH" ;
    BEGIN
        FOR i IN result'RANGE LOOP
            result(i) := sv(i);
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_VlULogicVector ( b : BIT_VECTOR        ) RETURN vl_ulogic_vector IS
        ALIAS bv : BIT_VECTOR ( b'LENGTH-1 DOWNTO 0 ) IS b;
        VARIABLE result : vl_ulogic_vector ( b'LENGTH-1 DOWNTO 0 );
        ATTRIBUTE synthesis_return OF result:VARIABLE IS "FEED_THROUGH" ;
    BEGIN
        FOR i IN result'RANGE LOOP
            CASE bv(i) IS
                WHEN '0' => result(i) := '0';
                WHEN '1' => result(i) := '1';
            END CASE;
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_VlULogicVector ( s : vl_logic_vector ) RETURN vl_ulogic_vector IS
        ALIAS sv : vl_logic_vector ( s'LENGTH-1 DOWNTO 0 ) IS s;
        VARIABLE result : vl_ulogic_vector ( s'LENGTH-1 DOWNTO 0 );
        ATTRIBUTE synthesis_return OF result:VARIABLE IS "FEED_THROUGH" ;
    BEGIN
        FOR i IN result'RANGE LOOP
            result(i) := sv(i);
        END LOOP;
        RETURN result;
    END;
    FUNCTION to_BitVectorFromCharEnum(s : CHARACTER) RETURN BIT_VECTOR Is
	VARIABLE v : INTEGER := CHARACTER'pos(s);
	VARIABLE return_vec : BIT_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
     BEGIN
	FOR i IN 0 TO 7 LOOP
	    IF (v MOD 2) /= 0 THEN 
		return_vec(i) := '1';
	    END IF;
	    v := v/2;
	END LOOP;
	RETURN return_vec;
     END to_BitVectorFromCharEnum;

     FUNCTION to_BitVectorFromIntegerEnum(s : integer) RETURN BIT_VECTOR IS
	VARIABLE v : INTEGER := s;
	VARIABLE return_vec : BIT_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
     BEGIN
	FOR i in 0 to 31 LOOP
	    IF (v mod 2) /= 0 THEN 
		return_vec(i) := '1';
	    END IF;
	    v := v/2;
	END LOOP;
	RETURN return_vec;
     END to_BitVectorFromIntegerEnum;

     FUNCTION to_CharEnumFromBitVector (s : BIT_VECTOR) RETURN character is
	variable len : INTEGER;
	variable result : INTEGER := 0;
     BEGIN
	IF (s'length < 8) then
	    len := s'length;
	else
	    len := 8;
	END IF;

	for i in 0 to len - 1 loop
	    IF s(i) = '1' then
		result := result + 2**i;
	    END IF;
	END loop;
	RETURN character'val(result);
     END to_CharEnumFromBitVector;

     FUNCTION to_IntegerEnumFromBitVector (s : BIT_VECTOR) RETURN INTEGER is
	VARIABLE len : INTEGER;
	VARIABLE result : INTEGER := 0;
     BEGIN
	for i IN 0 to s'length LOOP
	    IF s(i) = '1' THEN
		result := result + 2**i;
	    END IF;
	END LOOP;
	RETURN result;
     END to_IntegerEnumFromBitVector;
END vl_types;
