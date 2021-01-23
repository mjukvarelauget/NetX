compile: src/Main.elm
	elm make src/Main.elm --output=main.js

.PHONY: install
install:
	elm install elm/random
