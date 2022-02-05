# nvim
nvim config.

Good Configuration Framework copied from https://github.com/ayamir/nvimdots

the core idea is seperate the main config from the plugin config, which can be found in many IDE-like neovim configs like LunarVim or NeoChad.

```
./
├── init.lua
├── lua
│   ├── core
│   │   ├── autocmd.lua     
│   │   ├── global.lua
│   │   ├── init.lua
│   │   ├── mapping.lua
│   │   ├── options.lua
│   │   └── pack.lua
│   ├── keymap
│   │   ├── bind.lua
│   │   ├── config.lua
│   │   └── init.lua
│   └── modules
│       ├── completion
│       │   ├── config.lua
│       │   ├── lsp.lua
│       │   └── plugins.lua
│       ├── editor
│       │   ├── config.lua
│       │   └── plugins.lua
│       ├── lang
│       │   ├── config.lua
│       │   └── plugins.lua
│       ├── tools
│       │   ├── config.lua
│       │   └── plugins.lua
│       └── ui
│           ├── config.lua
│           └── plugins.lua
└── my-snippets
    ├── package.json
    └── snippets
        └── go.json


```
