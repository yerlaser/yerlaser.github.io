use super::props::Base;
use sycamore::prelude::*;

#[component]
pub fn Count<'a, G: Html>(cx: Scope<'a>, props: Base<'a>) -> View<G> {
    view! { cx,
        h1 { "Count: " (*props.value.get()) }
    }
}
