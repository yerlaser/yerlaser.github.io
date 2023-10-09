use std::collections::HashMap;
use unicode_segmentation::UnicodeSegmentation;

struct CharConverter {
    table: HashMap<String, String>,
    might_need_prefix: bool,
    accumulator: String,
}

impl CharConverter {
    const HARDS: &'static str = "АҒҚОҰҺЫағқоұһы";
    const SOFTS: &'static str = "ӘЕӨҮІәеөүі";

    fn new() -> CharConverter {
        CharConverter {
            table: get_table(),
            might_need_prefix: true,
            accumulator: String::with_capacity(13),
        }
    }

    fn convert_char(&mut self, c: &str) -> String {
        let is_hard = Self::HARDS.contains(c);
        let is_soft = Self::SOFTS.contains(c);
        let current: String;

        match self.table.get(c) {
            Some(c) => {
                if self.might_need_prefix {
                    if is_hard || self.accumulator.len() > 3 {
                        current = format!("{}{}", self.accumulator, c);
                        self.might_need_prefix = false;
                        self.accumulator = String::with_capacity(13);
                    } else if is_soft {
                        current = format!("'{}{}", self.accumulator, c);
                        self.might_need_prefix = false;
                        self.accumulator = String::with_capacity(13);
                    } else {
                        current = String::new();
                        self.accumulator = format!("{}{}", self.accumulator, c);
                    }
                } else {
                    current = c.to_owned();
                }
            }
            None => {
                current = format!("{}{}", self.accumulator, c.to_owned());
                self.might_need_prefix = true;
                self.accumulator = String::with_capacity(13);
            }
        };

        current
    }
}

pub fn convert_line(input_string: &str) -> String {
    let mut converter = CharConverter::new();
    let cyrillic = format!("{input_string}_");

    let latin = UnicodeSegmentation::graphemes(cyrillic.as_str(), true)
        .map(|c| c.to_owned())
        .map(|c| converter.convert_char(&c.to_owned()))
        .collect::<String>();

    String::from(latin.strip_suffix('_').unwrap())
        .replace("'E", "E")
        .replace("'e", "e")
        .replace("'G", "G")
        .replace("'g", "g")
        .replace("'K", "K")
        .replace("'k", "k")
}

fn get_table() -> HashMap<String, String> {
    let mut caps = HashMap::from([
        (String::from("А"), String::from("A")),
        (String::from("Ә"), String::from("A")),
        (String::from("Б"), String::from("B")),
        (String::from("В"), String::from("V")),
        (String::from("Г"), String::from("G")),
        (String::from("Ғ"), String::from("C")),
        (String::from("Д"), String::from("D")),
        (String::from("Е"), String::from("E")),
        (String::from("Ё"), String::from("E")),
        (String::from("Ж"), String::from("J")),
        (String::from("З"), String::from("Z")),
        (String::from("И"), String::from("Y")),
        (String::from("Й"), String::from("Y")),
        (String::from("К"), String::from("K")),
        (String::from("Қ"), String::from("Q")),
        (String::from("Л"), String::from("L")),
        (String::from("М"), String::from("M")),
        (String::from("Н"), String::from("N")),
        (String::from("Ң"), String::from("Nh")),
        (String::from("О"), String::from("O")),
        (String::from("Ө"), String::from("O")),
        (String::from("П"), String::from("P")),
        (String::from("Р"), String::from("R")),
        (String::from("С"), String::from("S")),
        (String::from("Т"), String::from("T")),
        (String::from("У"), String::from("W")),
        (String::from("Ұ"), String::from("U")),
        (String::from("Ү"), String::from("U")),
        (String::from("Ф"), String::from("F")),
        (String::from("Х"), String::from("Kh")),
        (String::from("Һ"), String::from("Kh")),
        (String::from("Ц"), String::from("Tz")),
        (String::from("Ч"), String::from("Ch")),
        (String::from("Ш"), String::from("Sh")),
        (String::from("Щ"), String::from("Sh")),
        (String::from("Ъ"), String::from("")),
        (String::from("Ы"), String::from("I")),
        (String::from("І"), String::from("I")),
        (String::from("Ь"), String::from("")),
        (String::from("Э"), String::from("E")),
        (String::from("Ю"), String::from("Yu")),
        (String::from("Я"), String::from("Ya")),
    ]);

    let lows = caps
        .iter()
        .map(|i| (i.0.to_lowercase(), i.1.to_lowercase()))
        .collect::<HashMap<String, String>>();

    caps.extend(lows);
    caps
}
