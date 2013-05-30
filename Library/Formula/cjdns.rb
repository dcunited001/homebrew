require 'formula'

# for now, install with:
#    `brew install https://raw.github.com/dcunited001/homebrew/dc/ccn-keggar/Library/Formula/cjdns.rb`

class Ccnx < Formula
  homepage 'https://github.com/cjdelisle/cjdns'
  head 'https://github.com/cjdelisle/cjdns.git', :branch => 'named-pipes'
  sha1 '4ae70dfaf1ccf287c9ab905288267e5ef59b00f6'
  # no url
  # no version

  depends_on 'cmake' => :build
  depends_on 'nacl'
  depends_on 'libevent'

  def install
    system "./do"
    
    bin.install 'cjdroute'
    bin.install 'cjdns'
  end

  test do
    system "false"
  end

end

__END__

CJDNS Github: https://github.com/cjdelisle/cjdns/tree/named-pipes#start-cjdroute-as-non-root-user
Configuring CJDNS: https://github.com/cjdelisle/cjdns/blob/master/rfcs/configure.md

