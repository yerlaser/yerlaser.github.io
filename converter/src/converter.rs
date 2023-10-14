use std::collections::HashMap;

pub struct CharConverter {
    table: HashMap<String, String>,
    might_need_prefix: bool,
    accumulator: String,
}

impl CharConverter {
    const OBVIOUS: &'static str = "ЕГКегк";
    const HARDS: &'static str = "АҒҚОҰҺЫағқоұһы";
    const SOFTS: &'static str = "ӘЕӨҮІәеөүі";

    pub fn new() -> CharConverter {
        CharConverter {
            table: Self::construct_table(),
            might_need_prefix: true,
            accumulator: String::with_capacity(13),
        }
    }

    pub fn convert_char(&mut self, c: &str) -> String {
        let is_obvious = Self::OBVIOUS.contains(c);
        let is_hard = Self::HARDS.contains(c);
        let is_soft = Self::SOFTS.contains(c);
        let current: String;
        let acc_len = self.accumulator.len();

        match self.table.get(c) {
            Some(c) => {
                if self.might_need_prefix {
                    if is_hard || acc_len > 3 {
                        current = format!("{}{}", self.accumulator, c);
                        self.might_need_prefix = false;
                        self.accumulator = String::with_capacity(13);
                    } else if acc_len == 0 && is_obvious {
                        current = c.to_owned();
                        self.might_need_prefix = false;
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

    fn construct_table() -> HashMap<String, String> {
        let mut from_csv = crate::utils::readcsv::read_table().expect("table could not be read");
        let lows = from_csv
            .iter()
            .map(|i| (i.0.to_lowercase(), i.1.to_lowercase()))
            .collect::<HashMap<String, String>>();

        from_csv.extend(lows);
        from_csv
    }
}
