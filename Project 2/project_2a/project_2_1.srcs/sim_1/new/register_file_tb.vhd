-- register_file testbench

LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Declare a testbench.  Notice that the testbench does not have any
-- input or output ports. 

entity TEST_REGISTER_FILE is
end TEST_REGISTER_FILE;

-- Describes the functionality of the tesbench.

architecture MY_TEST of TEST_REGISTER_FILE is 

	component register_file
		port( reset, clk, write_enable          : in STD_LOGIC;
		      read_reg_1, read_reg_2, write_reg	: in STD_LOGIC_VECTOR(4 downto 0);
		      write_data                        : in STD_LOGIC_VECTOR(31 downto 0);
		      read_data_1, read_data_2		    : out STD_LOGIC_VECTOR(31 downto 0)
		      );
	end component;

	for U1: register_file use entity work.register_file(behavioral_arch);
	signal reset, clk, write_enable : STD_LOGIC;
	signal read_reg_1, read_reg_2, write_reg : STD_LOGIC_VECTOR(4 downto 0);
	signal write_data                        : STD_LOGIC_VECTOR(31 downto 0);
    signal read_data_1, read_data_2		     : STD_LOGIC_VECTOR(31 downto 0);
	
	begin
	U1: register_file port map (reset, clk, write_enable, read_reg_1, read_reg_2, write_reg, write_data, read_data_1, read_data_2);
	
		process
		begin

		-- Case 1: Tests the functionality of setting reset
		
            reset <= '1';
            -- wait, the set reset to 0
            write_enable <= '1';
			read_reg_1 <= "00000";
			read_reg_2 <= "00000";
			write_reg  <= "00000";
			write_data <= "11111111111111111111111111111111";
			clk <= '0';
			wait for 10 ns;
			clk <= '1';
			wait for 10 ns;
			assert ( read_data_1 = "00000000000000000000000000000000" ) report "Failed Case 1 - data_reg_1" severity error;
			assert ( read_data_2 = "00000000000000000000000000000000" ) report "Failed Case 1 - data_reg_2" severity error;
			wait for 40 ns;

		-- Case 2: Tests basic output from basic command on rising clock
		
--            write_enable <= '1';
--            read_reg_1 <= "00000";
--			read_reg_2 <= "00000";
--		    write_reg  <= "00000";
--		    write_data <= "00000000000000000000000000000001";
--		    clk <= '0';
--			wait for 10 ns;
--			clk <= '1';
--			assert ( read_data_1 = "00000000000000000000000000000001" )	report "Failed Case 2 - data_reg_1" severity error;
--			assert ( read_data_2 = "00000000000000000000000000000001" ) report "Failed Case 2 - data_reg_2" severity error;
--			wait for 40 ns;
			
		-- Case 3: Tests basic output from basic command with write_enable not set
		
--            write_enable <= '0';
--            read_reg_1 <= "00000";
--			read_reg_2 <= "00000";
--		    write_reg  <= "00000";
--		    write_data <= "00000000000000000000000000000001";
--		    clk <= '0';
--			wait for 10 ns;
--			clk <= '1';
--			assert ( read_data_1 = "00000000000000000000000000000000" ) report "Failed Case 2 - data_reg_1" severity error;
--			assert ( read_data_2 = "00000000000000000000000000000000" ) report "Failed Case 2 - data_reg_2" severity error;
--			wait for 40 ns;
			
		end process;
END MY_TEST;