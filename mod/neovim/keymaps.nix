#   Neovim Keymaps
#
# Configures global keymaps for generally accessible actions.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ lib, ... }:

{
  globals.mapleader = " ";
  keymaps = [
    {
      action = "<cmd>Telescope find_files<CR>";
      key = "<leader>ff";
    }
    {
      action = "<cmd>Telescope grep_string<CR>";
      key = "<leader>fw";
    }
    {
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>fg";
    }
    {
      action = "<cmd>Telescope help_tags<CR>";
      key = "<leader>fh";
    }
    {
      action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
      key = "<leader>fb";
    }
    {
      action = lib.nixvim.mkRaw ''
                function()
        	        require("telescope").extensions.file_browser.file_browser {
        	          select_buffer = true,
        	          path = "%:p:h",
        	        }
        	      end
      '';

      key = "<leader>fx";
    }
    {
      action = lib.nixvim.mkRaw "require('tiny-inline-diagnostic').toggle";
      key = "<leader>td";
    }
    {
      action = lib.nixvim.mkRaw ''
        function()
          if vim.bo.filetype == "markdown" or vim.bo.filetype == "mdx" then
            vim.cmd("Markview splitToggle")
          end

          vim.cmd("Markview splitClose")
        end
      '';

      key = "<leader>tm";
    }
  ];
}
