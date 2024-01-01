library(Rcpp)
sourceCpp("R/sieve.cpp")

args <- commandArgs(trailingOnly = TRUE)
limit <- as.numeric(args[1])
start <- Sys.time()
s <- limit |> sieve()
time <- Sys.time() - start
cat(
  paste0(
    "Rcpp          -- Duration: ",
    as.numeric(time),
    " -- Count: ",
    check_primes(s),
    "\n"
  )
)
