class Seamstress < Formula
  desc "Lua scripting environment for musical communication"
  homepage "https://github.com/ryleelyman/seamstress"
  url "https://github.com/ryleelyman/seamstress/archive/refs/tags/v0.24.1.tar.gz"
  sha256 "5f5d435c2b9d4278d11bd45b34b7468d81ec2f6ac275a92d1210e0b24f77f0b4"
  license "GPL-3.0-or-later"

  depends_on "pkg-config" => :build
  depends_on "zig" => :build
  depends_on "freetype"
  depends_on "harfbuzz"
  depends_on "ncurses"

  def install
    system "zig", "build", "install", "--verbose", "-Doptimize=ReleaseFast", "--prefix", prefix.to_s
  end

  test do
    system "echo", "_seamstress.quit_lvm\\(\\)", ">>", "#{bin}/_seamstress_test.lua"
    system "#{bin}/seamstress", "#{bin}/_seamstress_test"
  end
end
