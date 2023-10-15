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

    let mut table = csv::Reader::from_reader(reader);
    let table = table.deserialize();
    let mut table = table
        .enumerate()
        .map(|(i, r)| {
            let row: TableRow = r.expect(&format!(
                "Row {} from conversation table could not be read",
                i + 1
            ));
            (row.cyr.to_owned(), row.lat.to_owned())
        })
        .collect::<super::Table>();

    let lows = table
        .iter()
        .map(|i| (i.0.to_lowercase(), i.1.to_lowercase()))
        .collect::<super::Table>();

    table.extend(lows);

    table
}
