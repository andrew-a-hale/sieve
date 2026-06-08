const std = @import("std");

pub fn sieve(allocator: std.mem.Allocator, n: usize) !std.bit_set.DynamicBitSet {
    // setup sieve
    const bits_length = (n + 1) / 2;
    var bits = try std.bit_set.DynamicBitSet.initEmpty(allocator, bits_length);

    // setup sieve algo
    const q = std.math.sqrt(bits_length / 2) + 1;
    var factor: u64 = 1;
    var start: u64 = 0;
    var step: u64 = 0;

    // algo
    while (factor < q) {
        for (factor..bits_length) |i| {
            if (!bits.isSet(i)) {
                factor = i;
                break;
            }
        }

        start = 2 * factor * (factor + 1);
        step = 2 * factor + 1;
        while (start < bits_length) : (start += step) {
            bits.set(start);
        }

        factor += 1;
    }

    // switch marks from composites to primes for bits.count
    bits.toggleAll();
    return bits;
}

pub fn main(init: std.process.Init) !void {
    const args = try init.minimal.args.toSlice(init.arena.allocator());

    if (args.len < 2) {
        @panic("missing input expect an sieve limit");
    }

    const arg: []const u8 = std.mem.span(args[1].ptr);
    var buf = try init.arena.allocator().alloc(u8, arg.len);
    const replacements: usize = std.mem.replace(u8, arg, "_", "", buf);
    buf = buf[0..(arg.len - replacements)];
    const n: usize = try std.fmt.parseInt(usize, buf, 10);

    const start = std.Io.Clock.real.now(init.io).toMilliseconds();
    const spm = std.heap.smp_allocator;
    const bits = try sieve(spm, n);
    const count = bits.count();
    std.debug.print(
        "Zig           -- Duration: {}ms -- Count: {}\n",
        .{ (std.Io.Clock.real.now(init.io).toMilliseconds() - start), count },
    );
}
