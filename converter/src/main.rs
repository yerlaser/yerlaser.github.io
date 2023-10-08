use std::fs::File;
use std::io::{BufRead, BufReader};
use std::io::{Write, BufWriter};

mod utils;
mod convert;

fn main() -> std::io::Result<()> {
    let util = utils::Utils::new();
    let io_filenames = util.get_filenames();

    for filenames in io_filenames {
        let infile = File::open(&filenames.0)?;
        let reader = BufReader::new(infile);

        let outfile = File::create(filenames.1)?;
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
