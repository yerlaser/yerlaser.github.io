use super::props::Base;
use sycamore::prelude::*;

#[component]
pub fn Square<'a, G: Html>(cx: Scope<'a>, props: Base<'a>) -> View<G> {
    let negative = create_selector(cx, || *props.value.get() < 0);

    view! { cx,
        h1 { "Square: " ((*props.value.get()) * (*props.value.get())) }
        (if *negative.get() {
            view! { cx,
                h3(style="color:red") { "Warning: base is negative" }
            }
        } else {
            view! { cx, }
        })
    }
}
