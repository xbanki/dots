#   LSP Configuration
#
# Configures a spell checker, and language servers for many of the popular
# languages. Configures schematic validation for JSON, YAML and TOML.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ pkgs, lib, ... }:

{
  plugins = {
    lspconfig.enable = true;
    schemastore = {
      json.enable = true;
      yaml.enable = true;
    };
  };

  lsp = {
    inlayHints.enable = true;
    keymaps = [
      {
        lspBufAction = "definition";
        key = "gd";
      }
      {
        lspBufAction = "declaration";
        key = "gD";
      }
      {
        lspBufAction = "references";
        key = "gr";
      }
      {
        lspBufAction = "implementation";
        key = "gi";
      }
      {
        lspBufAction = "type_definition";
        key = "gt";
      }
      {
        lspBufAction = "rename";
        key = "rr";
      }
      {
        lspBufAction = "hover";
        key = "<leader><space>";
      }
    ];

    servers = {
      gopls = {
        enable = true;
        config.settings = {
          completeUnimported = true;
          analyses = {
            fieldalignment = true;
            unusedvariable = true;
            shadow = true;
          };

          hints = {
            compositeLiteralFields = true;
            assignVariableTypes = true;
            rangeVariableTypes = true;
            parameterNames = true;
            constantValues = true;
            ignoredError = true;
          };
        };
      };

      harper_ls = {
        enable = true;
        config.settings."harper-ls".linters = {
          sentence_capitalization = false;
          linking_verbs = true;
          boring_words = true;
        };
      };

      lua_ls = {
        enable = true;
        config.settings.Lua = {
          workspace.checkThirdParty = false;
          telemetry.enable = false;
          hint.enable = true;
        };
      };

      vtsls = {
        enable = true;
        config = {
          filetypes = [
            "typescriptreact"
            "javascriptreact"
            "typescript.jsx"
            "javascript.jsx"
            "typescript"
            "javascript"
            "vue"
          ];

          settings =
            let
              hints = {
                propertyDeclarationTypes.enabled = true;
                functionLikeReturnTypes.enabled = true;
                enumMemberValues.enabled = true;
                parameterNames.enabled = "all";
                parameterTypes.enabled = true;
                variableTypes.enabled = true;
              };

            in
            {
              javascript.inlayHints = hints;
              typescript = {
                tsserver.useSyntaxServer = false;
                inlayHints = hints;
              };

              vtsls.tsserver.globalPlugins = [
                {
                  location = lib.strings.concatStrings [
                    "${pkgs.vue-language-server}/"
                    "lib/language-tools/packages/"
                    "language-server/node_modules/"
                    "@vue/typescript-plugin"
                  ];

                  name = "@vue/typescript-plugin";
                  configNamespace = "typescript";
                  languages = [ "vue" ];
                }
              ];
            };
        };
      };

      rust_analyzer = {
        enable = true;
        config = {
          installCargo = true;
          installRustc = true;
        };
      };

      vue_ls = {
        enable = true;
        config.settings.vue.inlayHints = {
          inlineHandlerLeading = true;
          destructuredProps = true;
          optionsWrapper = true;
          missingProps = true;
          vBindShorthand = true;
        };
      };

      markdown_oxide.enable = true;
      tailwindcss.enable = true;
      pyright.enable = true;
      bashls.enable = true;
      jsonls.enable = true;
      nil_ls.enable = true;
      yamlls.enable = true;
      cssls.enable = true;
      taplo.enable = true;
      html.enable = true;
    };
  };
}
