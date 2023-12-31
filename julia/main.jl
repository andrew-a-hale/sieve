module main

struct Sieve
    size::Int
    bits::BitVector
    bitslength::Int

    function Sieve(limit) 
        length = div(limit+1, 2)
        new(limit, BitVector(trues(length)), length)
    end
end

function run(s::Sieve)
    factor = 2
    q = sqrt(s.size)

    while factor <= q
        factor = findnext(s.bits, factor)
        step = 2 * (factor-1) + 1
        start = 2 * (factor-1) * factor + 1
        s.bits[start:step:s.bitslength] .= false
        factor += 1
    end
end


function check_primes(s::Sieve)
    return count(s.bits)
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