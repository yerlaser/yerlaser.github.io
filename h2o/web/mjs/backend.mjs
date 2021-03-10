import * as status from './status.mjs'

class Backend {
  model
  meta
  values
  metadata
  ip
  url
  ipDebug
  urlDebug
  utils
  isWebview

  init(model, meta, values, metadata, ip, utils, isWebview) {
    this.model = model
    this.meta = meta
    this.values = values
    this.metadata = metadata
    this.utils = utils
    this.ip = ip
    this.url = `http://${this.ip}/j?c=`
    this.ipDebug = 'fuji'
    this.urlDebug = `https://${this.ipDebug}/j?c=`
    this.isWebview = isWebview
  }

  processJson(json) {
    if (json === null) {
      this.meta.blend(true)
      return
    }
    this.meta.blend(false)

    const [key] = Object.keys(json)
    const value = json[key]
    switch (key) {
      case 'N':
        status.processN(value, this.metadata, this.meta)
        break
      case 'Q':
        status.processQ(value, this.metadata, this.meta, this.model, this.values)
        break
      default:
        break
    }
  }

  receiveFromAndroid(response) {
    this.processJson(this.utils.processRaw(response), this.backend)
  }

  send(cmd) {
    if (this.isWebview) {
      AndroidWebViewInterface.fetch(`${this.url}${cmd}`)
    } else {
      fetch(`${this.url}${cmd}`).then((data) => this.processJson(data))
      // const messageChannel = new MessageChannel()
      // messageChannel.port1.onmessage = (event) => this.processJson(this.utils.processRaw(event.data), this)

      // if (navigator.serviceWorker.controller) {
        // navigator.serviceWorker.controller.postMessage(`${this.urlDebug}${cmd}\n`, [messageChannel.port2])
      // }
    }
  }
}

export {Backend}
