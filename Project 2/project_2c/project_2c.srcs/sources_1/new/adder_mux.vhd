----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2021 09:47:59 AM
-- Design Name: 
-- Module Name: adder_mux - Behavioral
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

entity adder_mux is
  Port (
        pc_adder_out, bit32_adder : IN STD_LOGIC_VECTOR(31 downto 0);
        branch_AND_zero : IN STD_LOGIC;
        adder_mux_out : OUT STD_LOGIC_VECTOR(31 downto 0)
        );
end adder_mux;

architecture Behavioral of adder_mux is

begin

    adder_mux_out <= pc_adder_out WHEN branch_AND_zero = '0' ELSE bit32_adder;
    
end Behavioral;
