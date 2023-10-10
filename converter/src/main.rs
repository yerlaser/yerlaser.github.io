use std::fs::File;
use std::io::{BufRead, BufReader};
use std::io::{BufWriter, Write};
use unicode_segmentation::UnicodeSegmentation;

mod converter;
mod utils;

fn main() -> std::io::Result<()> {
    let pairs = utils::ArgProcessor::new().get_filenames();

    for pair in pairs {
        let reader = BufReader::new(File::open(&pair.0)?);
        let mut writer = BufWriter::new(File::create(pair.1)?);

        for line in reader.lines() {
            let converted = format!("{}\n", convert_line(&line?));
            writer.write_all(converted.as_bytes())?;
        }

        writer.flush()?;
    }

    Ok(())
}

fn convert_line(input_string: &str) -> String {
    let mut converter = converter::CharConverter::new();
    let cyrillic = format!("{input_string}_");

    let latin = UnicodeSegmentation::graphemes(cyrillic.as_str(), true)
        .map(|c| c.to_owned())
        .map(|c| converter.convert_char(&c.to_owned()))
        .collect::<String>();

    String::from(latin.strip_suffix('_').unwrap())
}
