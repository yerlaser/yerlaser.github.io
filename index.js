import wasmInit, {Converter} from './l2c.js'
const rustWasm = await wasmInit('./l2c_bg.wasm')
const converter = new Converter()

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
}, 300)

src.addEventListener('input', (ev) => {
  handleInput()
})
