import wasmInit, {Converter} from './l2c.js'

const rustWasm = await wasmInit('./l2c_bg.wasm')
const converter = new Converter()

document.getElementById('show_table').addEventListener('click', (ev) => {
  alert(`
// force hardness
"ah": "а", "ih": "ы", "oh": "о", "uh": "ұ"

// force softness
"ia": "ә", "ii": "і", "io": "ө", "iu": "ү"

// special letters
"eh": "э", "eu": "ё", "xh": "щ", "xx": "ъ"

// force vowel/consonant
"yh": "и", "yx": "й"

// common digraphs
"ch": "ч", "hh": "һ", "nh": "ң", "kh": "х", "sh": "ш", "tz": "ц", "ya": "я", "yu": "ю"

// plain letters
"c": "к", "e": "е", "g": "г", "k": "қ", "b": "б", "d": "д", "f": "ф", "j": "ж", "l": "л", "m": "м", "n": "н", "p": "п", "q": "ғ", "r": "р", "s": "с", "t": "т", "v": "в", "w": "у", "x": "ь", "y": "ѝ", "z": "з"
  `)
})

const cpy = document.getElementById('copy')
const clr = document.getElementById('clear')
const ins = document.getElementById('insert')

cpy.addEventListener('click', (ev) => {
  res.select()
  document.execCommand("copy")
  src.focus()
})

clr.addEventListener('click', (ev) => {
  src.value = ''
  src.focus()
})

ins.addEventListener('click', (ev) => {
  src.setRangeText('\t', src.selectionStart, src.selectionEnd, 'end')
  src.focus()
})

const lan = document.getElementById('lang')
const mkp = document.getElementById('markup')

function handleChange() {
  res.value = converter.convert(src.value, lan.value, mkp.value)
  src.focus()
}

lan.addEventListener('change', (ev) => {
  handleChange()
  src.focus()
})

mkp.addEventListener('change', (ev) => {
  handleChange()
  src.focus()
})

const res = document.getElementById('result')
const src = document.getElementById('source')

function debounce(callback, delay) {
  let timeoutId
  return function (...args) {
    clearTimeout(timeoutId)
    timeoutId = setTimeout(() => {
      callback.apply(this, args)
    }, delay)
  }
}

const handleInput = debounce((e) => {
  handleChange()
}, 700)

src.addEventListener('input', (ev) => {
  handleInput()
})
