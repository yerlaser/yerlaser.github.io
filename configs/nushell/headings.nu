# Print string at the center filling with specified character
def print_title (
  --character (-c): string # Fill character
  text: string # String to print
) {
  let title_text = ($text | str join ' ')
  let width = (term size).columns
  if ($title_text | str length) > $width {
    print -e 'Text too long'
  } else {
    $title_text | str upcase | fill -a c -c $character -w $width
  }
}

# Print string(s) at the center with equal sign fill
export def h1 (
  ...text # Text to print (in additition to piped input if any)
) {
  let inp = $in
  let inp = if ($text | is-empty) {$inp} else {$inp | append [$text]}
  for l in $inp {print_title -c '=' $l}
}

# Print string(s) at the center with dash sign fill
export def h2 (
  ...text # Text to print (in additition to piped input if any)
) {
  let inp = $in
  let inp = if ($text | is-empty) {$inp} else {$inp | append [$text]}
  for l in $inp {print_title -c '-' $l}
}
