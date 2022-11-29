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

entity data_mux is
  Port (
        read_data, alu_result : IN STD_LOGIC_VECTOR(31 downto 0);
        MemToReg : IN STD_LOGIC;
		data_mux_out : OUT STD_LOGIC_VECTOR(31 downto 0)
        );
end data_mux;

architecture Behavioral of data_mux is

begin

    data_mux_out <= read_data WHEN MemToREg = '1' ELSE alu_result;

end Behavioral;
