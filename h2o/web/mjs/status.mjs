function processN(value, metadata, meta) {
  metadata.forEach((k, i) => {
    if (i < 7) {
      meta.setData(k, value[i])
    } else {
      meta.setData(k, parseInt(value[i]))
    }
  })
}

function processQ(value, metadata, meta, model, values) {
  const valueArray = value.split('_')

  let t1 = parseInt(valueArray[0])
  let t2 = t1 % 3600
  t1 = Math.floor(t1 / 3600)
  const h = `${t1 < 10 ? '0' : ''}${t1}`

  t1 = t2
  t2 = t1 % 60
  t1 = Math.floor(t1 / 60)
  const m = `${t1 < 10 ? '0' : ''}${t1}`
  const s = `${t2 < 10 ? '0' : ''}${t2}`
  model.time = `${h}:${m}:${s}`

  t1 = parseInt(valueArray[5])
  if (t1 > 0) {
    t2 = t1
    meta.setData('sensorCount', Math.floor(t2 / 100000))
    t2 %= 100000
    meta.setData('valveCount', Math.floor(t2 / 10000))
    t2 %= 10000
    meta.setData('valveMaxCount', Math.floor(t2 / 1000))
    t2 %= 1000
    for (let i = 7; i > 0; i--) {
      meta.setData(metadata[i - 1], Math.floor(t2 / Math.pow(2, i - 1)))
      t2 %= Math.pow(2, i - 1)
    }
  }

  let bitMask = `${parseInt(valueArray[1]).toString(2).split('').reverse().join('')}0000000`.slice(0, 8)
  bitMask += `${parseInt(valueArray[2]).toString(2).split('').reverse().join('')}0000000`.slice(0, 8)

  if (meta.activeLow === '1') {
    bitMask = bitMask.split('').map((x) => (x === '0' ? '1' : '0')).join('')
  }

  values.forEach((k, i) => {
    if (i < bitMask.length) {
      model[k] = (bitMask[i] === '1') ? ' ' : ''
    }
  })

  t1 = parseInt(valueArray[4])
  if (isNaN(t1) || t1 < 1) {
    model.temperatureRoom = '-'
  } else {
    model.temperatureRoom = t1.toString()
  }

  t1 = parseInt(valueArray[6])
  if (isNaN(t1) || t1 < 1) {
    model.temperatureWater = '-'
  } else {
    model.temperatureWater = t1.toString()
  }
}

export {processN, processQ}
