macro_rules! readln{
    ($message: expr, $receiver: expr) => {
        {
            use std::io::{stdin, stdout, Write};

            print!("{}", $message);
            stdout().flush().expect("Error reading from stdio");
            stdin().read_line($receiver).expect("Error flushing stdio");
            *$receiver = $receiver.trim_end().to_string();
        }
    };
    ($message: expr, $receiver: expr, $trim_eol: expr) => {
        {
            use std::io::{stdin, stdout, Write};

            print!("{}", $message);
            stdout().flush().expect("Error reading from stdio");
            stdin().read_line($receiver).expect("Error flushing stdio");
            if $trim_eol {
                *$receiver = $receiver.trim_end().to_string();
            }
        }
    };
}

trait StringExt {
    fn capitalize(&self) -> String;
}

impl StringExt for String {
    fn capitalize(&self) -> String {
        let mut c = self.chars();
        match c.next() {
            None => String::new(),
            Some(f) => f.to_uppercase().collect::<String>() + c.as_str(),
        }
    }
}

impl StringExt for &str {
    fn capitalize(&self) -> String {
        let mut c = self.chars();
        match c.next() {
            None => String::new(),
            Some(f) => f.to_uppercase().collect::<String>() + c.as_str(),
        }
    }
}

fn main() {
    let mut name = String::new();
    readln!("Enter your name: ", &mut name);
    println!("{} {}!", "hello".capitalize(), name.capitalize());
}
