class Meta {
  values = new Map()
  model
  view
  blended = false
  utils

  init(items, model, view, utils) {
    this.model = model
    this.view = view
    this.utils = utils

    items.forEach(k => {Object.defineProperty(this, k, {get: () => this.values[k]})})
  }

  setData(k, v) {
    if (v === this.values[k]) {
      return
    }
    this.values[k] = v
    switch (k) {
      case 'sensorCount':
        if (v === 2) {
          this.model.lock(`heaterWater`, false)
          this.model.lock(`coolerRoom`, false)
          this.model.lock(`heaterRoom`, false)
        } else if (v === 1) {
          this.model.lock(`heaterWater`, true)
          this.model[`heaterWater`] = ''
          this.model.lock(`coolerRoom`, false)
          this.model.lock(`heaterRoom`, false)
        } else if (v === 0) {
          this.model.lock(`heaterWater`, true)
          this.model.lock(`coolerRoom`, true)
          this.model.lock(`heaterRoom`, true)
          this.model[`heaterWater`] = ''
          this.model[`coolerRoom`] = ''
          this.model[`heaterRoom`] = ''
        }
        break
      case 'valveCount':
        for (let i = (parseInt(v) + 1); i < (8 + 1); i++) {
          this.model.lock(`valve${i}`, true)
        }
        for (let i = 1; i < (parseInt(v) + 1); i++) {
          this.model.lock(`valve${i}`, false)
        }
        break
      case 'manualMode':
        break
      default:
        break
    }
  }

  blend(hide) {
    if (this.blended === hide) {
      return
    }

    this.blended = hide
    this.view.blend(hide)
  }
}

export { Meta }
