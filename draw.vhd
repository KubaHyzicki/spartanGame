library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL

entity Draw is						
    Port ( PIX_X : in  STD_LOGIC_VECTOR (9 downto 0);
           PIX_Y : in  STD_LOGIC_VECTOR (8 downto 0);

           CHUNK : out STD_LOGIC_VECTOR (4 downto 0);

           OBJECT_ID : in STD_LOGIC_VECTOR (3 downto 0);

           RGB : out  STD_LOGIC_VECTOR (2 downto 0));
end Draw;

architecture Behavioral of Draw is
	constant chunkSize : integer := 40;
	constant chunkAmount : integer := 10;

	constant wallRGB : std_logic_vector(2 downto 0) := "001";
	constant heroRGB : std_logic_vector(2 downto 0) := "010";
	constant backgroundRGB : std_logic_vector(2 downto 0) := "000";
begin

	mapToChunk:
	process(PIX_X, PIX_Y)
	begin
	    constant chunkX_int : integer := integer(floor(real(PIX_X)/real(chunkSize)));
	    constant chunkY_int : integer := integer(floor(real(PIX_Y)/real(chunkSize)));
	    constant CHUNK_X : std_logic_vector (1 downto 0) := conv_std_logic_vector(chunkX_int, 2);
	    constant CHUNK_Y : std_logic_vector (1 downto 0) := conv_std_logic_vector(chunkY_int, 2);
	    CHUNK <= CHUNK_X + CHUNK_Y;
	end process;

	mapToRGB:
	process(OBJECT_ID)
	begin
		if (OBJECT_ID = 0) then
			RGB <= backgroundRGB;
		else if (OBJECT_ID = 1) then
			RGB <= wallRGB;
		else if ( OBJECT_ID = 2) then
			RGB <= heroRGB;
		else
			RGB <= backgroundRGB;
		end if;
	end process;
end Behavioral;
	