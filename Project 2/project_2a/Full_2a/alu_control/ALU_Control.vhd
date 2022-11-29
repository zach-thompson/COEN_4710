

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ALU_Control is
 Port ( 
        func_73 : in signed(9 downto 0);
        alu_opin : in STD_LOGIC_VECTOR (1 downto 0);
        alu_op : out signed(3 downto 0)
       );

end ALU_Control;

architecture Behavioral of ALU_Control is

process
begin

if alu_opin => 00 then
    alu_op <= '0010'
    
elseif alu_opin(0) => 1 then
    alu_op <= '0110'
    
elseif alu_opin(1) => 1 && func_73 => '0000000000' then
    alu_op <= '0010'
    
elseif alu_opin(1) => 1 && func_73 => '0100000000' then
    alu_op <= '0110'
    
elseif alu_opin(1) => 1  && func_73 => '0000000111' then
    alu_op <= '0000'
    
else alu_opin(1) => 1 && func_73 => '0000000110' then
    alu_op <= '0001'

end if;

end process;

end Behavioral;

