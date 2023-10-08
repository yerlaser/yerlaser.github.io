use clap::Parser;

#[derive(Parser, Debug)]
#[command(author, version, about, long_about=None)]
pub struct Args {
    #[arg(short = 's', long, default_value_t = String::from("-lat"))]
    pub suffix: String,
    pub input_filenames: Vec<String>,
}

pub fn parse() -> Args {
    Args::parse()
}

