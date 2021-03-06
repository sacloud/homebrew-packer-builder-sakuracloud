class PackerBuilderSakuracloud < Formula

  _version = "0.5.1"
  sha256_src = "fc777486f7ccaaa7121cc3c2f7762dd18acd5640f7235f3f0f3fb47274880f2c"

  desc "Packer builder plugin for SakuraCloud"
  homepage "https://github.com/sacloud/packer-builder-sakuracloud"
  url "https://github.com/sacloud/packer-builder-sakuracloud/releases/download/v#{_version}/packer-builder-sakuracloud_darwin-amd64.zip"
  sha256 sha256_src
  head "https://github.com/sacloud/packer-builder-sakuracloud.git"
  version _version

  depends_on "packer"

  def install
    bin.install "packer-builder-sakuracloud"
  end

  def caveats; <<~EOS

    This plugin requires locate into "~/.packer.d/plugins" directory.
    To enable, execute following:

        mkdir -p ~/.packer.d/plugins
        ln -s #{bin/"packer-builder-sakuracloud"} ~/.packer.d/plugins/

  EOS
  end


  test do
    minimal = testpath/"minimal.tf"
    minimal.write <<~EOS
    {
      "builders": [{
          "type": "sakuracloud",
          "zone": "is1b",
          "os_type": "centos",
          "password": "this_is_fake_password"
      }]
    }
    EOS
    system "packer", "validate", minimal
  end
end
