class Seamstress < Formula
  desc "Lua scripting environment for musical communication"
  homepage "https://github.com/ryleelyman/seamstress"
  url "https://github.com/ryleelyman/seamstress/archive/refs/tags/v0.24.2.tar.gz"
  sha256 "8042042b66e11f304da887a2a2b036f20e5765cbb61b3ca933623808afc5283b"
  license "GPL-3.0-or-later"

  depends_on "pkg-config" => :build
  depends_on "zig" => :build
  depends_on "freetype"
  depends_on "harfbuzz"
  depends_on "libpng"
  depends_on "ncurses"

  on_linux do
    depends_on "alsa-lib"
    depends_on "dbus"
    depends_on "jack"
    depends_on "libdrm"
    depends_on "libsamplerate"
    depends_on "libxcb"
    depends_on "libxcursor"
    depends_on "libxext"
    depends_on "libxi"
    depends_on "libxkbcommon"
    depends_on "libxrandr"
    depends_on "systemd"
    depends_on "wayland"
  end

  def install
    system "zig", "build", "install", "--verbose", "-Doptimize=ReleaseFast", "--prefix", prefix.to_s
  end

  test do
    test_str = <<~EOF
      SEAMSTRESS
      seamstress version: 0.24.2
      > > seamstress was unable to find user-provided script.lua file!
      > create such a file and place it in either CWD or ~/seamstress
      > SEAMSTRESS: goodbye
    EOF
    require "open3"
    Open3.popen3("#{bin}/seamstress") do |stdin, stdout, _|
      stdin.write("_seamstress.quit_lvm()\n")
      stdin.close
      assert_equal test_str, stdout.read
    end
  end
end
