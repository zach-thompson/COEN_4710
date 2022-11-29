----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2021 10:13:53 PM
-- Design Name: 
-- Module Name: RISCV_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RISCV_tb is
--  Port ( );
end RISCV_tb;

architecture Behavioral of RISCV_tb is

    component RISCV_main is
        Port (
            reset, clk : in STD_LOGIC
            );
    end component;

    signal reset : STD_LOGIC;
    signal clk : STD_LOGIC;
    
begin
    
    U1 : RISCV_main port map (reset, clk);
    
    process
    begin
        clk <= '0';
        reset <= '1';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        reset <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;
        
    end process;
end Behavioral;
