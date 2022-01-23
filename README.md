# gitui.nvim

[Gitui](https://github.com/extrawurst/gitui) in your Neovim

## Prerequisites

- Neovim >= 0.5.0
- [Gitui](https://github.com/extrawurst/gitui)

## Installation

[packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use 'aspeddro/gitui.nvim'
```

## Setup

```lua
require("gitui").setup()
```

## Configuration (optional)

Following are the default config for the `setup()`. If you want to override, just modify the option that you want then it will be merged with the default config.

```lua
{
  -- Command Options
  command = {
    -- Enable :Gitui command
    -- @type: bool
    enable = true,
  },
  -- Path to binary
  -- @type: string
  binary = "gitui",
  -- Argumens to gitui
  -- @type: table of string
  args = {},
  -- WIndow Options
  window = {
    options = {
      -- Width window in %
      -- @type: number
      width = 90,
      -- Height window in %
      -- @type: number
      height = 80,
      -- Border Style
      -- Enum: "none", "single", "rounded", "solid" or "shadow"
      -- @type: string
      border = "rounded",
    },
  },
}
```

## Lua API

```lua
require("gitui").open()
```

## TODO

- Add documentation
