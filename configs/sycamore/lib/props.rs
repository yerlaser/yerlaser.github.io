use sycamore::prelude::*;

#[derive(Prop)]
pub struct Base<'a> {
    pub value: &'a ReadSignal<i32>,
}
