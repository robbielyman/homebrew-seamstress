class Seamstress < Formula
  desc "Lua scripting environment for musical communication"
  homepage "https://github.com/ryleelyman/seamstress"
  url "https://github.com/ryleelyman/seamstress/archive/refs/tags/v1.4.2.tar.gz"
  sha256 "e826a55f96aeea1b230f58388eb06293f9e1c6191e4594a04a3fc020ba5f21d3"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/ryleelyman/homebrew-seamstress/releases/download/seamstress-1.4.2"
    sha256 cellar: :any, ventura: "70974051a21daf856e2860f4ef79c6b669754a963afd3695ff185660717ecd17"
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
    Open3.popen3("#{bin}/seamstress -h") do |_, stdout, _|
      assert_equal stdout, <<~EOF
        USAGE: seamstress [script] [args]

        [script] (optional) should be the name of a lua file in CWD or ~/seamstress
        [args]   (optional) should be one or more of the following
        -s       override user script [current script]
        -e       list or load example scripts
        -l       override OSC listen port [current 7777]
        -b       override OSC broadcast port [current 6666]
        -p       override socket listen port [current 8888]
        -q       don't print welcome and version number
        -w       watch the directory containing the script file for changes
        -x       override window width [current 256]
        -y       override window height [current 128]
      EOF
    end
  end
end
