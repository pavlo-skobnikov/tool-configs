require("pavlo_skobnikov.remap")
require("pavlo_skobnikov.packer")
require("pavlo_skobnikov.set")

-- SET THEME
require('onedark').setup {
    -- Main options --
    style = 'warmer', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'bold',
        strings = 'none',
        variables = 'italic'
    },

    -- Lualine options --
    lualine = {
        transparent = false, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}

require('onedark').load()
