--
--
-- This is Package ENV as defined in the VHDL 2008 Language Reference Manual.
-- It will be compiled into VHDL library 'std'
--
-- Version information: @(#)env_2008.vhd
--
package ENV is
    procedure STOP (STATUS: INTEGER);
    procedure STOP;
    procedure FINISH (STATUS: INTEGER);
    procedure FINISH;
    function  RESOLUTION_LIMIT  return  DELAY_LENGTH;
end package ENV;

package body ENV is

procedure STOP (STATUS: INTEGER) is
    -- verific synthesis ignore_subprogram
  begin
  end procedure STOP ;

procedure STOP is
    -- verific synthesis ignore_subprogram
  begin
  end procedure STOP ;

procedure FINISH (STATUS: INTEGER) is
    -- verific synthesis ignore_subprogram
  begin
  end procedure FINISH ;

procedure FINISH  is
    -- verific synthesis ignore_subprogram
  begin
  end procedure FINISH ;

function RESOLUTION_LIMIT return DELAY_LENGTH is
  begin
    return 0 fs ;
  end function RESOLUTION_LIMIT;

end package body ENV;
