use std::fs::File;
use std::io::{BufRead, BufReader};
use std::io::{BufWriter, Write};
use unicode_segmentation::UnicodeSegmentation;

mod char_converter;
mod utils;

fn main() {
    let utilities = utils::Utils::new();
    let pairs = utilities.get_filenames();

    let table = &utilities.table;
    let mut char_converter = char_converter::Converter::new();

    for pair in pairs {
        let source = pair.source;
        let reader = File::open(&source).expect(&format!("Cannot open {source}"));
        let reader = BufReader::new(reader);

        let destination = pair.destination;
        let writer = File::create(&destination).expect(&format!("Cannot create {destination}"));
        let mut writer = BufWriter::new(writer);

        #[allow(unused_assignments)]
        let mut cyrillic = String::with_capacity(300);
        #[allow(unused_assignments)]
        let mut latin = String::with_capacity(300);

        for line in reader.lines() {
            cyrillic = line.expect(&format!("Cannot read a line from {source}"));
            cyrillic.push_str("_");

            latin = UnicodeSegmentation::graphemes(cyrillic.as_str(), true)
                .map(|c| c.to_owned())
                .map(|c| char_converter.convert(table, &c.to_owned()))
                .collect::<String>();

            latin.replace_range((latin.len() - 1).., "\n");
            writer
                .write_all(latin.as_bytes())
                .expect(&format!("Cannot write a line to {destination}"));
        }

        writer.flush().expect(&format!("Cannot save {destination}"));
    }
}
