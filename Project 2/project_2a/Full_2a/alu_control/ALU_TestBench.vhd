library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;



entity ALU_TestBench is
end ALU_TestBench;

architecture Behavioral of ALU_TestBench is

 COMPONENT ALU_Control
        PORT(   func_73  : in STD_LOGIC_VECTOR(9 downto 0);
                alu_opin : in STD_LOGIC_VECTOR (1 downto 0);
                alu_op   : out signed(3 downto 0)
                
                --func_73 : in STD_LOGIC_VECTOR(9 downto 0);
                --alu_opin : in signed (1 downto 0);
                --alu_op : out STD_LOGIC_VECTOR(3 downto 0)
             );
 END COMPONENT;

        for U1: ALU_Control use entity work.ALU_Control(Behavioral);
      
                --use library_name[ .package_name ].item_name; 
        signal func_73  : std_logic_vector(9 to 0);           --Inputs
        signal alu_opin : std_logic_vector(1 to 0);
        signal alu_op   : signed(3 to 0);            --Output


    begin
--Instantiate Unit Under Test (UUT)

       U1: ALU_Control port map (func_73, alu_opin, alu_op); 
       
       --PORT MAP (func_73, alu_opin, alu_op);

    process

    --uut : alu PORT MAP (func_73 => func_73, alu_opin => alu_opin, alu_op => alu_op);

    begin

--test alu control at alu op input of '00'

        alu_opin => 00;
        wait for 10ns;
        
        assert (alu_op = '0010') report "Failed Case 1 - branch" severity error;


    END;
end Behavioral;
  
