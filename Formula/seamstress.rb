class Seamstress < Formula
  desc "Lua scripting environment for musical communication"
  homepage "https://github.com/ryleelyman/seamstress"
  url "https://github.com/ryleelyman/seamstress/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "f1b8a47cfa4200ffb4a5458c1dfb5f48f37dcce95d6e2dde6094ff43e71b3ab7"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/ryleelyman/homebrew-seamstress/releases/download/seamstress-1.0.0"
    sha256 cellar: :any, ventura: "0d1d2c6b0768d1f3044563b036c03b06d5b0f554b8b9b6bcf4a136d5900387bf"
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
      > > seamstress was unable to find user-provided script.lua file!
      > create such a file and place it in either CWD or ~/seamstress
    EOF
    require "open3"
    Open3.popen3("#{bin}/seamstress -q") do |stdin, stdout, _|
      stdin.write("_seamstress.quit_lvm()\n")
      stdin.close
      assert_equal (test_str + "> "), stdout.read
    end
  end
end
