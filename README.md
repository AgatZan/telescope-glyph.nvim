# telescope-glyph.nvim

An extension for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
that allows you to search font glyphs

<!-- markdownlint-disable-next-line -->
<img width="800" alt="screenshot" src="https://user-images.githubusercontent.com/47070852/124722843-07b16f00-df3d-11eb-891c-9a316e8d577c.gif">

*Same as above but shows glyphs instead of emojis*

## Get Started

Requirements: 
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)

### Install and load this plugin:

Via [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use('AgatZan/telescope-glyph.nvim')
```
Via [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
return { 'AgatZan/telescope-glyph.nvim' } 
```
Add following to your Telescope config
```
require('telescope').load_extension('glyph')
```

## Usage
```
:Telescope glyph
```

## Configuraion

### Types
`Glyph |=  
  name: string  
  value: string Inserted value  
  description: string`
```lua
{
 name = "Glyph name",
 value = "",
 description = "C lang icon",
}
```
Extension Scheme
| name|type | Description | Default |
| --- |---|---|---|
| action |fun( glyph: Glyph ):nil | Function that will be called after choosing glyph | yank to reg |
| base_glyph | boolean | Insert [base glyph](#glyph) | true |
| base_emoji | boolean | Insert [base_emoji](https://github.com/xiyaowong/telescope-emoji.nvim/blob/master/lua/telescope-emoji/init.lua) | false |
| glyphs | Glyph[] | Your glyphs | nil |
 
**It's optional.**
by default
```lua
telescope.setup {
    extensions = {
        glyph = {
            action = function(glyph)
            -- argument glyph is a table.
            -- {name="", value="", category="", description=""}
                vim.fn.setreg("*", glyph.value)
                print([[Press p or "*p to paste this glyph]] .. glyph.value)
            -- insert glyph when picked
            -- vim.api.nvim_put({ glyph.value }, 'c', false, true)
            end,
            base_glyph = true,
            base_emoji = false,
            glyphs = {},
        },
    },
}
```
## TODO:
- [ ] Picker agnostic
- [ ] Thinking about table compilation

## Credit
This project is a direct fork of [telescope-glyph.nvim](https://github.com/ghassan0/telescope-glyph.nvim) to provide font glyphs instead of emojis.
