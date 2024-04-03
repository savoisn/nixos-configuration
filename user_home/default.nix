{ pkgs, system, lib, python, ... }:

let
  myvim = (import ./nvim-custom-plugin.nix) pkgs;

in
{
  imports = [
    ./tools
    #(fetchGit { url = "https://github.com/NicolasGuilloux/shadow-nix"; ref = "v1.0.3"; } + "/import/home-manager.nix")
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-13.6.9"
    "electron-25.9.0"
  ];

  nixpkgs.config.allowUnfree = true;

  home.file.".xprofile".source = ./xprofile;
  home.stateVersion = "22.05";

  manual.manpages.enable = false;

  home.packages = with pkgs; [
    source-serif-pro
    acpi
    any-nix-shell
    audacious
    audacity
    blueman
    brightnessctl
    broot
    calibre
    cdrkit
    dunst
    gnome.cheese
    cowsay
    dbeaver
    deno
    docker-compose
    dune-release
    elixir
    erlang
    exercism
    fasd
    fd
    feh
    file
    fish
    flutter
    ffmpeg-full
    fortune
    galculator
    gcc
    gimp-with-plugins
    gitkraken
    gnumake
    go
    gromit-mpx
    gthumb
    helix
    htop
    imagemagick
    inkscape
    inotify-tools
    jo
    jq
    keepassxc
    kind
    libreoffice
    libnotify
    libsForQt5.okular
    maven
    maim
    mob
    mpv
    ngrok
    nushell
    nix-index
    nix-tree
    nodejs
    patchelf
    pciutils
    pcmanfm
    pipenv
    ponysay
    pwgen
    python3
    obsidian
    ocaml
    opam
    ranger
    rebar3
    #remarkable-toolchain
    ripgrep
    rlwrap
    rustup
    screenkey
    silver-searcher
    simplescreenrecorder
    shotcut
    shutter
    slack
    sqlite
    sqlite-utils
    sqlitebrowser
    starship
    steampipe
    python-swiftclient
    tlaplus
    transmission-gtk
    tdesktop
    udiskie
    uiua
    unison-ucm
    unzip
    upower
    usbutils
    v4l-utils
    vlc
    w3m
    watchman
    xorg.xbacklight
    xarchiver
    xclip
    xdotool
    xmind
    xorg.xkbcomp
    xorg.xhost
    xorg.xev
    xxkb
    yt-dlp
    zellij
    zip
  ];

  xresources.properties = {
    "xterm*background" = "darkgrey";
    "xterm*foreground" = "lightgray";
    "xterm*faceName" = "monospace:pixelsize=14";
    "*background" = "black";
    "*foreground" = "white";
    "URxvt.font" = "xft:monospace:size=12";
    "URxvt.scrollBar" = "false";
    "URxvt.keysym.C-Down" = "resize-font:smaller";
    "URxvt.keysym.C-Up" = "resize-font:bigger";
    "URxvt.iso14755" = "false";
    "URxvt.iso14755_52" = "false";
    "urxvt.perl-ext-common" = "default,resize-font";
    "URxvt.keysym.Shift-Control-V" = "eval:paste_clipboard";
    "URxvt.keysym.Shift-Control-C" = "eval:selection_to_clipboard";
  };


  services.udiskie = {
    enable = true;
    automount = true;
    tray = "always";
  };

  programs.emacs = {
    # FU emacs
    enable = false;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;


    #settings = {
    #  relativenumber = true;
    #  number = true;
    #};

    plugins =
      with pkgs.vimPlugins // myvim.custom_plugins; [
        #        dhall-vim
        ember

        # cellular-automaton
        #        harpoon
        #        mixformat
        #        nvim-treesitter
        #        nlua-nvim
        #        popup-nvim
        #        telescope-nvim
        #        telescope-fzy-native-nvim
        #        vim-true
        #        vim-fsharp
        #        vim-jsx-typescript
        #        vim-markdown
        #        vim-nix
        vim-surround
        zenburn

        # Basics
        vim-sensible
        # Add syntax/detection/indentation for langs
        vim-elixir
        vim-nix
        kotlin-vim
        dart-vim-plugin
        vim-flutter

        # File Tree
        nvim-web-devicons
        nvim-tree-lua
        # Git info
        gitsigns-nvim
        # Indent lines
        indent-blankline-nvim
        # Auto close
        nvim-autopairs
        # Fuzzy finder window
        telescope-nvim
        # Diagnostics window
        trouble-nvim
        # Keybindings window
        legendary-nvim
        # Better native input/select windows
        dressing-nvim
        # Tabs
        bufferline-nvim
        # Smooth scrolling
        vim-smoothie
        # Peek line search
        numb-nvim
        # Fast navigation
        lightspeed-nvim
        # Rainbow brackets
        rainbow-delimiters-nvim
        # Notify window
        nvim-notify
        # Commenting
        comment-nvim

        # Syntax highlighting
        nvim-treesitter

        nvim-treesitter-parsers.heex

        #        (nvim-treesitter.withPlugins
        #          (plugins: pkgs.nvim-ts-grammars.allGrammars)
        #        )


        # LSP
        nvim-lspconfig
        nvim-lsp-ts-utils
        # Mostly for linting
        null-ls-nvim
        # LSP status window
        fidget-nvim
        # Code actions sign
        nvim-lightbulb
        # Highlight selected symbol
        vim-illuminate

        # Completions
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        #cmp-nvim-lsp-signature-help
        nvim-cmp
        lspkind-nvim

        # Snippets
        luasnip
        cmp_luasnip

        # Debug adapter protocol
        nvim-dap
        telescope-dap-nvim
        nvim-dap-ui
        nvim-dap-virtual-text

        # theming
        nord-nvim

        # kdl
        kdl

        #unison
        unison

      ];

    extraPackages = with pkgs; [
      tree-sitter
      tree-sitter-grammars.tree-sitter-heex
      tree-sitter-grammars.tree-sitter-surface
      nodejs
      # Language Servers
      # Bash
      nodePackages.bash-language-server
      # Elixir
      elixir-ls
      # Erlang
      beam.packages.erlang.erlang-ls
      # Haskell
      pkgs.haskellPackages.haskell-language-server
      # Lua
      # sumneko-lua-language-server
      lua-language-server
      # Python
      python310Packages.python-lsp-server
      python310Packages.python-lsp-black
      python310Packages.yapf
      python310Packages.pyls-isort
      python310Packages.pylsp-mypy
      # Nix
      rnix-lsp
      nixpkgs-fmt
      statix
      # Rust
      rust-analyzer
      # Typescript
      nodePackages.typescript-language-server
      # VueJS
      nodePackages.vls
      # Web (ESLint, HTML, CSS, JSON)
      nodePackages.vscode-langservers-extracted
      # Telescope tools
      ripgrep
      fd
      # Volar
      nodePackages.volar
    ];

    #      extraConfig = builtins.readFile vim/vimrc;
    extraConfig = ''
      let g:elixir_ls_home = "${pkgs.elixir-ls}"
      :luafile ~/.config/nvim/lua/init.lua
    '';

  };

  programs.tmux = {
    enable = true;
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "onedark";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
      keys.normal = {
        space = {
          space = "file_picker";
          w = ":w";
          q = ":q";
        };
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = { vim = "nvim"; dc = "docker-compose"; };
    initExtra = ''
            any-nix-shell zsh --info-right | source /dev/stdin
            source ~/.zshrc_functions
            export PATH=$PATH:~/bin:~/bin/bats/bin:~/.mix/escripts
            alias create-typescript-react=npx create-react-app --template typescript
            test -r /home/nico/.opam/opam-init/init.zsh && . /home/nico/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
            PROMPT='%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%X]}%{$reset_color%} %{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info)
      %{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '
    '';
    envExtra = ''
      GOPATH='/home/nico/.gopath'
    '';
  };


  # Enable Oh-my-zsh
  programs.zsh.oh-my-zsh = {
    enable = true;
    theme = "candy";
    plugins = [ "git" "sudo" "docker" "mix" "jump" "golang" ];
  };


  programs.firefox = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Nicolas Savois";
    userEmail = "nicolas.savois@gmail.com";
    extraConfig = {
      push = {
        default = "current";
      };
      credential.helper = "cache";
      init.defaultBranch = "main";

    };
    #extraConfig = ''
    #[push]
    #default = current
    #'';
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };


  #programs.shadow-client = {
  ##enable = true;
  #channel = "preprod";
  #};
  programs.zellij = {
    enable = true;
  };

  programs.fish = {
    enable = true;

    shellAliases = {
      "sqlite3" = "rlwrap sqlite3";
      "l" = "ls -lastr";
    };
    shellInit = "any-nix-shell fish --info-right | source";

    functions = {
      fish_greeting = {
        body = "";
      };
    };
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
          sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
        };
      }

      # oh-my-fish plugins are stored in their own repositories, which
      # makes them simple to import into home-manager.
      {
        name = "fasd";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-fasd";
          rev = "38a5b6b6011106092009549e52249c6d6f501fba";
          sha256 = "06v37hqy5yrv5a6ssd1p3cjd9y3hnp19d3ab7dag56fs1qmgyhbs";
        };
      }
    ];
  };

  programs.nushell = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "/home/nico/.nix-profile/bin/fish";
      };

      window.dimensions = {
        lines = 3;
        columns = 200;
      };
      key_bindings = [
        {
          key = "K";
          mods = "Control";
          chars = "\\x0c";
        }
      ];

      colors = {
        primary = {
          background = "#2e3440";
          foreground = "#d8dee9";
          dim_foreground = "#a5abb6";
        };
        cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };
        vi_mode_cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };
        selection = {
          text = "CellForeground";
          background = "#4c566a";
        };
        search = {
          matches = {
            foreground = "CellBackground";
            background = "#88c0d0";
          };
          footer_bar = {
            background = "#434c5e";
            foreground = "#d8dee9";
          };
        };
        normal = {
          black = "#3b4252";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#88c0d0";
          white = "#e5e9f0";
        };
        bright = {
          black = "#4c566a";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#8fbcbb";
          white = "#eceff4";
        };
        dim = {
          black = "#373e4d";
          red = "#94545d";
          green = "#809575";
          yellow = "#b29e75";
          blue = "#68809a";
          magenta = "#8c738c";
          cyan = "#6d96a5";
          white = "#aeb3bb";
        };
      };
    };
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-multi-rtmp
    ];
  };

  services = {
    copyq = {
      enable = true;
    };

    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
      pinentryFlavor = "curses";
    };
  };

  programs.home-manager = {
    enable = true;
    path = "…";
  };
}
