#   Lualine Configuration `github:nvim-lualine/lualine.nvim`
#
# A simple statusline configuration with base necessities.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ lib, ... }:

{
  plugins.lualine = {
    enable = true;
    luaConfig.content = ''
      local M = {}

      M.disabled_ftypes = {
        "TelescopePrompt",
        "",
      }

      M.stylized_ftype_names = {
        javascript = "JavaScript",
        typescript = "TypeScript",
        jsonc = "JSONC",
        yaml = "YAML",
        toml = "TOML",
        json = "JSON",
      }

      function M.clamp(opts)
        local vpsize = vim.o.columns
        local max = opts.max or 9999
        local min = opts.min or 0
        return vpsize >= min and vpsize <= max
      end

      function M.disable()
        local ftype = vim.opt.filetype:get()
        if ftype == nil or ftype:len() <= 0 then
          return true
        end

        for _, value in ipairs(M.disabled_ftypes) do
          if value == ftype then
            return true
          end
        end

        return false
      end
    '';

    settings = {
      options = {
        icons_enabled = true;
        globalstatus = true;
        disabled_filetypes = [
          "TelescopePrompt"
          ""
        ];
      };

      sections = let
        mkAttrs = lib.nixvim.listToUnkeyedAttrs;
        mkRaw = lib.nixvim.mkRaw;

      in {
        lualine_a = [
          (mkAttrs ["mode"] // {
            cond = mkRaw "function() return not M.disable() end";
            fmt = mkRaw "string.upper";
          })
        ];

        lualine_b = [
          (mkAttrs ["branch"] // {
            cond = mkRaw ''
              function()
                return M.clamp({ min = 50, }) and not M.disable()
              end
            '';
          })
        ];

        lualine_c = [
          (mkAttrs [
            (mkRaw ''
              function()
                local clients = vim.lsp.get_clients({
                  bufnr = vim.fn.bufnr("%"),
                })
                if next(clients) ~= nil then
                  local lsp_list = ""
                  for _, client in ipairs(clients) do
                    if type(client.name) == 'string' and
                       string.match(client.name, "^%-?[%d%.]+%d$") == nil then
                      if lsp_list:len() >= 1 then
                        lsp_list = lsp_list .. ", " .. client.name
                      else
                        lsp_list = client.name
                      end
                    end
                  end

                  return lsp_list
                end
                
                return "No LSP"
              end
            '' // {
              cond = mkRaw ''
                function()
                  return M.clamp({ min = 85, }) and not M.disable()
                end
              '';
            })
          ] // {
            cond = mkRaw ''
              function()
                return M.clamp({ min = 85, }) and not M.disable()
              end
            '';
            separator = "";
            icon = " ";
          })

          (mkAttrs ["%="] // {
            separator = "";
            cond = mkRaw ''
              function()
                return M.clamp({ min = 50, max = 84, }) and not M.disable()
              end
            '';
          })
        ]; 

        lualine_x = [
          (mkAttrs ["filename"] // {
            symbols = {
              readonly = "(read-only)";
              modified = "*";
            };

            cond = mkRaw ''
              function()
                return M.clamp({ min = 64, }) and not M.disable()
              end
            '';

            newfile_status = false;
            shorting_target = 32;
            filestatus = true;
            separator = "";
          })

          (mkAttrs ["%="] // {
            separator = "";
            cond = mkRaw ''
              function()
                return M.clamp({ min = 64, }) and not M.disable()
              end
            '';
          })

          (mkAttrs ["diagnostics"] // {
            symbols = {
              error = " ";
              warn = " ";
            };

            sources = [
              "nvim_workspace_diagnostic"
              "nvim_diagnostic"
              "nvim_lsp"
            ];

            sections = [
              "error"
              "warn"
            ];

            update_in_insert = true;
            always_visible = true;
            colored = false;
            separator = "";
          })

          (mkAttrs ["%="] // {
            separator = "";
            cond = mkRaw ''
              function()
                return M.clamp({ max = 63, }) and not M.disable()
              end
            '';
          })
        ];

        lualine_y = [ 
          (mkAttrs ["filetype"] // {
            cond = mkRaw ''
              function()
                return M.clamp({ min = 50, max = 84, }) and not M.disable()
              end
            '';

            icon_only = true;
            padding = 2;
          })

          (mkAttrs ["filetype"] // {
            cond = mkRaw ''
              function()
                return M.clamp({ min = 85, }) and not M.disable()
              end
            '';

            fmt = mkRaw ''
              function(ftype)
                if type(ftype) == "string" then
                  if not M.stylized_ftype_names[ftype] then
                    return ftype:gsub("^%l", string.upper)
                  end

                  return M.stylized_ftype_names[ftype]
                end

                return ftype
              end
            '';

            separator = "";
          })
        ];

        lualine_z = [
          (mkAttrs ["location"] // {
            cond = mkRaw "function() return not M.disable() end";
          })
        ];
      };
    };
  };
}
