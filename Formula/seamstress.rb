class Seamstress < Formula
  desc "Lua scripting environment for musical communication"
  homepage "https://github.com/ryleelyman/seamstress"
  url "https://github.com/ryleelyman/seamstress/archive/refs/tags/v1.2.6.tar.gz"
  sha256 "b1db1bacde45db23434cea912cdf41ef9ff42b469b97e238df195742ad1ecbe1"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/ryleelyman/homebrew-seamstress/releases/download/seamstress-1.2.6"
    sha256 cellar: :any, ventura: "955964064a970fa7bbd7a8212a936d53f1f01f0e3f65156d22d6e1158beb0e69"
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
    require "open3"
    Open3.popen3("#{bin}/seamstress -q") do |stdin, stdout, _|
      stdin.write("_seamstress.quit_lvm()\n")
      stdin.close
      assert_equal "> > ", stdout.read
    end
  end
end
