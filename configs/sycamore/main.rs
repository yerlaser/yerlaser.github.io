use button::Button;
use count::Count;
use square::Square;
use sycamore::prelude::*;

mod button;
mod count;
mod props;
mod square;

fn main() {
    sycamore::render(|cx| {
        let state = create_signal(cx, 0i32);
        let update = |action| {
            if action == 0 {
                state.set(0);
            } else {
                state.set(*state.get() + action);
            }
        };
        let update = create_ref(cx, update);
        view! { cx,
            article(class="flex flex-col justify-center items-center") {
                header() {
                    Button(updater=update, action=-1)
                    Button(updater=update, action=0)
                    Button(updater=update, action=1)
                }
                Count(value=state)
                Square(value=state)
            }
        }
    });
}
