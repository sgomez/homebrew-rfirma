cask "rfirma" do
  version "0.17.0"
  sha256 "8121e46cda3c0cb143eefe19a4427d79ee92e347bc52a942926b1e11a237c040"

  url "https://github.com/sgomez/rfirma/releases/download/v#{version}/rfirma_#{version}_aarch64.dmg"
  name "rFirma"
  desc "Firma electrónica con los certificados del sistema, alternativa a AutoFirma"
  homepage "https://rfirma.sgomez.me/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "rfirma.app"

  uninstall quit: "me.sgomez.rfirma"

  zap trash: [
    "~/Library/Application Support/rfirma",
    "~/Library/Caches/me.sgomez.rfirma",
    "~/Library/HTTPStorages/me.sgomez.rfirma",
    "~/Library/Preferences/me.sgomez.rfirma.plist",
    "~/Library/Saved Application State/me.sgomez.rfirma.savedState",
    "~/Library/WebKit/me.sgomez.rfirma",
  ]

  caveats <<~EOS
    rFirma no está firmada por Apple. La primera vez, para que macOS la abra:
      xattr -c #{appdir}/rfirma.app
  EOS
end
