use std::collections::HashMap;
use unicode_segmentation::UnicodeSegmentation;

pub fn convert(input_string: &str) -> String {
    let mut table = HashMap::from([
        (String::from("а"), String::from("a")),
        (String::from("ә"), String::from("a")),
        (String::from("б"), String::from("b")),
        (String::from("в"), String::from("v")),
        (String::from("г"), String::from("g")),
        (String::from("ғ"), String::from("q")),
        (String::from("д"), String::from("d")),
        (String::from("е"), String::from("e")),
        (String::from("ё"), String::from("e")),
        (String::from("ж"), String::from("j")),
        (String::from("з"), String::from("z")),
        (String::from("и"), String::from("y")),
        (String::from("й"), String::from("y")),
        (String::from("к"), String::from("c")),
        (String::from("қ"), String::from("k")),
        (String::from("л"), String::from("l")),
        (String::from("м"), String::from("m")),
        (String::from("н"), String::from("n")),
        (String::from("ң"), String::from("nh")),
        (String::from("о"), String::from("o")),
        (String::from("ө"), String::from("o")),
        (String::from("п"), String::from("p")),
        (String::from("р"), String::from("r")),
        (String::from("с"), String::from("s")),
        (String::from("т"), String::from("t")),
        (String::from("у"), String::from("w")),
        (String::from("ұ"), String::from("u")),
        (String::from("ү"), String::from("u")),
        (String::from("ф"), String::from("f")),
        (String::from("х"), String::from("kh")),
        (String::from("һ"), String::from("kh")),
        (String::from("ц"), String::from("tz")),
        (String::from("ч"), String::from("ch")),
        (String::from("ш"), String::from("sh")),
        (String::from("щ"), String::from("sh")),
        (String::from("ъ"), String::from("")),
        (String::from("ы"), String::from("i")),
        (String::from("і"), String::from("i")),
        (String::from("ь"), String::from("")),
        (String::from("э"), String::from("e")),
        (String::from("ю"), String::from("yu")),
        (String::from("я"), String::from("ya")),
    ]);
    let capitals = table
        .iter()
        .map(|i| (i.0.to_uppercase(), i.1.to_uppercase()))
        .collect::<HashMap<String, String>>();
    table.extend(capitals);
    let latin = UnicodeSegmentation::graphemes(input_string, true).collect::<Vec<&str>>();
    let latin = latin
        .iter()
        .map(|c| c.to_owned())
        .map(|c| table.get(c).unwrap_or(&c.to_owned()).to_owned());
    latin.map(|rstr| rstr.to_owned()).collect::<String>()
}
