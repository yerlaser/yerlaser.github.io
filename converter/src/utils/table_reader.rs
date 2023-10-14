use std::fs::File;
use std::io::BufReader;

#[derive(Debug, serde::Deserialize)]
struct TableRow {
    cyr: String,
    lat: String,
}

pub fn read_table() -> super::Table {
    let reader = File::open("conversion_table.csv").expect("Cannot open conversion table file");
    let reader = BufReader::new(reader);

    let mut from_csv = csv::Reader::from_reader(reader);
    let from_csv = from_csv.deserialize();
    let from_csv = from_csv
        .enumerate()
        .map(|(i, r)| {
            let row: TableRow = r.expect(&format!(
                "Row {} from conversation table could not be read",
                i + 1
            ));
            (row.cyr.to_owned(), row.lat.to_owned())
        })
        .collect::<super::Table>();

    let mut table = from_csv.clone();
    let lows = from_csv
        .iter()
        .map(|i| (i.0.to_lowercase(), i.1.to_lowercase()))
        .collect::<super::Table>();

    table.extend(lows);

    table
}
