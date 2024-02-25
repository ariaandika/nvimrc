local c = require("onedark.palette")

function ColorSetup(style)
    require('onedark').setup {
        style = style or 'dark',
        transparent = true,
        highlights = {
            ["@parameter"] = {fmt = 'italic,bold'},
            ["@parameter.reference"] = {fg = c.dark.red},
        },
        code_style = {
            comments = 'bold',
            -- keywords = 'none',
            -- functions = 'none',
            -- strings = 'none',
            -- variables = 'none'
        },
    }
    -- comment
    require'onedark'.load()
end

-- TODO: false
ColorSetup()

