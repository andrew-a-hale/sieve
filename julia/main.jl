module main

struct Sieve
    bits::BitVector
    bitslength::Int

    function Sieve(limit) 
        length = div(limit+1, 2)
        new(BitVector(trues(length)), length)
    end
end

function run(s::Sieve)
    factor = 2
    q = sqrt(div(s.bitslength, 2)) + 1

    while factor < q
        factor = findnext(s.bits, factor)
        start = 2 * (factor-1) * factor + 1
        step = 2 * (factor-1) + 1
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