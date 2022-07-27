source /Users/yerlan.sergaziyev/Published/configs/config.nu
let-env config = ($env.config | upsert history_file_format "sqlite")
