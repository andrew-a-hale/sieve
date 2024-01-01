sieve <- function(limit) {
  bitslength <- (limit + 1) %/% 2
  structure(
    rep(TRUE, bitslength),
    bitslength = bitslength
  )
}

run <- function(s) {
  factor <- 2
  bitslength <- attr(s, "bitslength")
  q <- sqrt(bitslength %/% 2) + 1

  while (factor < q) {
    # find next bit
    for (i in seq.int(factor, bitslength - 1)) {
      if (s[i]) {
        factor <- i
        break
      }
    }

    # mark numbers
    start <- 2 * (factor - 1) * factor + 1
    step <- 2 * (factor - 1) + 1
    if (start > bitslength) {
      break
    }
    s[seq.int(start, bitslength, step)] <- FALSE
    factor <- factor + 1
  }

  s
}

check_primes <- function(s) {
  sum(s, na.rm = TRUE)
}

args <- commandArgs(trailingOnly = TRUE)
limit <- as.numeric(args[1])
start <- Sys.time()
s <- limit |> sieve() |> run()
time <- Sys.time() - start
cat(
  paste0(
    "R             -- Duration: ",
    as.numeric(time),
    " -- Count: ",
    check_primes(s),
    "\n"
  )
)
