---
title: "Arduino + Rust + Qemu = ?"
date: 2022-12-27T16:07:55Z
draft: false
---

I love _writing code_ for hardware. I don't like hardware per se (must have
something to do with me missing electrical engineering classes at uni) - but I
find the concept of working at a bare metal level extremely fascinating. So
naturally, I gotta love QEMU. 

For those non-initiated, QEMU is a "A generic and open source machine emulator
and virtualizer" - or, in layman's terms, it's programme that allows you to
emulate just about any physical machine in existence - starting from x86 /
amd64, all the way down to tiny 8-bit microcontrollers. This is excellent 
because that's exactly what I'm going to do here. 

For one of my projects I wanted to write some code in Rust, but I don't have the
actual MCU (microcontroller) at hand at the moment, so I figured it would be
nice to figure out how to piece together several moving pieces. 

In this post I'll explain how to set up Rust toolchain for AVR MCU (such as
Arduino Uno), compile basic Blink example and run it on QEMU, inspecting the output.

I'll be using Debian-based developer machine, but
just about any flavour of modern Linux would work (it _might_ work on a Mac, it
will almost certainly not be easy to do this in Windows).

We start by installing all the dependencies for rust toolchain as well as qemu itself.

```
sudo apt install qemu libudev-dev gcc-avr arduino-core
```

The components here are as follow:

* `qemu` - the virtualisation framework, we'll be using it to run our bare-metal
  code
* `libudev-dev` - a USB library needed to upload code to the actual MCU;
  strictly speaking we won't need it here for qemu-only testing, but might just
  as well get it for when we start uploading code to the microcontroller.
* `gcc-avr` - a version of GCC capable of cross-compiling for AVR MCUs (such as `atmega328p`)
* `arduino-core` - depending on the OS version, `apt` might replace it with full
  `arduino` package, which, in essence, everything you need to develop for
  Arduino - all the libraries, headers as well as not-so-nice IDE.

Once we finished installing all of this, let's get Rust running (feel free to
skip this section if you already had it installed). Run

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

And follow the step-by-step (agreeing with everything feels like a reasonable
choice here). Make sure that you add `~/.cargo/env` to your dotfile (it's
`.zshrc` in my case, or `.bashrc` if you are bash user); or simply run `.
~/.cargo/env` to add it to a current session only.

Now if you run `cargo` you should get some meaningful output. The next step is
installing a wonderful utility called `cargo-generate` - it needs to be said,
that building for AVR is a little more involved than just a straight rust build;
this utility helps you by 'cloning' a template which should ease this process.
Run

```
cargo install cargo-generate
```

And wait for it to complete. Once it's done, change to your code directory and
execute:

```
cargo generate --git https://github.com/Rahix/avr-hal-template.git

[sgzmd@minidev:~/tmp]$ cargo generate --git https://github.com/Rahix/avr-hal-template.git
🤷   Project Name: my-awesome-rust-avr-project
🔧   Destination: /home/sgzmd/tmp/my-awesome-rust-avr-project ...
🔧   project-name: my-awesome-rust-avr-project ...
🔧   Generating template ...
? 🤷   Which board do you use? ›
  Adafruit Trinket
  Adafruit Trinket Pro
  Arduino Leonardo
  Arduino Mega 2560
  Arduino Mega 1280
  Arduino Nano
  Arduino Nano New Bootloader
❯ Arduino Uno
  SparkFun ProMicro
  Nano168
```

It asks you to enter your project name (I used `my-awesome-rust-avr-project`
because duh), and select your MCU (I've used Arduino Uno because frankly for
qemu purposes it makes no difference). Once you've confirmed, it'll reply with
something like:

```
🔧   Moving generated files into: `/home/sgzmd/tmp/my-awesome-rust-avr-project`...
💡   Initializing a fresh Git repository
✨   Done! New project created /home/sgzmd/tmp/my-awesome-rust-avr-project
```

Now would be a really good time to see if our toolchain is functional:

```
cd my-awesome-rust-avr-project
cargo build
```

This might take a while, but if everything goes as planned, you will receive a
message like this:

```
   Compiling my-awesome-rust-avr-project v0.1.0 (/home/sgzmd/tmp/my-awesome-rust-avr-project)
WARN rustc_codegen_ssa::back::link Linker does not support -no-pie command line option. Retrying without.
    Finished dev [optimized + debuginfo] target(s) in 25.96s
```

Let's check what do we have here!

```
[sgzmd@minidev:tmp/my-awesome-rust-avr-project]$ file \
  target/avr-atmega328p/debug/my-awesome-rust-avr-project.elf

target/avr-atmega328p/debug/my-awesome-rust-avr-project.elf: 
  ELF 32-bit LSB executable, Atmel AVR 8-bit, version 1 (SYSV), 
  statically linked, with debug_info, not stripped
```

Yay! - here's our `elf` file (that is, **e**xecutable **l**inux **f**ormat -
even though it won't really run on Linux), ready to be uploaded to the MCU. But
we won't stop here, for we want to see if it runs in QEMU.

Basic way of running our code in QEMU is as follows:

```
qemu-system-avr -machine uno \
  -bios target/avr-atmega328p/debug/my-awesome-rust-avr-project.elf
```

I think QEMU authors are being slightly sneaky here - we are providing our
program as a `-bios` argument to `qemu-system-avr` - even though it's clear
there's no BIOS on an MCU. Note, if you are not running this in an X session (or
just don't want to see an empty QEMU window), pass `-nographic` key to the QEMU.

Either way, if everything works, QEMU will start ... and exactly nothing will
happen. I mean, we aren't really doing anything much - but let's have a look at
the code!

Open `src/main.rs` - let's see what have we got here. I've added comments to the
code to make it slightly more comprehensible.

```rust

// We are instructing Rust that we are not linking against std crate. 
// It's a little bit like stdlib in C - a set of standard routines, that
// provide some useful functionality, but assume a sane environment - 
// which means an operating system. We have none, hence `no_std`.
#![no_std] 

// Instruction not to expect regular Rust `main` function. More below
#![no_main]

// Configuring panic handler, but also instructing Rust that we won't
// really be using anything explicitly from that crate.
use panic_halt as _;


// Now this is our entry point, as instructed by arduino_hal::entry
#[arduino_hal::entry]
// Instructing Rust that this function will never return
fn main() -> ! {
    let dp = arduino_hal::Peripherals::take().unwrap();
    let pins = arduino_hal::pins!(dp);

    let mut led = pins.d13.into_output();

    loop {
        led.toggle();
        arduino_hal::delay_ms(1000);
    }
}
```

The rest of the code is pretty straightforward and if you've ever tried anything
with Arduino, you should recognise the infamous Blink programme straight away.

So, we can compile it, and we can launch it, but we really have no idea if it's
doing anything. Let's add some debug output to see if it's running. Let's modify
the code a bit:

```rust
#[arduino_hal::entry]
fn main() -> ! {
    let dp = arduino_hal::Peripherals::take().unwrap();
    let pins = arduino_hal::pins!(dp);

    // Configuring serial output, a bit like Serial.begin(57600) 
    // when you are writing in the Arduino flavour of C++
    let mut serial = arduino_hal::default_serial!(dp, pins, 57600);
    let mut led = pins.d13.into_output();

    loop {
        led.toggle();
        arduino_hal::delay_ms(1000);
        
        // Writing "Blink!" to the serial output
        _ = ufmt::uwriteln!(serial, "Blink!");
    }
}

```

To see this output, we'll have to launch QEMU slightly differently:

```shell
 qemu-system-avr -M uno -bios target/avr-atmega328p/debug/my-awesome-rust-avr-project.elf \
        -nographic \
        -serial tcp::5678,server=on
```

Here we are instructing QEMU to proxy serial on port 5678. After launching the
server, we can connect to this port:

```shell
[sgzmd@minidev:~/tmp]$ telnet localhost 5678
Trying ::1...
Connected to localhost.
Escape character is '^]'.
Blink!
Blink!
Blink!
Blink!
Blink!
Blink!
...
```
We see exactly what we expect to see - text "Blink!" appearing on the screen - Q.E.D.