use clap::Parser;

#[derive(Parser, Debug)]
#[command(author, version, about, long_about=None)]
pub struct CliArgs {
    #[arg(short, long, default_value_t = String::from("lat-"))]
    pub prefix: String,

    #[arg(short, long, default_value_t = String::new())]
    pub suffix: String,

    #[arg(short, long)]
    pub force: bool,

    pub input_filenames: Vec<String>,
}

pub fn parse() -> CliArgs {
    CliArgs::parse()
}

