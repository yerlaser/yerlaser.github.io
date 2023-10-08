use std::collections::HashMap;
use unicode_segmentation::UnicodeSegmentation;

pub fn convert(input_string: &str) -> String {
    let mut table = HashMap::from([
        (String::from("А"), String::from("A")),
        (String::from("Ә"), String::from("A")),
        (String::from("Б"), String::from("B")),
        (String::from("В"), String::from("V")),
        (String::from("Г"), String::from("G")),
        (String::from("Ғ"), String::from("Q")),
        (String::from("Д"), String::from("D")),
        (String::from("Е"), String::from("E")),
        (String::from("Ё"), String::from("E")),
        (String::from("Ж"), String::from("J")),
        (String::from("З"), String::from("Z")),
        (String::from("И"), String::from("Y")),
        (String::from("Й"), String::from("Y")),
        (String::from("К"), String::from("C")),
        (String::from("Қ"), String::from("K")),
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
    let lowcase = table
        .iter()
        .map(|i| (i.0.to_lowercase(), i.1.to_lowercase()))
        .collect::<HashMap<String, String>>();
    table.extend(lowcase);
    let latin = UnicodeSegmentation::graphemes(input_string, true).collect::<Vec<&str>>();
    let latin = latin
        .iter()
        .map(|c| c.to_owned())
        .map(|c| table.get(c).unwrap_or(&c.to_owned()).to_owned());
    latin.map(|rstr| rstr.to_owned()).collect::<String>()
}
