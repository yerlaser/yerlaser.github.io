use std::collections::HashMap;
use std::error::Error;
use std::fs::File;
use std::io::BufReader;

#[derive(Debug, serde::Deserialize)]
pub struct TableRow {
    cyr: String,
    lat: String,
}

pub fn read_table() -> Result<HashMap<String, String>, Box<dyn Error>> {
    let reader = BufReader::new(File::open("conversion_table.csv")?);
    let mut table = csv::Reader::from_reader(reader);
    let table = table.deserialize();
    let results = table
        .map(|r| {
            let row: TableRow = r.expect("Some rows could not be read");
            (row.cyr.to_owned(), row.lat.to_owned())
        })
        .collect();
    Ok(results)
}
