return {
    {
        "eandrju/cellular-automaton.nvim",
        keys = {
            {
                "<leader>fml",
                function()
                    local animations = { "make_it_rain", "game_of_life" }
                    vim.cmd.CellularAutomaton(
                        animations[math.random(#animations)]
                    )
                end,
            },
        },
    },
}
