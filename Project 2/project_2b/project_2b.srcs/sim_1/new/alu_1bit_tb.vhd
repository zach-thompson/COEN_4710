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

entity alu_1bit_tb is
--  Port ( );
end entity;

architecture Behavioral of alu_1bit_tb is

    -- Including the standard 1-bit unit design
    component ALU_1bit
        port (
            a, b, a_invert, b_invert, CarryIn, less : in STD_LOGIC;
            operation : in STD_LOGIC_VECTOR(1 downto 0);
            result, CarryOut : out STD_LOGIC
            );
    end component;

        -- for U1 : ALU_1bit
        signal a, b, a_invert, b_invert, CarryIn, less : STD_LOGIC;
        signal alu_op : STD_LOGIC_VECTOR(1 downto 0);
        signal result, CarryOut : STD_LOGIC;
    
    begin
    U1 : ALU_1bit port map(a, b, a_invert, b_invert, CarryIn, less, alu_op(1 downto 0), result, CarryOut);
    
    process
    begin
        
        -- Operation 1: AND
        a <= '1';
        b <= '0';
        a_invert <= '0';
        b_invert <= '0';
        CarryIn <= '0';
        less <= '0';
        alu_op <= "00";
        
        wait for 10 ns;
        
        -- Operation 2: OR
        a <= '1';
        b <= '0';
        a_invert <= '0';
        b_invert <= '0';
        CarryIn <= '0';
        less <= '0';
        alu_op <= "01";
        
        wait for 10 ns;
        
        -- Operation 3: ADD
        a <= '0';
        b <= '1';
        a_invert <= '0';
        b_invert <= '0';
        CarryIn <= '0';
        less <= '0';
        alu_op <= "10";
        
        wait for 10 ns;
        
        -- Operation 4: SUB
        a <= '1'; 
        b <= '0';
        a_invert <= '0';
        b_invert <= '1';
        CarryIn <= '1';
        less <= '0';
        alu_op <= "10";
        
        wait for 10 ns;
        
        -- Operation 5: SLT
        a <= '0';
        b <= '1';
        a_invert <= '0';
        b_invert <= '1';
        CarryIn <= '0';
        less <= '1';
        alu_op <= "11";
        
        wait for 10 ns;
        
        -- Operation 6: NOR
        a <= '0';
        b <= '0';
        a_invert <= '1';
        b_invert <= '1';
        CarryIn <= '0';
        less <= '0';
        alu_op <= "00";

        wait for 10 ns;
    
    end process;
        
end Behavioral;
