use std::fs::File;
use std::io::{BufRead, BufReader};
use std::io::{BufWriter, Write};
use unicode_segmentation::UnicodeSegmentation;

mod char_converter;
mod utils;

fn main() -> std::io::Result<()> {
    let utilities = utils::Utils::new();
    let pairs = utilities.get_filenames();

    for pair in pairs {
        let reader = BufReader::new(File::open(&pair.source)?);
        let mut writer = BufWriter::new(File::create(pair.destination)?);

        for line in reader.lines() {
            let converted = format!("{}\n", convert_line(&utilities.table, &line?));
            writer.write_all(converted.as_bytes())?;
        }

        writer.flush()?;
    }

    Ok(())
}

fn convert_line(table: &utils::Table, input_string: &str) -> String {
    let mut char_converter = char_converter::Converter::new();
    let cyrillic = format!("{input_string}_");

    let latin = UnicodeSegmentation::graphemes(cyrillic.as_str(), true)
        .map(|c| c.to_owned())
        .map(|c| char_converter.convert(table, &c.to_owned()))
        .collect::<String>();

    String::from(latin.strip_suffix('_').unwrap())
}
