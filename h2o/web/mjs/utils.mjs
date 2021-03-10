class Utils {
  log
  isWebview

  setup(log, isWebview) {
    this.log = log
    this.isWebview = isWebview
  }

  log(msg) {
    if (this.log) {
      if (this.isWebview) {
        console.log(`Attempting to toast ${msg}`)
        AndroidWebViewInterface.toast(msg)
      } else {
        console.log(msg)
      }
    }
  }

  processRaw(str) {
    if ((str === null) || (str.length < 1)) {
      return null
    }

    let json
    if ((/(?:[{])([A-Z0-9_]+)(?:[:]['])([A-Za-z0-9_ ,-]+)(?:['][}])/).test(str)) {
      json = str.replace(/(?:.*[{])([A-Z0-9_]+)(?:[:]['])([A-Za-z0-9_ ,-]+)(?:['][}].*)/, '{"$1":"$2"}')
    } else {
      return null
    }

    try {
      json = JSON.parse(json)
    } catch (e) {
      return null
    }

    return json
  }
}

export {Utils}
