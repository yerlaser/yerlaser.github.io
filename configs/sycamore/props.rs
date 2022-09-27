use sycamore::prelude::*;

#[derive(Prop)]
pub struct ButtonProps<'a> {
    pub updater: &'a dyn Fn(i32),
    pub action: i32,
}
