--
-- Copyright (C) 2022 RapidSilicon
--
-- genesis3 DFFs and LATCHes
--

------------------------------------------------------------------------------
-- Rising-edge D-flip-flop with
--   active-Low asynchronous reset
--   active-high enable
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dffre is
   generic (
               INIT_VALUE : std_logic := '0';
               VCS_MODE : boolean := false
           );
   port(
      c: in std_logic;
      r: in std_logic;
      e: in std_logic;
      d: in std_logic;
      q: out std_logic
   );
end dffre;

architecture arch of dffre is
begin
   process_init : process
   begin
   if (not VCS_MODE) then
           q <= INIT_VALUE;
   end if;
   wait;
   end process;
   process(c, r)
   begin
      if (r='0') then
         q <='0';
      elsif (c'event and c='1') then
         if (e='1') then
            q <= d;
         end if;
      end if;
   end process;
end arch;

--------------------------------------------------------------------------------
-- Falling-edge D-flip-flop with
--   active-Low asynchronous reset
--   active-high enable
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dffnre is
   generic (
               INIT_VALUE : std_logic := '0';
               VCS_MODE : boolean := false
           );
   port(
      c: in std_logic;
      r: in std_logic;
      e: in std_logic;
      d: in std_logic;
      q: out std_logic
   );
end dffnre;

architecture arch of dffnre is
begin
   process_init : process
   begin
   if (not VCS_MODE) then
           q <= INIT_VALUE;
   end if;
   wait;
   end process;
   process(c, r)
   begin
      if (r='0') then
         q <='0';
      elsif (c'event and c='0') then
         if (e='1') then
            q <= d;
         end if;
      end if;
   end process;
end arch;

--------------------------------------------------------------------------------
-- Positive level-sensitive latch
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity latch is
   generic (
               INIT_VALUE : std_logic := '0';
               VCS_MODE : boolean := false
           );
   port (
     q : out std_logic;
     g : in std_logic;
     d : in std_logic
   );
end latch;

architecture arch of latch is
begin
  process_init : process
  begin
  if (not VCS_MODE) then
          q <= INIT_VALUE;
  end if;
  wait;
  end process;
  processing_1 : process(g, d)
  begin
    if (g='1') then
      q <= d;
    end if;
  end process;
end arch;

--------------------------------------------------------------------------------
-- Negative level-sensitive latch
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity latchn is
   generic (
               INIT_VALUE : std_logic := '0';
               VCS_MODE : boolean := false
           );
   port (
    q : out std_logic; 
    g : in std_logic;
    d : in std_logic
  );
end latchn;

architecture arch of latchn is
begin
  process_init : process
  begin
  if (not VCS_MODE) then
          q <= INIT_VALUE;
  end if;
  wait;
  end process;
  processing_1 : process(g, d)
  begin
    if (g='0') then
      q <= d;
    end if;
  end process;
end arch;

--------------------------------------------------------------------------------
-- Positive level-sensitive latch with active-high asyncronous reset
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity latchr is
   generic (
               INIT_VALUE : std_logic := '0';
               VCS_MODE : boolean :=false
           );
   port (
    q : out std_logic;
    g : in std_logic;
    r : in std_logic;
    d : in std_logic
  );
end latchr;

architecture arch of latchr is
begin
  process_init : process
  begin
  if (not VCS_MODE) then
          q <= INIT_VALUE;
  end if;
  wait;
  end process;
  processing_1 : process(r, g, d)
  begin
    if (r='1') then
      q <= '0';
    elsif (g='1') then
      q <= d;
    end if;
  end process;
end arch;

--------------------------------------------------------------------------------
-- Negative level-sensitive latch with active-high asyncronous reset
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity latchnr is
   generic (
               INIT_VALUE : std_logic := '0';
               VCS_MODE : boolean := false
           );
   port (
    q : out std_logic;
    g : in std_logic;
    r : in std_logic;
    d : in std_logic
  );
end latchnr;

architecture arch of latchnr is
begin
  process_init : process
  begin
  if (not VCS_MODE) then
          q <= INIT_VALUE;
  end if;
  wait;
  end process;
  processing_1 : process(r, g, d)
  begin
    if (r='1') then
      q <= '0';
    elsif (g='0') then
      q <= d;
    end if;
  end process;
end arch;

--------------------------------------------------------------------------------
-- fa_1bit : 1 bit adder_carry
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fa_1bit is
  port (
    sum : out std_logic;
    cout : out std_logic;
    p : in std_logic;
    g : in std_logic;
    cin : in std_logic
  );
end fa_1bit;

architecture arch of fa_1bit is
begin
  sum <= p xor cin;
  cout <= cin when p else g;

end arch;


--------------------------------------------------------------------------------
-- lut 
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lut is
   generic (
        A_SIGNED : INTEGER := 0;
        B_SIGNED : INTEGER := 0;
        A_WIDTH : INTEGER := 0;
        B_WIDTH : INTEGER := 0;
        Y_WIDTH : INTEGER := 0);
   port (
     A:  in std_logic_vector(A_WIDTH-1 downto 0) ;
     B:  in std_logic_vector(B_WIDTH-1 downto 0) ;
     Y: out std_logic
   );
end lut;

architecture behave of lut is

  signal S : std_logic_vector(Y_WIDTH-1 downto 0);

begin

  process (A, B) is
  begin
    -- Right Shift
    S <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B))));
    Y <= S(0);

  end process;
end architecture behave;

