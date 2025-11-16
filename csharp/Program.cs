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
    bits = new BitArray(size, false);
  }

  void Run()
  {
    int q = (int)Math.Sqrt(size / 2) + 1;
    int start, step;
    int factor = 1;

    for (; factor < q;)
    {
      for (int i = factor; i < size; i++)
      {
        if (!bits[i])
        {
          factor = i;
          break;
        }
      }

      start = 2 * factor * (factor + 1);
      step = (2 * factor) + 1;
      for (int i = start; i < size; i += step)
      {
        bits[i] = true;
      }

      factor++;
    }
  }

  int Check()
  {
    return bits.Cast<bool>().Count(x => !x);
  }

  static void Main(string[] args)
  {
    if (args.Length == 1)
    {
      throw new Exception("missing argument");
    }

    bool ok = int.TryParse(args[1], out int limit);
    if (!ok)
    {
      throw new Exception("failed to parse argument");
    }

    Sieve sieve = new(limit);
    Stopwatch watch = new();
    watch.Start();
    sieve.Run();
    watch.Stop();
    int count = sieve.Check();

    Console.WriteLine("C#            -- Duration: {0}ms -- Count: {1}", watch.ElapsedMilliseconds, count.ToString());
  }
}
