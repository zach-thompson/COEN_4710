-- 4-bit Adder Testbench
-- A testbench is used to rigorously tests a design that you have made.
-- The output of the testbench should allow the designer to see if
-- the design worked.  The testbench should also report where the testbench
-- failed.

-- This is just to make a reference to some common things needed.

LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Declare a testbench.  Notice that the testbench does not have any
-- input or output ports. 

entity TEST_FOURBIT_ADDER is
end TEST_FOURBIT_ADDER;

-- Describes the functionality of the tesbench.

architecture MY_TEST of TEST_FOURBIT_ADDER is 

	component bi_32_adder
		port( a, b	: in    STD_LOGIC_VECTOR(31 downto 0);
		      z		: out	STD_LOGIC_VECTOR(31 downto 0);
		      cout	: out 	STD_LOGIC);
	end component;

	for U1: bi_32_adder use entity WORK.BI_32_ADDER(MY_STRUCTURE);
	signal a, b	: STD_LOGIC_VECTOR(31 downto 0);
	signal z	: STD_LOGIC_VECTOR(31 downto 0);
	signal cout	: STD_LOGIC;
	
	begin
	U1: bi_32_adder port map (a,b,z,cout);
	
		process
		begin

		-- Case 1 that we are testing.

			a <= "00000000000000000000000000010100";
			b <= "00000000000000000000000000011110";
			wait for 10 ns;
			assert ( z = "00000000000000000000000000110010" )	report "Failed Case 1 - z" severity error;
			assert ( Cout = '0' )   report "Failed Case 1 - Cout" severity error;
			wait for 40 ns;

		-- Case 2 that we are testing.

			a <= "00000000000000000000000000001110";
			b <= "00000000000000000000000000101011";
			wait for 10 ns;
			assert ( z = "00000000000000000000000000111001" )	report "Failed Case 2 - z" severity error;
			assert ( Cout = '0' )   report "Failed Case 2 - Cout" severity error;
			wait for 40 ns;
		end process;
END MY_TEST;