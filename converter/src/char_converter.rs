pub struct Converter {
    might_need_prefix: bool,
    accumulator: String,
}

impl Converter {
    const OBVIOUS: &'static str = "ЕГКегк";
    const HARDS: &'static str = "АҒҚОҰҺЫағқоұһы";
    const SOFTS: &'static str = "ӘЕӨҮІәеөүі";

    pub fn new() -> Converter {
        Converter {
            might_need_prefix: true,
            accumulator: String::with_capacity(13),
        }
    }

    pub fn convert(&mut self, table: &super::utils::Table, c: &str) -> String {
        let is_obvious = Self::OBVIOUS.contains(c);
        let is_hard = Self::HARDS.contains(c);
        let is_soft = Self::SOFTS.contains(c);
        let current: String;
        let acc_len = self.accumulator.len();

        match table.get(c) {
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
}
