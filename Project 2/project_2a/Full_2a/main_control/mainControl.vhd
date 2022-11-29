----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2021 03:30:02 PM
-- Design Name: 
-- Module Name: MainControl - Behavioral
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
---------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mainControl is

Port ( 
        Opcode : in std_logic_vector(6 downto 0); --7 bits
        ALUSrc : out std_logic; 
        MemToReg : out std_logic;
        RegWrite : out std_logic;
        MemRead : out std_logic;
        MemWrite : out std_logic;
        Branch : out std_logic;
        ALUOp : out std_logic_vector(1 downto 0)
    );

end mainControl;

architecture Behavioral of mainControl is
--Behavioral
begin

process(Opcode)

begin

case Opcode is
    
    when "0110011" =>  -- r-format 
        
        ALUSrc <= '0';
        MemToReg <= '0';
        RegWrite <= '1';
        MemRead <= '0';
        MemWrite <= '0';
        Branch <= '0';
        ALUOp(1) <= '1';
        ALUOp(0) <= '0';
    
     when "0000011" =>   -- ld
        
        ALUSrc<= '1';
        MemToReg <= '1';
        RegWrite <= '1';
        MemRead <= '1';
        MemWrite <= '0';
        Branch <= '0';
        ALUOp(1) <= '0';
        ALUOp(0) <= '0';
       
    when "0100011"  =>    -- sd 
       
        ALUSrc <= '1';
        MemToReg <= '-';
        RegWrite <= '0';
        MemRead <= '0';
        MemWrite <= '1';
        Branch <= '0';
        ALUOp(1) <= '0';
        ALUOp(0) <= '0';
    
    when "1100011" =>    --beq
    
        ALUSrc <= '0';
        MemToReg <= '-';
        RegWrite <= '0';
        MemRead <= '0';
        MemWrite <= '0';
        Branch <= '1';
        ALUOp(1) <= '0';
        ALUOp(0) <= '1';
        
        
    when others =>
        
        ALUSrc <= '-';
        MemToReg <= '-';
        RegWrite <= '-';
        MemRead <= '-';
        MemWrite <= '-';
        Branch <= '-';
        ALUOp(1) <= '-';
        ALUOp(0) <= '-';
        
end case;
end process;       
end Behavioral;
