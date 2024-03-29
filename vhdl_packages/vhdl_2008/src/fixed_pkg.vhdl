-- --------------------------------------------------------------------
--
-- Copyright � 2008 by IEEE. All rights reserved.
--
-- This source file is an essential part of IEEE Std 1076-2008, 
-- IEEE Standard VHDL Language Reference Manual. Verbatim copies of This
-- source file may be used and distributed without restriction.
-- Modifications to this source file as permitted in IEEE Std 1076-2008
-- may also be made and distributed. All other uses require permission
-- from the IEEE Standards Department(stds-ipr@ieee.org). 
-- All other rights reserved.
-- 
--   Title     :  Fixed-point package (Instantiated package declaration)
--             :
--   Library   :  This package shall be compiled into a library
--             :  symbolically named IEEE.
--             :
--   Developers:  Accellera VHDL-TC and IEEE P1076 Working Group
--             :
--   Purpose   :  This packages defines basic binary fixed point
--             :  arithmetic functions
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
-- $Revision: 1.2 $
-- $Date: 2014/08/22 18:52:03 $
-- --------------------------------------------------------------------

library IEEE;

package fixed_pkg is new IEEE.fixed_generic_pkg
  generic map (
    fixed_round_style    => IEEE.fixed_float_types.fixed_round,
    fixed_overflow_style => IEEE.fixed_float_types.fixed_saturate,
    fixed_guard_bits     => 3,
    no_warning           => false
    );
