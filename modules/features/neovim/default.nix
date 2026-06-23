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
            keymaps = [
              {
                key = "<C-h>";
                mode = "i";
                action = "<Left>";
                desc = "Move left";
              }
              {
                key = "<C-j>";
                mode = "i";
                action = "<Down>";
                desc = "Move down";
              }
              {
                key = "<C-k>";
                mode = "i";
                action = "<Up>";
                desc = "Move up";
              }
              {
                key = "<C-l>";
                mode = "i";
                action = "<Right>";
                desc = "Move right";
              }
              {
                key = "<Tab>";
                mode = "n";
                action = "<cmd>bnext<CR>";
                desc = "Next buffer";
              }
              {
                key = "<S-Tab>";
                mode = "n";
                action = "<cmd>bprev<CR>";
                desc = "Previous buffer";
              }
              {
                key = "<C-c>";
                mode = "n";
                action = "<cmd>noh<CR>";
                desc = "Clear search highlights";
              }
              {
                key = "<leader>ff";
                mode = "n";
                action = "<cmd>Pick files<CR>";
                desc = "Find files";
              }
              {
                key = "<leader>bb";
                mode = "n";
                action = "<cmd>Pick buffers<CR>";
                desc = "Find buffers";
              }
              {
                key = "<leader>fr";
                mode = "n";
                action = "<cmd>Pick resume<CR>";
                desc = "Resume finding";
              }
              {
                key = "<leader>fw";
                mode = "n";
                action = "<cmd>Pick grep_live<CR>";
                desc = "Grep live";
              }
              {
                key = "<leader>e";
                mode = "n";
                action = "<cmd>lua MiniFiles.open()<CR>";
                desc = "Open Mini Files";
              }
              {
                key = "<leader>bq";
                mode = "n";
                action = "<cmd>lua require('mini.bufremove').delete()<CR>";
                desc = "Remove current buffer";
              }
            ];

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

            ui.borders.enable = true;
            ui.borders.globalStyle = "none";

            lsp.enable = true;

            languages = {
              go = {
                enable = true;
                extensions.gopher-nvim.enable = true;
              };
              nix = {
                enable = true;
                format.enable = true;
              };
              typescript = {
                enable = true;
                format.enable = true;
              };
              html = {
                enable = true;
                format.enable = true;
              };
              css = {
                enable = true;
                format.enable = true;
              };
              svelte = {
                enable = true;
                format.enable = true;
              };
            };

            clipboard = {
              enable = true;
              registers = "unnamedplus";

              providers.wl-copy.enable = true;
            };

            mini = {
              files.enable = true;
              pairs.enable = true;
              pick.enable = true;
              completion.enable = true;
            };

            terminal.toggleterm = {
              enable = true;
              setupOpts = {
                winbar.enabled = false;
              };
            };

            startPlugins = [
              "catppuccin"
              "mini-clue"
            ];

            luaConfigRC.catppuccin = builtins.readFile ./catppuccin.lua;
            luaConfigRC.mini-clue = builtins.readFile ./mini-clue.lua;
          };
        };
      };
    };
}
