----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2021 08:14:04 PM
-- Design Name: 
-- Module Name: RISCV_main - Behavioral
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

entity RISCV_main is
  Port (
        reset, clk : in STD_LOGIC
        );
end RISCV_main;

architecture Behavioral of RISCV_main is

-- Including the ALU_main component design
component alu_main is
  port (
      a, b : in STD_LOGIC_VECTOR(31 downto 0);
      alu_op : in STD_LOGIC_VECTOR(3 downto 0);
      zero, overflow : out STD_LOGIC;
      result : out STD_LOGIC_VECTOR(31 downto 0)
      );
end component;

-- Including 32bit_adder component design
component bit_32_adder is
    port ( 
        a, b : in STD_LOGIC_VECTOR(31 downto 0);
        z  : out STD_LOGIC_VECTOR(31 downto 0);
        cout : out STD_LOGIC
        );
end component;

-- Including ALU_Control component design
component ALU_Control is
    port ( 
        ALUOp : in std_logic_vector(1 downto 0);
	    func73 : in std_logic_vector(9 downto 0);
        Opcode : out std_logic_vector(3 downto 0)
        );
end component;

-- Including data_memory component design
component data_memory is
    port ( 
        reset : in std_logic;
        clk : in std_logic;
        MW : in std_logic;
        addr_in : in std_logic_vector(31 downto 0); -- we use only 4 bits though here;
        data_in : in std_logic_vector(31 downto 0);
        data_out : out std_logic_vector(31 downto 0) 
        );
end component;

-- Including instruction_memory component design
component instruction_memory is 
    port ( 
        addr_in : in std_logic_vector(31 downto 0); 
        instr_out : out std_logic_vector(31 downto 0) 
        );
end component;

-- Including mainControl component design
component mainControl is
    Port ( 
        Opcode : in std_logic_vector(6 downto 0);
        ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch : out std_logic; 
        ALUOp : out std_logic_vector(1 downto 0)
        );
end component;

-- Including design of the mux using outputs from data_memory and alu_man
component data_mux is
	port (
        read_data, alu_result : IN STD_LOGIC_VECTOR(31 downto 0);
        MemToReg : IN STD_LOGIC;
		data_mux_out : OUT STD_LOGIC_VECTOR(31 downto 0)
        );
end component;

-- Including design of the mux using outputs from register_file and ImmGen
component register_mux is
	port (
        read_data_2, ImmGen_out : IN STD_LOGIC_VECTOR(31 downto 0);
        ALUSrc : IN STD_LOGIC;
		register_mux_out : OUT STD_LOGIC_VECTOR(31 downto 0)
        );
end component;

-- Including design of the mux using outputs from both adders
component adder_mux is
	port (
        pc_adder_out, bit32_adder : IN STD_LOGIC_VECTOR(31 downto 0);
        branch_AND_zero : IN STD_LOGIC;
        adder_mux_out : OUT STD_LOGIC_VECTOR(31 downto 0)
        );
end component;

-- Including register32bit component design
component register32bit is
    port ( 
        I : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        CLK, Reset, Set : IN STD_LOGIC; -- set = 0
        Q : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
end component; -- Where do we use this component?

-- Including register_file component design
component register_file is
    port (
        reset : in std_logic;
        read_reg_1, read_reg_2, write_reg : in std_logic_vector(4 downto 0);
        write_data: in std_logic_vector(31 downto 0);
        clk, write_enable : in std_logic;
        read_data_1, read_data_2 : out std_logic_vector(31 downto 0)
        );
end component;

-- Incluidng ImmGen component design
component Imm_Gen is
    port (
        InstrCode : in STD_LOGIC_VECTOR(31 downto 0);
        ImmOut : out STD_LOGIC_VECTOR(31 downto 0)
        );
end component;

-- Establish all signals within CPU
    signal pc_out : STD_LOGIC_VECTOR(31 downto 0); -- Output of program_counter
    signal pc_add, sum : STD_LOGIC_VECTOR(31 downto 0); -- Outputs of adders
    signal instr_out : STD_LOGIC_VECTOR(31 downto 0); -- Output of instruction_memory
    signal read_data_1, read_data_2 : STD_LOGIC_VECTOR(31 downto 0);  -- Outputs of register_file
    signal ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch : STD_LOGIC; -- 1bit outputs of main_control
    signal Imm_Gen_out : STD_LOGIC_VECTOR(31 downto 0);
    signal branch_AND_zero, c_out : STD_LOGIC; -- Result from AND gate, also unused c_out signal from 32bit_adder
    signal ALUOp : STD_LOGIC_VECTOR(1 downto 0); -- 2bit output of main_control
    signal op_code : STD_LOGIC_VECTOR(3 downto 0); -- Output of ALU_control
    signal ALU_result : STD_LOGIC_VECTOR(31 downto 0); -- 32bit output of ALU_main
    signal ALU_zero, alu_overflow : STD_LOGIC; -- 1bit output of ALU_main
    signal data_memory_out : STD_LOGIC_VECTOR(31 downto 0); -- Output of data_memory
    signal register_mux_out, data_mux_out, adder_mux_out : STD_LOGIC_VECTOR(31 downto 0); -- Various mux outputs
    signal alu_control_in : STD_LOGIC_VECTOR(9 downto 0); -- concatenated func7 and func3 for alu_control input

begin

    -- Port mapping of program_counter (register32bit)
    pc : register32bit port map (adder_mux_out, CLK, Reset, '0', pc_out);
    
    -- Port mapping of initial 32bit_adder
    first_add : bit_32_adder port map (pc_out, "00000000000000000000000000000100", pc_add, c_out);
    
    -- Port mapping of instruction_memory
    instruction_mem : instruction_memory port map (pc_out, instr_out);
    
    -- Port mapping of mux from data_memory
    data_mem_mux : data_mux port map (data_memory_out, alu_result, MemToReg);
    
    -- Port mapping of main_control
    main_control : mainControl port map (instr_out(6 downto 0), ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);
    
    -- Port mapping of register_file
    reg_file : register_file port map (Reset, instr_out(19 downto 15), instr_out(24 downto 20), instr_out(11 downto 7), data_mux_out, CLK, RegWrite, read_data_1, read_data_2);
    
    -- Port mapping of ImmGen
    immgen : Imm_Gen port map (instr_out(31 downto 0), Imm_Gen_out);
    
    -- Port mapping of alu_control
    alu_control_in <= instr_out(31 downto 25) & instr_out(14 downto 12);
    alu_ctrl : ALU_Control port map (ALUop, alu_control_in, op_code);
    
    -- Port mapping of register_mux
    reg_mux : register_mux port map(read_data_2, Imm_Gen_out, ALUSrc, register_mux_out);
    
    -- Port mapping of alu_main
    main_alu : alu_main port map (read_data_2, register_mux_out, op_code, alu_zero, alu_overflow, alu_result);
    
    -- Port mapping of data_memory
    data_mem : data_memory port map (Reset, CLK, MemWrite, alu_result, read_data_2, data_memory_out);
    
    -- Port mapping of 32bit_adder
    main_add : bit_32_adder port map (pc_out, Imm_Gen_out, sum, c_out);
    
    -- Port mapping of adders_mux
    branch_AND_zero <= Branch AND alu_zero;
    adders_mux : adder_mux port map (pc_add, sum, branch_AND_zero, adder_mux_out);
    
    
    
end Behavioral;
