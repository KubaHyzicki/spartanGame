library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Picture is						
    Port ( PIX_X : in  STD_LOGIC_VECTOR (9 downto 0);
           PIX_Y : in  STD_LOGIC_VECTOR (8 downto 0);
           RGB : out  STD_LOGIC_VECTOR (2 downto 0));
end Picture;

architecture Behavioral of Picture is
 
begin
	process (PIX_X, PIX_Y)
	begin
			RGB(0) <= '1';
			RGB(1) <= '1';
			RGB(2) <= '1';
	end process;
end Behavioral;



