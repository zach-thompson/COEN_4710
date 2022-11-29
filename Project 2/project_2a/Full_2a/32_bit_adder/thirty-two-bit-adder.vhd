-- 32-bit adder
-- Structural description of a 32-bit adder. This device
-- adds two 32-bit numbers together.

-- This is just to make a reference to some common things needed.
LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- This describes the black-box view of the component we are
-- designing. The inputs and outputs are again described
-- inside port(). It takes two 32-bit values as input (x and y)
-- and produces a 32-bit output (ANS) and a carry out bit (Cout).
entity bi_32_adder is
  port( 
    a, b : in STD_LOGIC_VECTOR(31 downto 0);
    z  : out STD_LOGIC_VECTOR(31 downto 0);
    cout : out STD_LOGIC
  );
end bi_32_adder;


-- Although we have already described the inputs and outputs,
-- we must now describe the functionality of the adder (ie:
-- how we produced the desired outputs from the given inputs).
architecture MY_STRUCTURE of bi_32_adder is

-- We are going to need four 1-bit adders, so include the
-- design that we have already studied in full_adder.vhd.

component FULL_ADDER
  port( 
    x, y, cin : in  STD_LOGIC;
    sum, cout : out STD_LOGIC 
  );
end component;

-- Now create the signals which are going to be necessary
-- to pass the outputs of one adder to the inputs of the next
-- in the sequence.
signal c : STD_LOGIC_VECTOR(31 downto 0);

begin

c(0)<='0';
Gen_add : FOR i IN 0 to 30 Generate
	adder: FULL_ADDER port map(a(i), b(i), c(i), z(i), c(i+1));
end generate Gen_add;

adder31 : Full_ADDER port map (a(31), b(31), c(31), z(31), cout);


END MY_STRUCTURE;
