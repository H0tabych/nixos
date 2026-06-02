# ~/nixos-config/home-manager/sgm/programs/neovim/modules/dap.nix
{pkgs, ...}: {
  plugins = {
    dap = {
      enable = true;
      adapters = {
        executables = {
          python = {
            command = "${pkgs.python3Packages.debugpy}/bin/debugpy-adapter";
            # Аргументы больше не нужны, адаптер сам запускается
          };
        };
        servers = {
          codelldb = {
            port = "\${port}";
            executable = {
              command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
              args = ["--port" "\${port}"];
            };
          };
        };
      };
      configurations = {
        python = [
          {
            type = "python";
            request = "launch";
            name = "Launch file";
            program = "\${file}";
            pythonPath = "${pkgs.python3}/bin/python";
          }
        ];
        cpp = [
          {
            type = "codelldb";
            request = "launch";
            name = "Launch C++";
            program = "\${fileDirname}/\${fileBasenameNoExtension}";
            cwd = "\${workspaceFolder}";
            stopOnEntry = false;
          }
        ];
      };
    };
    # UI отладчика
    dap-ui = {
      enable = true;
      settings = {
        auto_open = true;
        floating_borders = "rounded";
        layouts = [
          {
            elements = [
              {
                id = "scopes";
                size = 0.25;
              }
              {
                id = "breakpoints";
                size = 0.25;
              }
              {
                id = "stacks";
                size = 0.25;
              }
              {
                id = "watches";
                size = 0.25;
              }
            ];
            position = "left";
            size = 40;
          }
          {
            elements = [
              {
                id = "repl";
                size = 0.5;
              }
              {
                id = "console";
                size = 0.5;
              }
            ];
            position = "bottom";
            size = 10;
          }
        ];
      };
    };
    dap-virtual-text.enable = true;
  };
}
