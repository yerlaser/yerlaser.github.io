use std::fs::File;
use std::io::{BufRead, BufReader};
use std::io::{Write, BufWriter};

mod utils;
mod convert;

fn main() -> std::io::Result<()> {
    let util = utils::Utils::new();
    let pairs = util.get_filenames();

    for pair in pairs {
        let infile = File::open(&pair.0)?;
        let reader = BufReader::new(infile);

        let outfile = File::create(pair.1)?;
        let mut writer = BufWriter::new(outfile);

        for line in reader.lines() {
            let line = line?;
            let converted = format!("{}\n", convert::convert_line(&line));

            writer.write_all(converted.as_bytes())?;
        }

        writer.flush()?;
    }

    Ok(())
}
