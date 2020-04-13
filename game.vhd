library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Game is						
    Port (
           --vector of following format { [X1],[X2],[X3],[X4]  ,  [Y1],[Y2],[Y3],[Y4] }
			DISPLAY_CHUNK : in STD_LOGIC_VECTOR (7 downto 0) := "11111111";	
    		OBJECT_ID : out STD_LOGIC_VECTOR (2 downto 0) := "000");
end Game;

architecture Behavioral of Game is
	type typeTable
	gameBoard : in integer (9 downto 0, 9 downto 0);
begin

	mapChunkToObject:
	process(DISPLAY_CHUNK)
	begin
		constant boardX : integer := to_integer(signed(DISPLAY_CHUNK(7 downto 4)));
		constant boardY : integer := to_integer(signed(DISPLAY_CHUNK(3 downto 0)));
		OBJECT_ID <= gameBoard(boardX, boardY);
	end process;
end Behavioral;
	