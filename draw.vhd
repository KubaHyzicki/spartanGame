library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL

entity Draw is
	Port ( PIX_X : in  STD_LOGIC_VECTOR (9 downto 0);
			PIX_Y : in  STD_LOGIC_VECTOR (8 downto 0);

			--vector of following format { [X1],[X2],[X3],[X4]  ,  [Y1],[Y2],[Y3],[Y4] }
			CHUNK : out STD_LOGIC_VECTOR (7 downto 0) := "11111111";

			OBJECT_ID : in STD_LOGIC_VECTOR (2 downto 0);

			RGB : out  STD_LOGIC_VECTOR (2 downto 0));
end Draw;

architecture Behavioral of Draw is
	constant chunkSize : integer := 40;
	constant chunkAmount : integer := 10;

	constant backgroundRGB : std_logic_vector(2 downto 0) := "000";
	constant emptyRGB : std_logic_vector(2 downto 0) := "001";		--OBJECT_ID=000 neither hero nor bomb nor wall
	constant wallRGB : std_logic_vector(2 downto 0) := "010";		--OBJECT_ID=010 wall
	constant bombRGB : std_logic_vector(2 downto 0) := "011";		--OBJECT_ID=011 bomb
	constant heroRGB_1 : std_logic_vector(2 downto 0) := "100";		--OBJECT_ID=100 hero nr 1
	constant heroRGB_2 : std_logic_vector(2 downto 0) := "101";		--OBJECT_ID=101 hero nr 2
	constant heroAndBombRGB_1 : std_logic_vector(2 downto 0) := "110";		--OBJECT_ID=110 hero nr 1 + bomb
	constant heroAndBombRGB_2 : std_logic_vector(2 downto 0) := "111";		--OBJECT_ID=111 hero nr 2 + bomb
begin

	mapToChunk:
	process(PIX_X, PIX_Y)
	begin
		constant chunkX_int : integer := integer(floor(real(PIX_X)/real(chunkSize)));
		constant chunkY_int : integer := integer(floor(real(PIX_Y)/real(chunkSize)));
		if (chunkX_int > 9 or chunkY_int > 9) then
			--default value to be ignored(to be mapped by game to background)
			CHUNK = "11111111";
		else
			constant CHUNK_X : std_logic_vector (3 downto 0) := conv_std_logic_vector(chunkX_int, 4);
			constant CHUNK_Y : std_logic_vector (3 downto 0) := conv_std_logic_vector(chunkY_int, 4);
			CHUNK <= CHUNK_X + CHUNK_Y;
		end if;
	end process;

	mapToRGB:
	process(OBJECT_ID)
	begin
		if (OBJECT_ID = 1) then
			RGB <= emptyRGB;
		elsif ( OBJECT_ID = 2) then
			RGB <= wallRGB;
		elsif ( OBJECT_ID = 3) then
			RGB <= bombRGB;
		elsif ( OBJECT_ID = 4) then
			RGB <= heroAndBomb;
		elsif ( OBJECT_ID = 5) then
			RGB <= heroRGB_1;
		elsif ( OBJECT_ID = 6) then
			RGB <= heroRGB_2;
		else
			RGB <= backgroundRGB;
		end if;
	end process;
end Behavioral;
