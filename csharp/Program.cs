using System.Collections;
using System.Diagnostics;

namespace csharp;

class Sieve
{
    public BitArray bits;
    public int size;

    public Sieve(int limit)
    {
        size = (limit + 1) / 2;
        bits = new BitArray(size, true);
    }

    void Run()
    {
        int q = (int)Math.Sqrt(size / 2) + 1;
        int start;
        int step;
        int factor = 1;

        for (; factor < q; )
        {
            for (int i = factor; i < size; i++)
                if (bits[i])
                {
                    factor = i;
                    break;
                }

            start = 2 * factor * (factor + 1);
            step = (2 * factor) + 1;
            for (int i = start; i < size; i += step)
                bits[i] = false;

            factor++;
        }
    }

    long Check()
    {
        long count = 0;
        for (int i = 0; i < size; i++)
            if (bits[i].Equals(true))
                count++;

        return count;
    }

    static void Main(string[] args)
    {
        if (args.Length == 1)
            throw new Exception("missing argument");

        bool ok = int.TryParse(args[1], out int limit);
        if (!ok)
            throw new Exception("failed to parse argument");

        Stopwatch watch = new();
        watch.Start();
        Sieve sieve = new(limit);
        sieve.Run();
        long count = sieve.Check();
        watch.Stop();

        Console.WriteLine(
            "C#            -- Duration: {0}ms -- Count: {1}",
            watch.ElapsedMilliseconds,
            count.ToString()
        );
    }
}
