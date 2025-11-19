#   Telescope Configuration `github:nvim-telescope/telescope.nvim`
#
# Telescope is configured to function as the primary means to interact with
# files in the directory that neovim is opened in.
#
# Neovim's built-in file explorer (netrw) gets disabled in favor of Telescope's
# `github:nvim-telescope/telescope-file-browser.nvim` plugin.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ pkgs, lib, ... }:

{
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      file-browser = {
        enable = true;
        settings = {
          display_stat = let
            stat = {
              display = lib.nixvim.mkRaw "function(_) return '' end";
              width = 0;
            };

          in {
            size = {
              display = lib.nixvim.mkRaw ''
                function(opts)
                  if opts.stat.size ~= 0 then
                    local m = "telescope._extensions.file_browser.fs_stat"
                    return require(m).size.display(opts)
                  end

                  return nil
                end
              '';
            };

            date = stat;
            mode = stat;
          };

          prompt_prefix = " ";
          hijack_netrw = true;
          git_status = false;
          theme = "dropdown";
          previewer = false;
          grouped = true;
          hidden = true;
        };
      };
    };

    settings = {
      pickers = {
        grep_string = {
          layout_config.width = 0.56;
          prompt_title = false;
          prompt_prefix = "";
          theme = "cursor";
        };

        live_grep = {
          layout_config = {
            preview_height = 0.60;
            height = 0.64;
            width = 0.48;
          };

          layout_strategy = "vertical";
          prompt_title = false;
        };

        current_buffer_fuzzy_find = {
          prompt_title = false;
          theme = "dropdown";
          previewer = false;
        };

        find_files.layout_config = {
          prompt_position = "bottom";
          preview_width = 0.60;
        };
      };

      defaults = {
        file_ignore_patterns = [
          "^node_modules/"
          "^%.mypy_cache/"
          "^__pycache__/"
          "%.ipynb"
          "^vendor/"
          "^build/"
          "^venv/"
          "^env/"
          "%.git"
        ];

        path_display = lib.nixvim.listToUnkeyedAttrs ["truncate"];
        layout_config.scroll_speed = 2;
        sorting_strategy = "ascending";
        dynamic_preview_title = true;
        color_devicons = false;
        selection_caret = " ";
        results_title = false;
        prompt_prefix = " ";
        multi_icon = "󰄾 ";
      };
    };
  };

  extraPackages = with pkgs; [
    ripgrep
    fd
  ];
}
