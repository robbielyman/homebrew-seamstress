class SeamstressAT2 < Formula
  desc "Art engine and batteries-included Lua runtime"
  homepage "https://alanza.xyz/code/seamstress"
  url "https://github.com/robbielyman/seamstress/archive/refs/tags/v2.0.0-alpha+build.250109.tar.gz"
  sha256 "8cfeb6a3b5de23f03fa395f4dcdf582853e173d888396fed21e87533a34c040d"
  license "MIT"

  depends_on "zig" => :build
  depends_on "busted" => :test


  def install
    system "zig", "build", "install", "--verbose", "-Doptimize=ReleaseSafe", "--prefix", prefix.to_s
  end

  test do
    system "echo", "#{Formula["busted"].libexec}/share/lua/5.4/?/?.lua;#{Formula["busted"].libexec}/share/lua/5.4/?.lua;#{Formula["busted"].libexec}/share/lua/5.4/?/init.lua"
    system "echo", "#{Formula["busted"].libexec}/lib/lua/5.4/?.so"
    with_env(
      "LUA_PATH" => "#{Formula["busted"].libexec}/share/lua/5.4/?/?.lua;#{Formula["busted"].libexec}/share/lua/5.4/?.lua;#{Formula["busted"].libexec}/share/lua/5.4/?/init.lua",
      "LUA_CPATH" => "#{Formula["busted"].libexec}/lib/lua/5.4/?.so"
    ) do
      assert_includes shell_output("#{bin}/seamstress --test"), "0 failures / 0 errors"
    end
  end
end
