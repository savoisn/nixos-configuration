pkgs:

let
  mixformat = pkgs.vimUtils.buildVimPlugin {
    name = "mixformat";
    src = pkgs.fetchFromGitHub {
      owner = "mhinz";
      repo = "vim-mix-format";
      rev = "2a30a8aee29ebc0961caac6e63ea9f554ba656ed";
      sha256 = "1pcrb3walghvn31w33r0l2b7ampxddn58mv35y0r01p2cjq4b7gb";
    };
  };
  markdown-preview = pkgs.vimUtils.buildVimPlugin {
    name = "markdown-preview";
    src = pkgs.fetchFromGitHub {
      owner = "iamcco";
      repo = "markdown-preview.nvim";
      rev = "5c813eaf943ed7491ba855ad0cb563c31767debf";
      sha256 = "094sxyna76vsw7gp8y6qwb7ff1p5ch4zbsm29mbndlw83b4d8yh2";
    };
  };
  crystal = pkgs.vimUtils.buildVimPlugin {
    name = "crystal";
    src = pkgs.fetchFromGitHub {
      owner = "vim-crystal";
      repo = "vim-crystal";
      rev = "bc4f115de69fdeb4419e2cbef1981f0b39c6d972";
      sha256 = "17qr5rbchpgh75g14i5m899zp56c4zkj0yaj0h0p4x184xkjrxl3";
    };
  };
  svelte = pkgs.vimUtils.buildVimPlugin {
    name = "svelte";
    src = pkgs.fetchFromGitHub {
      owner = "evanleck";
      repo = "vim-svelte";
      rev = "f63fa77d621b25092081cce815effd7fbc169113";
      sha256 = "0j7j6ibrylv32y0vw002yayfg7xia59nm2952bhbwlkl6m2cwnz9";
    };
  };
  ember = pkgs.vimUtils.buildVimPlugin {
    name = "ember";
    src = pkgs.fetchFromGitHub {
      owner = "joukevandermaas";
      repo = "vim-ember-hbs";
      rev = "c47e1958a6c190c9d79ac66cb812f1a1d3b4e968";
      sha256 = "AypAVARFyhoT/zTtkluZnE6TsWV3ydv4h9EVI1GwXSs=";
    };
  };
  vlang = pkgs.vimUtils.buildVimPlugin {
    name = "vlang";
    src = pkgs.fetchFromGitHub {
      owner = "ollykel";
      repo = "v-vim";
      rev = "1dc1388bafb89072f8349dbd96f9462ae22237cb";
      sha256 = "AJqSUK05pq//0Nw331oTRUUrm/sO8eInTRYgvDM3i+w=";
    };
  };
  cmp-nvim-lsp-signature-help = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-nvim-lsp-signature-help";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp-signature-help";
      rev = "d2768cb1b83de649d57d967085fe73c5e01f8fd7";
      sha256 = "QISg2HRSXG7tlO1EI4J7lvh/gmyVii4+QUBzD3ZjNY4=";
    };
  };
  kdl = pkgs.vimUtils.buildVimPlugin {
    name = "kdl";
    src = pkgs.fetchFromGitHub {
      owner = "imsnif";
      repo = "kdl.vim";
      rev = "0396a7a063f2ffe627e4f5b16d27ffd864dd7d12";
      sha256 = "kcJZHR50nqJdKIisd7pFumfhx5aJqIwOQgdbw0o6gXM=";
    };
  };
  cellular-automaton = pkgs.vimUtils.buildVimPlugin {
    name = "cellular-automation";
    src = pkgs.fetchFromGitHub {
      owner = "Eandrju";
      repo = "cellular-automaton.vim";
      rev = "15b0fed53d8f7e58e88eae8fb8c3a9537fe90bd1";
      sha256 = "YFJ8TxxZH1ce+GCaogSJDLRT1gmGgh+KukKnzDFZWY8=";
    };
  };
in {
  custom_plugins = { 
    mixformat = mixformat;
    ember = ember;
    kdl = kdl;
    cellular-automaton = cellular-automaton;
#    cmp-nvim-lsp-signature-help = cmp-nvim-lsp-signature-help;
#    legendary-nvim = legendary;
  };
}
