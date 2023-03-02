source ~/Published/configs/config.nu

let-env config = ($env.config | upsert history {
  max_size: 10000
  sync_on_enter: true
  file_format: "sqlite"
})
