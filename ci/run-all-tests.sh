#!/bin/bash

set -euo pipefail

cd ..

cargo test --all
cargo run -p hello-world-host
cargo run --target=i686-unknown-linux-musl -p hello-world-host

cd crates/polkavm-zygote
cargo build --release
RUSTFLAGS='-D warnings' cargo clippy --all
cargo fmt --check --all
cd ../..

cd examples/guests
cargo build
RUSTFLAGS='-D warnings' cargo clippy --all
cargo fmt --check --all
cd ../..

RUSTFLAGS='-D warnings' cargo clippy --all
cargo fmt --check --all

echo "----------------------------------------"
echo "All tests finished!"
