{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.neovim =
    {
      config,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.nvf.nixosModules.default
      ];
      programs.nvf = {
        enable = true;

        settings = {
          vim = {
            maps = {
              insert = {
                "<C-h>" = {
                  action = "<Left>";
                  desc = "Move left";
                };

                "<C-j>" = {
                  action = "<Down>";
                  desc = "Move down";
                };

                "<C-k>" = {
                  action = "<Up>";
                  desc = "Move up";
                };

                "<C-l>" = {
                  action = "<Right>";
                  desc = "Move right";
                };
              };

              normal = {
                "<Tab>" = {
                  action = "<cmd>bnext<CR>";
                  desc = "Next buffer";
                };

                "<S-Tab>" = {
                  action = "<cmd>bprev<CR>";
                  desc = "Previous buffer";
                };

                "<C-c>" = {
                  action = "<cmd>noh<CR>";
                  desc = "Clear search highlights";
                };

                "<leader>ff" = {
                  action = "<cmd>Pick files<CR>";
                  desc = "Find files";
                };

                "<leader>bb" = {
                  action = "<cmd>Pick buffers<CR>";
                  desc = "Find buffers";
                };

                "<leader>fr" = {
                  action = "<cmd>Pick resume<CR>";
                  desc = "Resume finding";
                };

                "<leader>fw" = {
                  action = "<cmd>Pick grep_live<CR>";
                  desc = "Grep live";
                };

                "<leader>e" = {
                  action = "<cmd>lua MiniFiles.open()<CR>";
                  desc = "Open Mini Files";
                };

                "<leader>bq" = {
                  action = "<cmd>lua require('mini.bufremove').delete()<CR>";
                  desc = "Remove current buffer";
                };
              };
            };

            viAlias = true;
            vimAlias = true;

            opts = {
              termguicolors = true;
              shiftwidth = 2;
              smartindent = true;
              tabstop = 2;
              expandtab = true;
              softtabstop = 2;
              sidescrolloff = 2;
            };

            lineNumberMode = "relative";

            preventJunkFiles = true;

            undoFile.enable = true;

            theme = {
              enable = true;
              name = "catppuccin";
              style = "mocha";
              transparent = true;
              extraConfig = ''
                require("catppuccin").setup({
                  background = { light = "latte", dark = "mocha" },
                  float = {
                    transparent = true,
                    solid = true,
                  },
                  transparent_background = true,
                  compile = true,
                  integrations = {
                    snacks = {
                      enabled = true,
                      indent_scope_color = "lavender",
                    },
                    treesitter = true,
                    mini = {
                      enabled = true,
                    },
                  },
                })
              '';
            };

            ui.borders.enable = true;
            ui.borders.globalStyle = "none";

            lsp.enable = true;

            languages.nix = {
              enable = true;
              format.enable = true;
            };

            clipboard = {
              enable = true;
              registers = "unnamed,unnamedplus";

              providers.wl-copy.enable = true;
            };

            mini = {
              files.enable = true;
              pairs.enable = true;
              pick.enable = true;
              completion.enable = true;
            };
          };
        };
      };
    };
}
