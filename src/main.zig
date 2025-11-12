const std = @import("std");

// Adding some comments
// mooore.
// Need more comments!
// and another one
pub fn main() !void {
    // Prints to stderr, ignoring potential errors.
    print("hello");
    print("hello again");
}

/// A function to print
/// This is a new comment
pub fn print(comptime text: []const u8) void {
    std.debug.print(text, .{});
}

pub fn print2(comptime text: []const u8) void {
    std.debug.print(text, .{});
}

test "simple test" {
    const gpa = std.testing.allocator;
    var list: std.ArrayList(i32) = .empty;
    defer list.deinit(gpa); // Try commenting this out and see if zig detects the memory leak!
    try list.append(gpa, 42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "fuzz example" {
    const Context = struct {
        fn testOne(context: @This(), input: []const u8) anyerror!void {
            _ = context;
            // Try passing `--fuzz` to `zig build test` and see if it manages to fail this test case!
            try std.testing.expect(!std.mem.eql(u8, "canyoufindme", input));
        }
    };
    try std.testing.fuzz(Context{}, Context.testOne, .{});
}
