use sycamore::prelude::*;

#[derive(Prop)]
pub struct Base<'a> {
    pub value: &'a ReadSignal<i32>,
}

#[derive(Prop)]
pub struct ButtonProps<'a> {
    pub updater: &'a dyn Fn(i32),
    pub action: i32,
}
