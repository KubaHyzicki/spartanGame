LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY vga_tb IS
END vga_tb;
 
ARCHITECTURE behavior OF vga_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT VGA_driver
    PORT(
         CLK_50MHz : IN  std_logic;
         RGB : IN  std_logic_vector(2 downto 0);
         VGA_R : OUT  std_logic;
         VGA_G : OUT  std_logic;
         VGA_B : OUT  std_logic;
         VGA_HS : OUT  std_logic;
         VGA_VS : OUT  std_logic;
         PIX_X : OUT  std_logic_vector(9 downto 0);
         PIX_Y : OUT  std_logic_vector(8 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_50MHz : std_logic := '0';
   signal RGB : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal VGA_R : std_logic;
   signal VGA_G : std_logic;
   signal VGA_B : std_logic;
   signal VGA_HS : std_logic;
   signal VGA_VS : std_logic;
   signal PIX_X : std_logic_vector(9 downto 0);
   signal PIX_Y : std_logic_vector(8 downto 0);

   -- Clock period definitions
   constant CLK_50MHz_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: VGA_driver PORT MAP (
          CLK_50MHz => CLK_50MHz,
          RGB => RGB,
          VGA_R => VGA_R,
          VGA_G => VGA_G,
          VGA_B => VGA_B,
          VGA_HS => VGA_HS,
          VGA_VS => VGA_VS,
          PIX_X => PIX_X,
          PIX_Y => PIX_Y
        );

   -- Clock process definitions
   CLK_50MHz_process :process
   begin
		for i in 1 to 3 * 2 * 800 loop
			CLK_50MHz <= '0';
			wait for CLK_50MHz_period/2;
			CLK_50MHz <= '1';
			wait for CLK_50MHz_period/2;
		end loop;
		wait;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		RGB <= "111";
      wait;
   end process;

END;
