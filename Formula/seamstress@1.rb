class SeamstressAT1 < Formula
  desc "Art engine"
  homepage "https://github.com/robbielyman/seamstress-v1"
  url "https://github.com/robbielyman/seamstress-v1/archive/refs/tags/v1.4.6.tar.gz"
  sha256 "3b1b80560fe3dfdfb1f790c8f8fcdeaeb852166f961995d71c8c01af5d1b8915"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/robbielyman/homebrew-seamstress/releases/download/seamstress@1-1.4.6"
    sha256 cellar: :any, arm64_sonoma: "0b1a2d299a54f0d05ab9b255e8ecc43f9888234de48e1e0f3a3d515b73d6991b"
  end

  keg_only "seamstress@1 is not linked by default because it would conflict with seamstress@2"

  depends_on "pkg-config" => :build
  depends_on "zig" => :build
  depends_on "asio"
  depends_on "liblo"
  depends_on "libvmaf"
  depends_on "lua"
  depends_on "readline"
  depends_on "rtmidi"
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_ttf" # FIXME: why? I don't understand. is this an sdl thing?

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
