module main

struct Sieve
    limit::Int
    bits::BitVector
    bitslength::Int
    function Sieve(limit) 
        length = div(limit+1, 2)
        new(limit, BitVector(trues(length)), length)
    end
end

function setbits!(s::Sieve, factor::Int)
    prime = 2 * (factor-1) + 1
    start = 2 * (factor-1) * factor + 1
    s.bits[start:prime:s.bitslength] .= false
end


function run(s::Sieve)
    factor = 2
    q = sqrt(s.limit)

    while factor <= q
        factor = findnext(s.bits, factor)
        setbits!(s, factor)
        factor += 1
    end
end


function check_primes(s::Sieve)
    return count(s.bits)
end

function show_primes(s::Sieve)
    return append!([2], [2*(i)+1 for (i, x) in enumerate(s.bits[2:end]) if x])
end

# warmup
limit = parse(Int, ARGS[1])
for i in 0:1
    start = time()
    sieve = Sieve(limit)
    run(sieve)
    timing = time() - start
    primes = check_primes(sieve)
    println("Julia Iter: $i -- Duration: $timing -- Count: $primes")
end

end