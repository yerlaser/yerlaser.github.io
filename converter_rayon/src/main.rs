use rayon::prelude::*;
use std::fs::File;
use std::io::{BufRead, BufReader};
use std::io::{BufWriter, Write};
use unicode_segmentation::UnicodeSegmentation;

mod utils;

fn main() {
    let utilities = utils::Utils::new();
    let pairs = utilities.get_filenames();

    let table = utilities.get_table();
    let disable_obvious = utilities.arguments.disable_obvious;

    pairs.par_iter().for_each(|pair| {
        let source = &pair.source;
        let reader = File::open(source).expect(&format!("Cannot open {source}"));
        let reader = BufReader::new(reader);

        let destination = &pair.destination;
        let writer = File::create(destination).expect(&format!("Cannot create {destination}"));
        let mut writer = BufWriter::new(writer);
        let mut line_buffer = String::with_capacity(500);
        let mut word_buffer = String::with_capacity(50);

        reader.lines().for_each(|line_result| {
            match line_result {
                Ok(line) => {
                    let mut prev_end = 0;
                    let mut needs_prefix = false;
                    line.unicode_word_indices().for_each(|(i, word)| {
                        line_buffer.push_str(&line[prev_end..i]);
                        prev_end = i + word.len();

                        UnicodeSegmentation::graphemes(word, true).for_each(|c| {
                            convert_char(
                                &mut word_buffer,
                                &mut needs_prefix,
                                c,
                                &table,
                                disable_obvious,
                            );
                        });
                        if needs_prefix {
                            line_buffer.push('\'');
                        }
                        line_buffer.push_str(&word_buffer);
                        word_buffer.clear();
                        needs_prefix = false;
                    });
                    line_buffer.push('\n');
                }
                Err(_) => {
                    panic!("Cannot read a line from {source}")
                }
            };

            writer
                .write_all(line_buffer.as_bytes())
                .expect(&format!("Cannot write a line to {destination}"));
            line_buffer.clear();
        });

        writer.flush().expect(&format!("Cannot save {destination}"));
        println!("Finished {source}, wrote to {destination}");
    });
}

pub fn convert_char(
    buffer: &mut String,
    needs_prefix: &mut bool,
    char: &str,
    table: &utils::Table,
    disable_obvious: bool,
) {
    static OBVIOUS: &'static str = "ЕГКегк";
    static HARDS: &'static str = "АҒҚОҰҺЫЭағқоұһыэ";
    static SOFTS: &'static str = "ӘЕӨҮІәеөүі";
    let is_obvious = OBVIOUS.contains(char);
    let is_hard = HARDS.contains(char);
    let is_soft = SOFTS.contains(char);
    let buf_len = buffer.len();

    match table.get(char) {
        Some(c) => {
            buffer.push_str(c);
            if is_hard
                || (!*needs_prefix && buf_len > 3)
                || (!disable_obvious && buf_len == 0 && is_obvious)
            {
                *needs_prefix = false;
            } else if is_soft {
                *needs_prefix = true;
            }
        }
        None => {
            buffer.push_str(char);
        }
    }
}
