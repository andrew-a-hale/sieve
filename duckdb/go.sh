start=$(date +%s%N)
count=$(duckdb -csv -noheader -s "$(sed "s/N/$1/" sieve.sql)")
end=$(date +%s%N)
printf "DuckDB        -- Duration: $((($end-$start)/1000000))ms -- Count: $count"
