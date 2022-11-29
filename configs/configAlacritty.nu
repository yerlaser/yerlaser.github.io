source /Users/yerlan.sergaziyev/Published/configs/config.nu
alias jour = hx --config /Users/yerlan.sergaziyev/Published/configs/config.toml ~/journal.md
# alias vi = hx --config /Users/yerlan.sergaziyev/Published/configs/config.toml
let-env config = ($env.config | upsert history {history_file_format: "sqlite"})
