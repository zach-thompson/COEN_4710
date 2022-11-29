----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2021
-- Design Name: 
-- Module Name: alu_main - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity alu_main is
  Port (
      a, b : in STD_LOGIC_VECTOR(31 downto 0);
      alu_op : in STD_LOGIC_VECTOR(3 downto 0);
      zero, overflow : out STD_LOGIC;
      result : out STD_LOGIC_VECTOR(31 downto 0)
      );
end alu_main;

architecture ALU_structure of alu_main is

-- Including the standard 1-bit unit design
component ALU_1bit
    port (
        a, b, a_invert, b_invert, CarryIn, less: in STD_LOGIC;
        operation : in STD_LOGIC_VECTOR(1 downto 0);
        result, CarryOut : out STD_LOGIC
        );
end component;

-- Including the MSB 1-bit unit design
component ALU_MSB
    port (
        a, b, a_invert, b_invert, CarryIn, less : in STD_LOGIC;
        operation : in STD_LOGIC_VECTOR(1 downto 0);
        result, set, msb_overflow : out STD_LOGIC
        );
end component;

-- Create a signal to pass the carryout bit from one standard_unit to the next
signal i_carry : STD_LOGIC_VECTOR(31 downto 0);
signal i_less : STD_LOGIC;
signal i_set : STD_LOGIC;
signal i_msb_overflow : STD_LOGIC;
signal i_result : STD_LOGIC_VECTOR(31 downto 0);

begin

    process (alu_op) is
    begin
        if alu_op = "0110" then i_carry(0) <= '1';
        else i_carry(0) <= '0';
        end if;
    end process;
   
    i_less <= '0';
    LSB_unit : ALU_1bit port map (
        a => a(0), 
        b => b(0),
        a_invert => alu_op(3),
        b_invert => alu_op(2),
        CarryIn => i_carry(0),
        less => i_set,
        operation => alu_op(1 downto 0),
        result => i_result(0),
        CarryOut => i_carry(1));
        
    this_loop : FOR i IN 1 to 30 GENERATE
        general_units : ALU_1bit port map (
        a => a(i),
        b => b(i),
        a_invert => alu_op(3),
        b_invert => alu_op(2),
        CarryIn => i_carry(i),
        less => i_less,
        operation => alu_op(1 downto 0),
        result => i_result(i),
        CarryOut => i_carry(i + 1));
        end GENERATE this_loop;
        
    msb : ALU_MSB port map (
        a => a(31), 
        b => b(31),
        a_invert => alu_op(3),
        b_invert => alu_op(2),
        CarryIn => i_carry(31),
        less => i_less,
        operation => alu_op(1 downto 0),
        result => i_result(31),
        set => i_set,
        msb_overflow => overflow);

    result <= i_result;
    zero <= '1' when i_result = "00000000000000000000000000000000" else '0';
        
end ALU_structure;
