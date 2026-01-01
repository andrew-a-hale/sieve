library(Rcpp)
sourceCpp("R/sieve.cpp")

args <- commandArgs(trailingOnly = TRUE)
limit <- as.numeric(args[1])
start <- Sys.time()
s <- limit |> sieve()
count <- check_primes(s)
duration <- floor(as.numeric(Sys.time() - start) * 1000)

cat(
  paste0(
    "Rcpp          -- Duration: ",
    duration,
    "ms -- Count: ",
    count,
    "\n"
  )
)
