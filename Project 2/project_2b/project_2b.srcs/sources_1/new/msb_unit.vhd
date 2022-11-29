----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2021 05:55:51 PM
-- Design Name: 
-- Module Name: msb_unit - Behavioral
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

entity ALU_MSB is
    port (
        a, b, a_invert, b_invert, CarryIn, less : in STD_LOGIC;
        operation : in STD_LOGIC_VECTOR(1 downto 0);
        result, set, msb_overflow : out STD_LOGIC
        );
end ALU_MSB;

architecture Behavioral of ALU_MSB is

signal mux_a_out, a_bar : STD_LOGIC;
signal mux_b_out, b_bar : STD_LOGIC;
signal temp_CarryOut : STD_LOGIC;

begin
   
    a_bar <= not a;
    b_bar <= not b;
   
   -- process describing mux a
    process (a_bar, a, a_invert) is
    begin
       if (a_invert = '0') then mux_a_out <= a;
       else mux_a_out <= a_bar;
       end if;
    end process;
     
    -- process describing mux b
    process (b_bar, b, b_invert) is
    begin
       if (b_invert = '0') then mux_b_out <= b;
       else mux_b_out <= b_bar;
       end if;
    end process;
    
    -- This process implements the invert muxes as well as the AND, OR, and arithmetic gates
    process (a_invert, b_invert, mux_a_out, mux_b_out, less, operation, CarryIn) is
    begin

        if (a_invert = '0' AND b_invert = '0' AND operation = "00") then -- AND
            result <= mux_a_out AND mux_b_out;
        elsif (a_invert = '0' AND b_invert = '0' AND operation = "01") then -- OR
            result <= mux_a_out OR mux_b_out;
        elsif (a_invert = '0' AND b_invert = '0' AND operation = "10") then  -- ADD
            result <= (mux_a_out XOR mux_b_out) XOR CarryIn;
        elsif (a_invert = '0' AND b_invert = '1' AND operation = "10") then -- SUB
            result <= (mux_a_out XOR mux_b_out) XOR (CarryIn);
        elsif (a_invert = '0' AND b_invert = '1' AND operation = "11") then -- SLT
            result <= less;
        elsif (a_invert = '1' AND b_invert = '1' AND operation = "00") then -- NOR
            result <= mux_a_out AND mux_b_out;
        else
            result <= '0';
        end if;
    
        set <= (mux_a_out XOR mux_b_out) XOR CarryIn;
        temp_CarryOut  <= (mux_a_out AND mux_b_out) OR (mux_a_out AND CarryIn) OR (mux_b_out AND CarryIn);
    
    end process;
 
    msb_overflow <= CarryIn XOR temp_CarryOut;

end Behavioral;
