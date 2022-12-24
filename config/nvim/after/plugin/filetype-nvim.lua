require("filetype").setup({
    overrides = {
        extensions = {
            -- Set the filetype of *.pn files to potion
            json = "jsonc",
        },
        literal = {
            -- Set the filetype of files named "MyBackupFile" to lua
            environment = "config",
            profile = "config",
        },
        complex = {
            -- Set the filetype of any full filename matching the regex to gitconfig
            ["*config$"] = "config",
        },

        detection_settings = {
            shebang_map = {
                dash = "sh",
            },
        },
    },
})
