package main

import (
	"flag"
	"fmt"
	"golang.org/x/term"
	"os"
	"strings"
)

func main() {
	command := flag.NewFlagSet("align", flag.ExitOnError)
	side := command.String("side", "", "Side (edge) of alignment (left, center, right)")
	delim := command.String("delim", "", "Delimiter to fill padding")
	switch os.Args[1] {
	case "align":
		command.Parse(os.Args[2:])
		switch *side {
		case "center":
			msg := strings.Join(command.Args(), " ")
			message := strings.Trim(msg, "\r\n")
			eol := strings.TrimPrefix(msg, message)
			width, _, _ := term.GetSize(0)
			paddingLeft := (width - len(message)) / 2
			paddingRight := paddingLeft
			if (paddingLeft + paddingRight + len(message)) < width {
				paddingRight += 1
			}
			fmt.Printf("%s%s%s%s", strings.Repeat(*delim, paddingLeft), message, strings.Repeat(*delim, paddingRight), eol)
		}
	}
}
