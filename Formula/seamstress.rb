class Seamstress < Formula
  desc "Lua scripting environment for musical communication"
  homepage "https://github.com/ryleelyman/seamstress"
  url "https://github.com/ryleelyman/seamstress/archive/refs/tags/v1.4.5.tar.gz"
  sha256 "3bebb9cb3543317a556428fd4433b8745fb207b5a192d884b5c45fe4ad5835d9"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/ryleelyman/homebrew-seamstress/releases/download/seamstress-1.4.5"
    sha256 cellar: :any,                 arm64_sonoma: "f578aaa7eaea9f23eec5084a84cb422ef45e3296ace489cf1e8214dec28e2b24"
    sha256 cellar: :any,                 ventura:      "d4817dcc8505f6cfea670a986b08302d374eec0046863e3591c7c903860301e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "49ab21ef633fd3e98fccf2b0af52677b36fcb09ef706d9700efe2f39e4f3327a"
  end

  depends_on "pkg-config" => :build
  depends_on "zig" => :build
  depends_on "asio"
  depends_on "liblo"
  depends_on "lua"
  depends_on "readline"
  depends_on "rtmidi"
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_ttf"

  def install
    system "zig", "build", "install", "--verbose", "-Doptimize=ReleaseFast", "--prefix", prefix.to_s
  end

  test do
    require "open3"
    assert_output (<<~EOF
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
                  ) do
      Open3.popen3("#{bin}/seamstress -h") do |_, stdout, _|
        return stdout
      end
    end
  end
end
