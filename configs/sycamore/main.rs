use lib::Count::Count;
use lib::Square::Square;
use sycamore::prelude::*;

mod lib;

#[component]
fn App<G: Html>(cx: Scope) -> View<G> {
    let state = create_signal(cx, 0i32);
    let increment = |_| state.set(*state.get() + 1);
    let decrement = |_| state.set(*state.get() - 1);
    let reset = |_| state.set(0);

    view! { cx,
        button(on:click=increment) { "+" }
        button(on:click=decrement) { "-" }
        button(on:click=reset) { "Reset" }
        Count(value=state)
        Square(value=state)
    }
}

fn main() {
    sycamore::render(|cx| {
        view! { cx,
            App {}
        }
    });
}
