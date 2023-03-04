package main

import (
	"bufio"
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
		width, _, _ := term.GetSize(int(os.Stdout.Fd()))
		if len(command.Args()) > 0 {
			msg := strings.Join(command.Args(), " ")
			message := strings.Trim(msg, "\r\n")
			eol := strings.TrimPrefix(msg, message)
			paddingLeft := (width - len(message)) / 2
			paddingRight := paddingLeft
			if (paddingLeft + paddingRight + len(message)) < width {
				paddingRight += 1
			}
			fmt.Printf("%s%s%s%s", strings.Repeat(*delim, paddingLeft), message, strings.Repeat(*delim, paddingRight), eol)
		}
		fi, _ := os.Stdin.Stat()
		if (fi.Mode() & os.ModeCharDevice) == 0 {
			scanner := bufio.NewScanner(os.Stdin)
			for scanner.Scan() {
				msg := scanner.Text()
				message := strings.Trim(msg, "\r\n")
				eol := strings.TrimPrefix(msg, message)
				paddingLeft := (width - len(message)) / 2
				paddingRight := paddingLeft
				if (paddingLeft + paddingRight + len(message)) < width {
					paddingRight += 1
				}
				fmt.Printf("%s%s%s%s", strings.Repeat(*delim, paddingLeft), message, strings.Repeat(*delim, paddingRight), eol)
			}
		}
	}
}

