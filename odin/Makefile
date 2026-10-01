default:
	odin build . -o:aggressive -out:main -microarch:native

test:
	odin build -o:none . && ./odin 100 && rm odin

