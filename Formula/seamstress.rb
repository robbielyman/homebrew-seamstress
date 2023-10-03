class Seamstress < Formula
  desc "Lua scripting environment for musical communication"
  homepage "https://github.com/ryleelyman/seamstress"
  url "https://github.com/ryleelyman/seamstress/archive/refs/tags/v0.24.0.tar.gz"
  sha256 "813d0fdb117af0cb6b9c3222f921eb4f397bc329400b63ec17f6f644978deb0c"
  license "GPL-3.0-or-later"

  depends_on "zig" => :build
  depends_on "freetype"
  depends_on "harfbuzz"
  depends_on "ncurses"

  def install
    system "zig", "build", "install", "-Doptimize=ReleaseFast", "--prefix", prefix.to_s
  end

  test do
    system "echo", "_seamstress.quit_lvm\\(\\)", ">>", "#{bin}/_seamstress_test.lua"
    system "#{bin}/seamstress", "#{bin}/_seamstress_test"
  end
end
