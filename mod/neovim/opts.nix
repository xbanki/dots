#   Editor Options
#
# Base editor settings.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ ... }:

{
  files = let
    stabs = {
      softtabstop = 2;
      shiftwidth = 2;
      tabstop = 2;
    };

  in {
    "ftplugin/nix.lua".opts = stabs;
    "ftplugin/lua.lua".opts = stabs;
    "ftplugin/go.lua".opts = {
      expandtab = false;
      softtabstop = 0;
    };
  };

  opts = {
    # Status line
    showmode = false;
    showcmd = false;
    laststatus = 3;
    ruler = false;

    # Code indents
    smartindent = true;
    autoindent = true;
    expandtab = true;
    smarttab = true;
    softtabstop = 4;
    shiftwidth = 4;
    tabstop = 4;

    # Behaviours
    splitkeep = "screen";
    splitbelow = false;
    splitright = true;
    updatetime = 100;
    linebreak = true;
    swapfile = false;
    belloff = "all";
    undofile = true;
    scrolloff = 12;
    mouse = "nv";
    wrap = false;

    # Code folding
    foldlevelstart = 99;
    foldenable = true;
    foldcolumn = "0";
    foldnestmax = 8;
    foldlevel = 99;
    foldtext = "";

    # Buffer search
    ignorecase = true;
    incsearch = true;
    smartcase = true;
    hlsearch = true;
    wildmenu = true;

    # Appearance
    signcolumn = "yes";
    cursorline = true;
    number = true;
    list = true;

    # Selection characters
    listchars = {
      leadmultispace = " ";
      multispace = " ";
      tab = " » ";
      nbsp = "␣";
    };

    # Fill characters
    fillchars = {
      eob = " ";
    };
  };
}
