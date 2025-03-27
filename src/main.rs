#![no_std]
#![no_main]

mod drivers;

use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

#[unsafe(no_mangle)]
pub extern "C" fn _start() -> ! {
    drivers::vga_buffer::print_something();

    loop {}
}