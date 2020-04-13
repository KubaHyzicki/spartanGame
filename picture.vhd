library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Picture is						
    Port ( PIX_X : in  STD_LOGIC_VECTOR (9 downto 0);
           PIX_Y : in  STD_LOGIC_VECTOR (8 downto 0);
           RGB : out  STD_LOGIC_VECTOR (2 downto 0);

           heroX : in STD_LOGIC_VECTOR (2 downto 0);
           heroY : in STD_LOGIC_VECTOR (2 downto 0));
end Picture;

architecture Behavioral of Picture is
	signal tmpX : integer range 0 to 640 := 0;
	signal tmpY : integer range 0 to 480 := 0;

	signal locX : integer range 0 to 641 := 10;
	signal locY : integer range 0 to 481 := 10;

	--constant chunkSize : integer := 40;
	constant chunkRadius : integer := 20;
	
	constant wallRGB : std_logic_vector(2 downto 0) := "001";

	constant heroRGB : std_logic_vector(2 downto 0) := "010";
	signal isHero : std_logic := "0";

begin

	checkHero:
	process(PIX_X, PIX_Y, heroX, heroY)
	begin
		if (PIX_X > heroX - chunkRadius and PIX_X < heroX + chunkRadius and PIX_Y > heroY - chunkRadius and PIX_Y < heroY + chunkRadius) then
			isHero <= 1;
		else
			isHero <= 0;
		end if;
	end process;

	main:
	process(PIX_X, PIX_Y, isHero)
	begin
		if (isHero = 1) then
			RGB <= heroRGB;
		--else if ( isSth= 1)
		--	RGB <= sthRGB;
		else
			RGB <= "000"
		end if;
	end process;
end Behavioral;
	