class View {
  labels = new Map()
  values = new Map()
  utils

  init(labels, values, utils) {
    this.utils = utils

    labels.forEach(k => {
      this.labels[k] = document.querySelector(`#${k} > article`)
    })

    values.forEach(k => {
      this.values[k] = document.querySelector(`#${k} > aside`)

      if (this.values[k].classList.contains('zzspinner')) {
        this.values[k].classList.add('neverrun')
      }

      Object.defineProperty(this, k, {
        set: (v) => {
          this.values[k].textContent = v
        }
      })
    })
  }

  lock(k, v) {
    if (v) {
      this.values[k].classList.add('unavailable')
    } else {
      this.values[k].classList.remove('unavailable')
    }
  }

  unfreeze = (k) => this.values[k].classList.remove('neverrun')

  blend(hide) {
    document.querySelector('body > main').style.filter = (hide ? 'opacity(28%)' : 'opacity(100%)')
  }
}

export {View}
