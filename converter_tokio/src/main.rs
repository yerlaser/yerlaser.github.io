use std::fs::File;
use std::io::{BufRead, BufReader};
use std::io::{BufWriter, Write};
use std::sync::Arc;
use tokio::task::{self};
use unicode_segmentation::UnicodeSegmentation;

mod char_converter;
mod utils;

#[tokio::main]
async fn main() {
    let utilities = utils::Utils::new();
    let pairs = utilities.get_filenames();

    let table = Arc::new(utilities.get_table());
    let disable_obvious = utilities.arguments.disable_obvious;

    let mut handles: Vec<task::JoinHandle<String>> = vec![];

    for pair in pairs {
        let table = table.clone();
        handles.push(task::spawn_blocking(move || {
            let mut char_converter = char_converter::Converter::new();
            let source = &pair.source;
            let reader = File::open(source).expect(&format!("Cannot open {source}"));
            let reader = BufReader::new(reader);

            let destination = &pair.destination;
            let writer = File::create(destination).expect(&format!("Cannot create {destination}"));
            let mut writer = BufWriter::new(writer);

            #[allow(unused_assignments)]
            let mut cyrillic = String::with_capacity(500);
            #[allow(unused_assignments)]
            let mut latin = String::with_capacity(500);

            for line in reader.lines() {
                cyrillic = line.expect(&format!("Cannot read a line from {source}"));
                cyrillic.push('_');

                latin = UnicodeSegmentation::graphemes(cyrillic.as_str(), true)
                    .map(|c| c.to_owned())
                    .map(|c| char_converter.convert(&table, disable_obvious, &c.to_owned()))
                    .collect::<String>();

                latin.replace_range((latin.len() - 1).., "\n");
                writer
                    .write_all(latin.as_bytes())
                    .expect(&format!("Cannot write a line to {destination}"));
            }

            writer.flush().expect(&format!("Cannot save {destination}"));
            source.to_owned()
        }));
    }

    for handle in handles {
        let filename = handle.await.unwrap();
        println!("Finished {filename}");
    }
}
