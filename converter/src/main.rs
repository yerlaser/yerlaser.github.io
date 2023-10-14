use std::fs::File;
use std::io::{BufRead, BufReader};
use std::io::{BufWriter, Write};
use unicode_segmentation::UnicodeSegmentation;

mod char_converter;
mod utils;

fn main() {
    let utilities = utils::Utils::new();
    let pairs = utilities.get_filenames();

    for pair in pairs {
        let source = pair.source;
        let destination = pair.destination;

        let reader = File::open(&source).expect(&format!("Cannot open {source}"));
        let reader = BufReader::new(reader);

        let writer = File::create(&destination).expect(&format!("Cannot create {destination}"));
        let mut writer = BufWriter::new(writer);

        for line in reader.lines() {
            let line = line.expect(&format!("Cannot read a line from {source}"));
            let converted = format!("{}\n", convert_line(&utilities.table, &line));
            writer
                .write_all(converted.as_bytes())
                .expect(&format!("Cannot write a line to {destination}"));
        }

        writer
            .flush()
            .expect(&format!("Cannot save {}", &destination));
    }
}

fn convert_line(table: &utils::Table, source_string: &str) -> String {
    let mut char_converter = char_converter::Converter::new();
    let cyrillic = format!("{source_string}_");

    let latin = UnicodeSegmentation::graphemes(cyrillic.as_str(), true)
        .map(|c| c.to_owned())
        .map(|c| char_converter.convert(table, &c.to_owned()))
        .collect::<String>();

    String::from(latin.strip_suffix('_').unwrap())
}
