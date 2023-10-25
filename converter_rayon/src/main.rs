use rayon::prelude::*;
use std::fs::File;
use std::io::{BufRead, BufReader};
use std::io::{BufWriter, Write};
use unicode_segmentation::UnicodeSegmentation;

mod utils;

fn main() {
    let mut util = utils::Utils::new();
    util.init_table();

    let pairs = util.get_filenames();

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
                            convert_char(&mut word_buffer, &mut needs_prefix, &util, c);
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

pub fn convert_char(buffer: &mut String, needs_prefix: &mut bool, util: &utils::Utils, char: &str) {
    let buf_len = buffer.len();

    match util.table.get(char) {
        Some(c) => {
            buffer.push_str(c);

            if (buf_len > 3 && !*needs_prefix)
                || util.hards.contains(char)
                || (!util.arguments.disable_obvious && buf_len == 0 && util.obvious.contains(char))
            {
                *needs_prefix = false;
            } else if util.softs.contains(char) {
                *needs_prefix = true;
            }
        }
        None => {
            buffer.push_str(char);
            *needs_prefix = false;
        }
    }
}
