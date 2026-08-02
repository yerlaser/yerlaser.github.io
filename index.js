import wasmInit, {Converter} from './l2c.js'
const rustWasm = await wasmInit('./l2c_bg.wasm')
const converter = new Converter()

const btn = document.getElementById('copy_or_more')
const lan = document.getElementById('lang')
const mkp = document.getElementById('markup')
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

function handleChange() {
  res.value = converter.convert(src.value, lan.value, mkp.value)
}

function handleKey(action = 'return') {
  if (action === 'clip') {
    res.select()
    document.execCommand("copy")
  }

  if (action === 'clear') {
    src.value = ''
    src.dispatchEvent(new InputEvent('change', {bubbles: true}))
  } else if (action === 'insert') {
    src.setRangeText('\t', src.selectionStart, src.selectionEnd, 'end')
  }

  src.focus()
}

src.addEventListener('input', (ev) => {
  handleInput()
})

lan.addEventListener('change', (ev) => {
  handleChange()
})

mkp.addEventListener('change', (ev) => {
  handleChange()
})

btn.addEventListener('click', (ev) => {
  handleKey('clip')
})

btn.addEventListener('keydown', (ev) => {
  ev.preventDefault()
  if (ev.key === 'Backspace') {
    handleKey('clear')
  } else if (ev.key === 'Tab') {
    handleKey()
  } else if (ev.key === 'Enter') {
    handleKey('clip')
  } else if (ev.key === ' ') {
    handleKey('insert')
  }
})
