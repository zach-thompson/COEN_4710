----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2021 11:12:09 PM
-- Design Name: 
-- Module Name: immgen_tb - Behavioral
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

entity immgen_tb is
--  Port ( );
end immgen_tb;

architecture Behavioral of immgen_tb is

    component Imm_Gen is
        Port ( 
            InstrCode    : in STD_LOGIC_VECTOR (31 downto 0);
            ImmOut       : out STD_LOGIC_VECTOR (31 downto 0)
            );
    end component;

    signal InstrCode : STD_LOGIC_VECTOR (31 downto 0);
    signal ImmOut : STD_LOGIC_VECTOR (31 downto 0);
    
begin

U1 : Imm_Gen port map (InstrCode, ImmOut);
    
    process
    begin
        
        -- Operation 1: AND
        InstrCode <= "11111110000000000001111110010011";
               
        wait for 10 ns;
    end process;
    
end Behavioral;
