----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2021 05:36:09 PM
-- Design Name: 
-- Module Name: alu_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_tb is
--  Port ( );
end alu_tb;

architecture Behavioral of alu_tb is

    component alu_main is
     Port (
        a, b : in STD_LOGIC_VECTOR(31 downto 0);
        alu_op : in STD_LOGIC_VECTOR(3 downto 0);
        zero, overflow : out STD_LOGIC;
        result : out STD_LOGIC_VECTOR(31 downto 0)
          );
    end component;

        -- for U1 : alu_main
        signal a, b : STD_LOGIC_VECTOR(31 downto 0);
        signal alu_op : STD_LOGIC_VECTOR(3 downto 0);
        signal zero, overflow : STD_LOGIC;
        signal result : STD_LOGIC_VECTOR(31 downto 0);
    
    begin
    U1 : alu_main port map (a, b, alu_op, zero, overflow, result);
    
    process
    begin
        
        -- Operation 1: AND
        a <= "00000000000000000000000000000101";
        b <= "00000000000000000000000000000001";
        alu_op <= "0000";
        
        wait for 10 ns;
        
        -- Operation 2: OR
        a <= "00000000000000000000000000000011";
        b <= "00000000000000000000000000000101";
        alu_op <= "0001";
        
        wait for 10 ns;
        
        -- Operation 3: ADD
        a <= "00000000000000000000000000000111";
        b <= "00000000000000000000000000000001";
        alu_op <= "0010";
        
        wait for 10 ns;
        
        -- Operation 4: SUB
        a <= "00000000000000000000000000001011";
        b <= "00000000000000000000000000000101";
        alu_op <= "0110";
        
        wait for 10 ns;
        
        -- Operation 5: SLT
        a <= "00000000000000000000000000000011";
        b <= "00000000000000000000000000000100";
        alu_op <= "0111";
        
        wait for 10 ns;
        
        -- Operation 6: NOR
        a <= "00000000000000000000000000000011";
        b <= "00000000000000000000000000000001";
        alu_op <= "1100";

        wait for 10 ns;
    
        -- Operation 7: )verflow check
        a <= "01111111111111111111111111111111";
        b <= "00000000000000000000000000000001";
        alu_op <= "0010";
        
        wait for 10 ns;
        
        -- Operation 8: Zero check
        a <= "00000000000000000000000000001001";
        b <= "00000000000000000000000000000010";
        alu_op <= "0000";
        
        wait for 10 ns;
        
    end process;
        
end Behavioral;
