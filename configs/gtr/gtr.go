package main

import (
	"flag"
	"fmt"
	"golang.org/x/term"
	"os"
	"strings"
)

func main() {
	command := flag.NewFlagSet("center", flag.ExitOnError)
	delim := command.String("delim", "", "Delimiter to fill padding")
	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "Error: command required")
		os.Exit(1)
	}
	switch os.Args[1] {
	case "center":
		command.Parse(os.Args[2:])
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
