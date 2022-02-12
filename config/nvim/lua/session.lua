-- require("session_manager").setup({
--     -- autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
--     autoload_mode = false,
--     autosave_last_session = true, -- Automatically save last session on exit and on session switch.
--     autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
--         "gitcommit",
--         "alpha",
--         "checkhealth",
--         "", -- empty files types
--     },
-- })

require("persisted").setup()
