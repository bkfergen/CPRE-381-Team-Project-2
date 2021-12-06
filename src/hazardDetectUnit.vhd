library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity hazardDetectUnit is
generic(N: integer := 32);
	port(
		ID_EX.MemRead	: in std_logic;
		ID_EX.RegisterRt : in std_logic_vector(N-1 downto 0);
		ID_EX.RegisterRs : in std_logic_vector(N-1 downto 0);
		IF_ID.Instruction : in std_logic_vector(N-1 downto 0);
		ID_EX.Instruction : in std_logic_vector(N-1 downto 0);      
		CtrlMux		: out std_logic;
		IF_ID_Flush	: out std_logic;
		PC_WrEn 	: out std_logic;
	  
		



end hazardDetectUnit;

architecture mixed of dffg is
  signal s_IF_ID_Opcode		: std_logic_vector(5 downto 0);    -- Opcode for IF_ID.Instruction
  signal s_IF_ID_Fuct		: std_logic_vector(5 downto 0);    -- Function code for IF_ID.Instruction
  signal s_ID_EX_Opcode		: std_logic_vector(5 downto 0);    -- Opcode for ID_EX.Instruction
  signal s_ID_EX_Fuct		: std_logic_vector(5 downto 0);    -- Function code for ID_EX.Instruction


process(s_opcode, s_Funct)
begin

--control hazard 
  s_IF_ID_Opcode  <= IF_ID.Instruction(31 downto 26);
  s_IF_ID_Fuct	  <= IF_ID.Instruction(5 downto 0);

  if s_IF_ID_Opcode = "000000" and s_IF_ID_Fuct = "001000" then  -- R-format, jr instruction
  	IF_ID_Flush	<= 	'1';
	PC_WrEn 	<=	'0';
	CtrlMux		<= 	'1';
  elsif s_IF_ID_Opcode = "000100" then  --beq
	IF_ID_Flush	<= 	'1';
	PC_WrEn 	<=	'0';
	CtrlMux		<= 	'1';

  elsif s_IF_ID_Opcode = "000101" then  --bne
	IF_ID_Flush	<= 	'1';
	PC_WrEn 	<=	'0';
	CtrlMux		<= 	'1';

  elsif s_IF_ID_Opcode = "000011" then  --jump 
	IF_ID_Flush	<= 	'1';
	PC_WrEn 	<=	'0';
	CtrlMux		<= 	'1';

  elsif s_IF_ID_Opcode = "000011" then  --jump and link 
	IF_ID_Flush	<= 	'1';
	PC_WrEn 	<=	'0';
	CtrlMux		<= 	'1';

  end if;

--control hazard 
  s_ID_EX_Opcode  <= ID_EX.Instruction(31 downto 26);
  s_ID_EX_Fuct	  <= ID_EX.Instruction(5 downto 0);

  if s_ID_EX_Opcode = "000000" and s_IF_ID_Fuct = "001000" then  -- R-format, jr instruction
  	IF_ID_Flush	<= 	'1';
	PC_WrEn 	<=	'1';
	CtrlMux		<= 	'1';

  elsif s_ID_EX_Opcode = "000100" then  --beq
	IF_ID_Flush	<= 	'1';
	PC_WrEn 	<=	'1';
	CtrlMux		<= 	'1';

  elsif s_ID_EX_Opcode = "000101" then  --bne
	IF_ID_Flush	<= 	'1';
	PC_WrEn 	<=	'1';
	CtrlMux		<= 	'1';

  elsif s_ID_EX_Opcode = "000011" then  --jump 
	IF_ID_Flush	<= 	'1';
	PC_WrEn 	<=	'1';
	CtrlMux		<= 	'1';

  elsif s_ID_EX_Opcode = "000011" then  --jump and link 
	IF_ID_Flush	<= 	'1';
	PC_WrEn 	<=	'1';
	CtrlMux		<= 	'1';
  end if;

	
        
