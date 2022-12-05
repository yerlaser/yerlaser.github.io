use utils::readln;
use utils::StringExt;

mod utils;

fn main() {
    let mut name = String::from("");
    readln!("Enter name: ", &mut name);
    println!("Hello, {}!", name.capitalize());
}
