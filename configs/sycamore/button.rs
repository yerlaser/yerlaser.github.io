use super::props::ButtonProps;
use sycamore::prelude::*;

#[component]
pub fn Button<'a, G: Html>(cx: Scope<'a>, props: ButtonProps<'a>) -> View<G> {
    let label = match props.action {
        -1 => "-",
        0 => "0",
        _ => "+",
    };
    let cls = match props.action {
        -1 => "h-12 px-6 m-2 text-lg text-red-100 transition-colors duration-150 bg-red-700 rounded-lg focus:shadow-outline hover:bg-red-800",
        0 => "h-12 px-6 m-2 text-lg text-yellow-100 transition-colors duration-150 bg-yellow-700 rounded-lg focus:shadow-outline hover:bg-yellow-800",
        _ => "h-12 px-6 m-2 text-lg text-green-100 transition-colors duration-150 bg-green-700 rounded-lg focus:shadow-outline hover:bg-green-800",
    };
    view! { cx,
        button(on:click=move |_| (*props.updater)(props.action), class=cls) { (label) }
    }
}
