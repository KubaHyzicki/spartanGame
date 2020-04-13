library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity VGA_driver is
    Port ( CLK_50MHz : in  STD_LOGIC;
           RGB : in  STD_LOGIC_VECTOR (2 downto 0);
           VGA_R : out  STD_LOGIC;
           VGA_G : out  STD_LOGIC;
           VGA_B : out  STD_LOGIC;
           VGA_HS : out  STD_LOGIC;
           VGA_VS : out  STD_LOGIC;
           PIX_X : out  STD_LOGIC_VECTOR (9 downto 0);
           PIX_Y : out  STD_LOGIC_VECTOR (8 downto 0)
			  );      
end VGA_driver;

architecture Behavioral of VGA_driver is
	signal CLK_25MHz: STD_LOGIC  := '0';
	signal h_cnt : integer range 0 to 799 := 0;
	signal v_cnt : integer range 0 to 520 := 31;
begin

process(CLK_50MHz)
	begin
		if rising_edge(CLK_50MHz) then						
          CLK_25MHz <= NOT(CLK_25MHz);							
		end if;
	end process;
----------------------------------------------------------------
process(CLK_25MHz)
	begin
		if rising_edge(CLK_25MHz) then
			if (h_cnt = 799) then
				h_cnt <= 0;
				if (v_cnt = 520) then
					v_cnt <= 0;
				else
               v_cnt <= v_cnt + 1;
				end if;
			else
				h_cnt <= h_cnt + 1;
			end if;
		end if;
	end process;
-----------------------------------------------------------------
process(h_cnt)
begin
	if (h_cnt < 96) then
		VGA_HS <= '0';
	else
		VGA_HS <= '1';
	end if;
end process;
-----------------------------------------------------------------
process(v_cnt)
begin
	if (v_cnt < 2) then
		VGA_VS <= '0';
	else
		VGA_VS <= '1';
	end if;
end process;
----------------------------------------------------------------
process(h_cnt, v_cnt, RGB)
	begin
      if (h_cnt >= 144 and h_cnt < 784) and ( v_cnt >= 31 and v_cnt < 513 )then
         VGA_R <= RGB(2);
			VGA_G <= RGB(1);
			VGA_B <= RGB(0);

			PIX_X <= STD_LOGIC_VECTOR(to_unsigned(h_cnt-144,10)); 
			PIX_Y <= STD_LOGIC_VECTOR(to_unsigned(v_cnt-31,9));
      else 
			VGA_R <= '0';
			VGA_G <= '0';
			VGA_B <= '0';
			PIX_X <= STD_LOGIC_VECTOR(to_unsigned(640,10)); 

			PIX_Y <= STD_LOGIC_VECTOR(to_unsigned(480,9));
		end if;
      

end process;
	
   
end Behavioral;

