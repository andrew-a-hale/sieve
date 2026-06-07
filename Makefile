SIZE ?= 1_000_000
.SILENT: pysieve gosieve jlsieve rssieve rsieve mlsieve jssieve exsieve javasieve csieve cssieve dbsieve zigsieve

pysieve:
	cd python && python run.py $(SIZE)

gosieve:
	cd go && go build main.go && ./main $(SIZE)

jlsieve:
	julia julia/main.jl $(SIZE)

rssieve:
	cd rust && cargo run -q --release $(SIZE)

rsieve:
	Rscript R/sieve.R $(SIZE)
	Rscript R/rcpp_sieve.R $(SIZE)

mlsieve:
	cd ocaml && eval $$(opam env) && dune exec --release ocaml $(SIZE)

jssieve:
	PARSED=$$(tr -d "_" <<< $(SIZE)); \
	if [ $$PARSED -lt 1000000000 ]; then \
		node js/sieve.js $(SIZE) NodeJS; \
		bun js/sieve.js $(SIZE) Bun; \
	else \
		echo "NodeJS        -- Duration: Skipped -- Too Slow"; \
		echo "Bun           -- Duration: Skipped -- Too Slow"; \
	fi

exsieve:
	PARSED=$$(tr -d "_" <<< $(SIZE)); \
	if [ $$PARSED -lt 1000000 ]; then \
		cd elixir && elixir sieve.exs $(SIZE); \
	else \
		echo "Elixir        -- Duration: Skipped -- Too Slow"; \
	fi

javasieve:
	cd java && javac Sieve.java && java Sieve $(SIZE)

csieve:
	cd c && make > /dev/null && ./main $(SIZE)

cssieve:
	cd csharp && make > /dev/null && ./main/csharp -- $(SIZE)

dbsieve:
	PARSED=$$(tr -d "_" <<< $(SIZE)); \
	if [ $$PARSED -lt 100000000 ]; then \
		cd duckdb && ./go.sh $(SIZE); \
	else \
		echo "DuckdDB       -- Duration: Skipped -- Too Slow"; \
	fi

zigsieve:
	cd zig && zig run -O ReleaseFast main.zig -- $(SIZE)

run: pysieve gosieve jlsieve rssieve rsieve mlsieve jssieve exsieve javasieve csieve cssieve dbsieve zigsieve

