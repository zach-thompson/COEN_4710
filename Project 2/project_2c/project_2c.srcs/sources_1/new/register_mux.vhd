----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2021 09:33:39 AM
-- Design Name: 
-- Module Name: register_mux - Behavioral
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

entity register_mux is
  Port (
        read_data_2, ImmGen_out : IN STD_LOGIC_VECTOR(31 downto 0);
        ALUSrc : IN STD_LOGIC;
		register_mux_out : OUT STD_LOGIC_VECTOR(31 downto 0)
        );
end register_mux;

architecture Behavioral of register_mux is

begin

    register_mux_out <= read_data_2 WHEN ALUSrc = '0' ELSE ImmGen_out;

end Behavioral;
