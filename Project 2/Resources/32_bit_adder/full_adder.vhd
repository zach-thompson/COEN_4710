-- 1-bit full adder
-- Declare the 1-bit full adder with the inputs and outputs
-- shown inside the port(). This adds two bits together (x,y)
-- with a carry in (cin) and outputs the sum (sum) and a 
-- carry out (cout).

library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is
	port(a, b, cin: in std_logic;
	sum, cout: out std_logic);
end full_adder;

architecture my_dataflow of full_adder is

begin

sum <= (a xor b) xor cin;
cout  <= (a and b) or (a and cin) or (b and cin);

end my_dataflow;
