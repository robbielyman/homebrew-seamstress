class Seamstress < Formula
  desc "Lua scripting environment for musical communication"
  homepage "https://github.com/ryleelyman/seamstress"
  url "https://github.com/ryleelyman/seamstress/archive/refs/tags/v0.24.4.tar.gz"
  sha256 "a008660de51b58ca3cc7b373dcd84667cda9f2ddb926596f4b4f27a1ae0694b1"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/ryleelyman/homebrew-seamstress/releases/download/seamstress-0.24.4"
    sha256 cellar: :any, ventura: "31b9125e023f2552b7e8993d31b9564e5a1b71e99ae1674ced22fa2fa063ce92"
  end

  depends_on "pkg-config" => :build
  depends_on "zig" => :build
  depends_on "freetype"
  depends_on "harfbuzz"
  depends_on "libpng"
  depends_on :macos
  depends_on "ncurses"

  on_linux do
    depends_on "alsa-lib"
    depends_on "dbus"
    depends_on "jack"
    depends_on "libdrm"
    depends_on "libice"
    depends_on "libsamplerate"
    depends_on "libxcb"
    depends_on "libxcursor"
    depends_on "libxext"
    depends_on "libxi"
    depends_on "libxkbcommon"
    depends_on "libxrandr"
    depends_on "libxscrnsaver"
    depends_on "libxxf86vm"
    depends_on "systemd"
    depends_on "wayland"
    depends_on "wayland-protocols"
    depends_on "xinput"
  end

  def install
    system "zig", "build", "install", "--verbose", "-Doptimize=ReleaseFast", "--prefix", prefix.to_s
  end

  test do
    test_str = <<~EOF
      SEAMSTRESS
      seamstress version: 0.24.4
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
