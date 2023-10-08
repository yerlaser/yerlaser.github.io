use std::fs::File;
use std::io::{BufRead, BufReader};
use std::io::{Write, BufWriter};
use std::path::Path;

mod parseargs;
mod convert;

fn main() -> std::io::Result<()> {
    let arguments = parseargs::parse();
    let filenames = arguments.input_filenames;
    let suffix = arguments.suffix;
    for filename in filenames {
        let infile = File::open(&filename)?;
        let reader = BufReader::new(infile);

        let path = Path::new(&filename);
        let stem = path.file_stem().unwrap().to_str().unwrap();
        let ext = path.extension().unwrap().to_str().unwrap();
        let outfilename = format!("{stem}{suffix}.{ext}");
        let outfile = File::create(outfilename)?;
        let mut writer = BufWriter::new(outfile);

        for line in reader.lines() {
            let line = line?;
            let converted = format!("{}\n", convert::convert(&line));
            writer.write_all(converted.as_bytes())?;
        }

        writer.flush()?;
    }

    Ok(())
}
