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

pub fn main() !void {
    if (std.os.argv.len < 2) {
        @panic("missing input expect an int");
    }

    const arg: []const u8 = std.mem.span(std.os.argv[1]);
    const n: usize = try std.fmt.parseInt(usize, arg, 10);

    var timer = try std.time.Timer.start();
    const start: u64 = timer.lap();

    var gpa = std.heap.GeneralPurposeAllocator(.{}).init;
    const allocator = gpa.allocator();
    errdefer _ = gpa.deinit();

    const bits = try sieve(allocator, n);

    std.debug.print(
        "Zig           -- Duration: {}ms -- Count: {}",
        .{ (timer.lap() - start) / std.time.ns_per_ms, bits.count() },
    );
}
