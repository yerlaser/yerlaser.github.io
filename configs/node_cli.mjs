import fs from 'fs/promises'

function processContent(original) {
  let processed = ``

  for (const line of original.split(`\n`)) {
    processed += `${line.toUpperCase()}\n`
  }

  return processed
}

async function processFile(inputFileName, outputFileName) {
  try {
    const originalContent = await readFile(inputFileName, `utf8`)

    const offd = await open(outputFileName, `w`)
    await write(offd, processContent(originalContent))
    await close(offd)

    console.log(`Done.`)
  } catch (err) {
    console.log(`Error`, err)
  }
}

function main(argv) {
  if (argv.length < 2) {
    console.log(`Error: supply input and output file names`)
    return
  }

  processFile(...argv)
}

main(process.argv.slice(2))
