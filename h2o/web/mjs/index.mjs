import {Backend} from './backend.mjs'
import {Meta} from './meta.mjs'
import {Model} from './model.mjs'
import {Utils} from './utils.mjs'
import {View} from './view.mjs'
import './controller.mjs'

const values = ['heaterRoom', 'coolerRoom', 'heaterWater', 'coolerWater', 'light', 'ventilator', 'ozonator', 'pump',
  'valve1', 'valve2', 'valve3', 'valve4', 'valve5', 'valve6', 'valve7', 'valve8',
  'temperatureRoom', 'temperatureWater', 'time']
const metadata = ['manualMode', 'dataInitComplete', 'readError', 'rtcError',
  'dhtError', 'dallasError', 'activeLow', 'valveMaxCount', 'valveCount', 'sensorCount']

const utils = new Utils()
const view = new View()
const model = new Model()
const meta = new Meta()
const backend = new Backend()
const isWebview = ('AndroidWebViewInterface' in window)

window.h2oBackend = backend
utils.setup(true, isWebview)
view.init(values, values, utils)
model.init(values, view)
meta.init(metadata, model, view, utils)

// backend.init(model, meta, values, metadata, '192.168.4.1', utils, isWebview)
backend.init(model, meta, values, metadata, '0.0.0.0:8003', utils, isWebview)

setInterval(() => backend.send('RMQ'), 7 * 1000)
backend.send('RMN')
