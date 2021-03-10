function processContent(original) {
  let processed = ``

  for (const line of original.split(`\n`)) {
    processed += `${line.toUpperCase()}\n`
  }

  return processed
}

async function main(inputFileName) {
  try {
    const originalContent = await read(inputFileName)
    print(processContent(originalContent))
  } catch (err) {
    print(`Could not read file: ${inputFileName}, error: `, err)
  }
}

main('aaBBcc.txt')
