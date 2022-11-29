library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Imm_Gen is
      Port ( 
            InstrCode    : in STD_LOGIC_VECTOR (31 downto 0);
            ImmOut       : out STD_LOGIC_VECTOR (31 downto 0)
            );
end Imm_Gen;

architecture Behavioral of Imm_Gen is

begin
    process(InstrCode) is
    begin

    if InstrCode(6 downto 0) = "0110011" then  --R-Type Instruction
        Immout <= InstrCode(31) & "00000000000000000000" & InstrCode(30 downto 25) & InstrCode(11 downto 7);
    elsif InstrCode(6 downto 0) = ("0000011" OR "0010011") then-- I-Type Instruction
        Immout <= InstrCode(31) & "00000000000000000000" & InstrCode(30 downto 20);          
    elsif InstrCode(6 downto 0) = "0100011" then  -- S-Type Instruction
        Immout <= InstrCode(31) & "00000000000000000000" & InstrCode(30 downto 25) & InstrCode(11 downto 7);   
    elsif InstrCode(6 downto 0) = "1100111" then    -- SB-Type Instruction
        Immout <= InstrCode(31) & "0000000000000000000" & InstrCode(6) & InstrCode(30 downto 25) & InstrCode(11 downto 7);
    elsif InstrCode(6 downto 0) = "0110111" then   -- U-Type Instruction
        Immout <= InstrCode(31) & "000000000000" & InstrCode(30 downto 12);
    elsif InstrCode(6 downto 0) = "1101111" then   -- UJ-Type Instruction
        Immout <= InstrCode(31) & "000000000000" & InstrCode(19 downto 12) & InstrCode(20) & InstrCode(30 downto 21);
    end if;

    end process;

end Behavioral;
