pub struct Converter {
    might_need_prefix: bool,
    accumulator: String,
    current: String,
}

impl Converter {
    const OBVIOUS: &'static str = "ЕГКегк";
    const HARDS: &'static str = "АҒҚОҰҺЫЭағқоұһыэ";
    const SOFTS: &'static str = "ӘЕӨҮІәеөүі";

    pub fn new() -> Converter {
        Self {
            might_need_prefix: true,
            accumulator: String::with_capacity(8),
            current: String::with_capacity(10),
        }
    }

    pub fn convert(&mut self, table: &super::utils::Table, disable_obvious: bool, c: &str) -> String {
        let is_obvious = Self::OBVIOUS.contains(c);
        let is_hard = Self::HARDS.contains(c);
        let is_soft = Self::SOFTS.contains(c);
        let acc_len = self.accumulator.len();

        match table.get(c) {
            Some(c) => {
                if self.might_need_prefix {
                    if is_hard || acc_len > 3 {
                        self.current.push_str(&self.accumulator);
                        self.current.push_str(c);
                        self.might_need_prefix = false;
                        self.accumulator.clear();
                    } else if !disable_obvious && acc_len == 0 && is_obvious {
                        self.current = c.to_owned();
                        self.might_need_prefix = false;
                    } else if is_soft {
                        self.current.push('\'');
                        self.current.push_str(&self.accumulator);
                        self.current.push_str(c);
                        self.might_need_prefix = false;
                        self.accumulator.clear();
                    } else {
                        self.accumulator += c;
                    }
                } else {
                    self.current.clear();
                    self.current = c.to_owned();
                }
            }
            None => {
                self.current.push_str(&self.accumulator);
                self.current.push_str(c);
                self.might_need_prefix = true;
                self.accumulator.clear();
            }
        };

        let result = self.current.clone();
        self.current.clear();
        result
    }
}
