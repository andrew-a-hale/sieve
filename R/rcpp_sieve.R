library(Rcpp)
sourceCpp("R/sieve.cpp")

args <- commandArgs(trailingOnly = TRUE)
limit <- as.numeric(gsub("_", "", args[1]))
start <- Sys.time()
count <- limit |> sieve()
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
