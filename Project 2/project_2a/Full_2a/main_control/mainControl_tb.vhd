----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2021 11:55:46 AM
-- Design Name: 
-- Module Name: mainControl_tb - Behavioral
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

entity mainControl_tb is

end mainControl_tb;

architecture Behavioral of mainControl_tb is
    
component mainControl
    port(
    
        opcode : in std_logic_vector(6 to 0); --7 bits
        ALU_src : out std_logic; 
        mem_reg : out std_logic;
        reg_write : out std_logic;
        mem_read : out std_logic;
        mem_write : out std_logic;
        branch : out std_logic;
        ALU_op : out std_logic_vector(1 downto 0)
        );

end component;

     for  uut: MainControl use entity work.mainControl(Behavioral);
     
        signal opcode : std_logic_vector(6 to 0); --7 bits
        signal ALU_src :  std_logic; 
        signal mem_reg : std_logic;
        signal reg_write : std_logic;
        signal mem_read :std_logic;
        signal mem_write : std_logic;
        signal branch : std_logic;
        signal ALU_op : std_logic_vector(1 downto 0);
        
        begin 
        uut: MainControl port map (opcode,ALU_src,mem_reg,reg_write,mem_read,mem_write,branch,ALU_op);
        
        process

  begin
    -- test the controller output with the opcode input
         opcode <= "0110011"; -- R type
         wait for 10 ns;
         
         assert (ALU_src = '0') report "Failed Case 1 - ALU_src" severity error;
         assert (mem_reg = '0') report "Failed Case 1 - mem_reg" severity error;
         assert (reg_write = '1') report "Failed Case 1 - reg_write" severity error;
         assert (mem_read = '0') report "Failed Case 1 - mem_read" severity error;
         assert (mem_write = '0') report "Failed Case 1 - mem_write" severity error;
         assert (branch = '0') report "Failed Case 1 - branch" severity error;
         assert (ALU_op(0) = '0') report "Failed Case 1 - ALU_op(0)" severity error;
         assert (ALU_op(1) = '1') report "Failed Case 1 - ALU_op(1)" severity error;
     
         wait for 40 ns;
   --  opcode <= "0000011"; -- ld
     --wait for 10 ns;
     
--     opcode <= "0100011"; -- sd
--     wait for 10 ns;
     
--     opcode <= "1100011"; -- beq
--     wait for 10 ns;
    
  end process;
  
end Behavioral;
