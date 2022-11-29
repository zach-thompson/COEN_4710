library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_file is
  port (
    reset : in std_logic;
    read_reg_1 : in std_logic_vector(4 downto 0);
    read_reg_2 : in std_logic_vector(4 downto 0);
    write_reg :  in std_logic_vector(4 downto 0);
    write_data: in std_logic_vector(31 downto 0);
    clk : in std_logic;
    write_enable : in std_logic;
    read_data_1 : out std_logic_vector(31 downto 0);
    read_data_2 : out std_logic_vector(31 downto 0) 
  );
end register_file;


architecture behavioral_arch of register_file is

	type MEM_ARRAY_32x32 is array(0 to 31) of std_logic_vector(31 downto 0);

begin  
	
	   register_file_process: process (read_reg_1, read_reg_2, write_reg, write_data, clk, write_enable) is
		variable big_array : MEM_ARRAY_32x32;
		variable index : integer;
		
	begin
	      
		index := conv_integer(write_reg(4 downto 0));
		
	    -- Sets everything to 0   
		if (reset = '1') then
			for i in 0 to 31 loop
                big_array(i) := "00000000000000000000000000000000";
            end loop ;
		
		-- Fills specified index (write_reg) of big_array with write_data value
		elsif (rising_edge(clk) and write_enable = '1') then
			-- write data in on rising edge of clock
			big_array(index) := write_data;
		end if;
	 
		-- asynchronous continuous read of the data memory location at address read_reg
		read_data_1 <= big_array(conv_integer(read_reg_1));
		read_data_2 <= big_array(conv_integer(read_reg_2));
		
	end process;
  
end behavioral_arch;

