use std::fs::File;
use std::io::{BufRead, BufReader};
use std::io::{BufWriter, Write};

mod convert;
mod utils;

fn main() -> std::io::Result<()> {
    let pairs = utils::Utils::new().get_filenames();

    for pair in pairs {
        let reader = BufReader::new(File::open(&pair.0)?);
        let mut writer = BufWriter::new(File::create(pair.1)?);

        for line in reader.lines() {
            let converted = format!("{}\n", convert::convert_line(&line?));
            writer.write_all(converted.as_bytes())?;
        }

        writer.flush()?;
    }

    Ok(())
}
