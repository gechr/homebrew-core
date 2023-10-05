class Lesspipe < Formula
  desc "Input filter for the pager less"
  homepage "https://www-zeuthen.desy.de/~friebel/unix/lesspipe.html"
  url "https://github.com/wofr06/lesspipe/archive/v2.10.tar.gz"
  sha256 "ad1589592ff46f7738eb1ba2ecc911b003a6afe9376656e9f6ec920d354a58df"
  license "GPL-2.0-only"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3339cf21563f5d610d86230e311ed696b06924684310e0620cae20b2a1cd1451"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3339cf21563f5d610d86230e311ed696b06924684310e0620cae20b2a1cd1451"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3339cf21563f5d610d86230e311ed696b06924684310e0620cae20b2a1cd1451"
    sha256 cellar: :any_skip_relocation, sonoma:         "3339cf21563f5d610d86230e311ed696b06924684310e0620cae20b2a1cd1451"
    sha256 cellar: :any_skip_relocation, ventura:        "3339cf21563f5d610d86230e311ed696b06924684310e0620cae20b2a1cd1451"
    sha256 cellar: :any_skip_relocation, monterey:       "3339cf21563f5d610d86230e311ed696b06924684310e0620cae20b2a1cd1451"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "959899f11f260332fb942b3220caacb20bfa7f1f71a469e4d30475c5a25f95e8"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    man1.mkpath
    system "make", "install"
  end

  def caveats
    <<~EOS
      add the following to your shell profile e.g. ~/.profile or ~/.zshrc:
        export LESSOPEN="|#{HOMEBREW_PREFIX}/bin/lesspipe.sh %s"
    EOS
  end

  test do
    touch "file1.txt"
    touch "file2.txt"
    system "tar", "-cvzf", "homebrew.tar.gz", "file1.txt", "file2.txt"

    assert_predicate testpath/"homebrew.tar.gz", :exist?
    assert_match "file2.txt", pipe_output(bin/"archive_color", shell_output("tar -tvzf homebrew.tar.gz"))
  end
end
