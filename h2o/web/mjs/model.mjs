class Model {
  values = new Map()
  frozen = new Map()
  locked = new Map()
  view

  init(items, view) {
    this.view = view

    items.forEach(k => {
      this.values[k] = ''
      this.frozen[k] = true
      this.locked[k] = false

      Object.defineProperty(this, k, {
        get: () => this.values[k],
        set: (v) => {
          if (v.length > 0 && this.locked[k]) {
            console.log(`Assigning to locked value '${k}'`)
            return
          }
          if (v === this.values[k]) {
            return
          }

          this.values[k] = v
          this.view[k] = v
          if ((v.length > 0) && this.frozen[k]) {
            this.frozen[k] = false
            this.view.unfreeze(k)
          }
        }
      })
    })
  }

  lock(k, v) {
    this.locked[k] = v
    this.view.lock(k, v)
  }
}

export { Model }
