local so = function(id,after)
    vim.opt.rtp:append("~/.local/share/nvim/plugins/" .. id)
    if after then
        vim.opt.rtp:append("~/.local/share/nvim/plugins/" .. id .. "/after")
    end
end

if os.getenv("COPE") then
    print "COPILOT: Activated"
    so("copilot.vim")
    vim.keymap.set('i', '<Right>', 'copilot#Accept("<Right>")', {
      expr = true,
      replace_keycodes = false
    })
    vim.g.copilot_no_tab_map = true
end

