class SeamstressAT2 < Formula
  desc "Art engine and batteries-included Lua runtime"
  homepage "https://alanza.xyz/"
  url "https://github.com/robbielyman/seamstress/archive/refs/tags/v2.0.0-alpha+build.250109.tar.gz"
  sha256 "e61cda863afbf5c1555bbee35cdc5a3f0f8b1235451af2ac5a3a6e680eba4e02"
  license "MIT"

  depends_on "zig" => :build
  depends_on "busted" => :test

  def install
    system "zig", "build", "install", "--verbose", "-Doptimize=ReleaseSafe", "--prefix", prefix.to_s
  end

  test do
    lua_path_1 = "#{Formula["busted"].libexec}/share/lua/5.4/?/?.lua"
    lua_path_2 = "#{Formula["busted"].libexec}/share/lua/5.4/?.lua"
    lua_path_3 = "#{Formula["busted"].libexec}/share/lua/5.4/?/init.lua"
    with_env(
      "LUA_PATH"  => "#{lua_path_1};#{lua_path_2};#{lua_path_3}",
      "LUA_CPATH" => "#{Formula["busted"].libexec}/lib/lua/5.4/?.so",
    ) do
      assert_includes shell_output("#{bin}/seamstress --test"), "0 failures / 0 errors"
    end
  end
end
