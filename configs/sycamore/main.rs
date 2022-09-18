use sycamore::prelude::*;
mod count;
mod props;
mod square;

// Create initial empty file:
//     touch tailwind.css
// Add following line to the index.html:
//     <link data-trunk href="./tailwind.css" rel="css" />

#[component]
fn App<G: Html>(cx: Scope) -> View<G> {
    let state = create_signal(cx, 0i32);
    let increment = |_| state.set(*state.get() + 1);
    let decrement = |_| state.set(*state.get() - 1);
    let reset = |_| state.set(0);

    view! { cx,
        article(class="flex flex-col justify-center items-center") {
            header {
                button(on:click=decrement, class="h-12 px-6 m-2 text-lg text-red-100 transition-colors duration-150 bg-red-700 rounded-lg focus:shadow-outline hover:bg-red-800") { "-" }
                button(on:click=reset, class="h-12 px-6 m-2 text-lg text-yellow-100 transition-colors duration-150 bg-yellow-700 rounded-lg focus:shadow-outline hover:bg-yellow-800") { "0" }
                button(on:click=increment, class="h-12 px-6 m-2 text-lg text-green-100 transition-colors duration-150 bg-green-700 rounded-lg focus:shadow-outline hover:bg-green-800") { "+" }
            }
            count::Count(value=state)
            square::Square(value=state)
        }
    }
}

fn main() {
    sycamore::render(|cx| {
        view! { cx,
            App {}
        }
    });
}
