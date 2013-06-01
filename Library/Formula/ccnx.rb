require 'formula'

# for now, install with:
#    `brew install https://raw.github.com/dcunited001/homebrew/dc/ccn-keggar/Library/Formula/ccnx.rb`

class Ccnx < Formula
  homepage 'http://www.ccnx.org/'

  url 'http://www.ccnx.org/releases/ccnx-0.7.2.tar.gz'
  version '0.7.2'
  sha1 '3a6fd14be149b9c8c1a46c56c29df3833686ceb5'

  # url 'http://www.ccnx.org/releases/ccnx-0.7.1.tar.gz'
  # version '0.7.1'
  # sha1 '4ae70dfaf1ccf287c9ab905288267e5ef59b00f6'

  depends_on 'git'
  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'pcre'        # libpcre3-dev
  depends_on 'pkg-config'
  depends_on 'libssh'      # libssl-dev
  depends_on 'beecrypt'    # libecryptfs0
  depends_on 'libxml2' if MacOS.version == :leopard    # libxml2-utils
  depends_on 'openssl'

  # install or check for java?
  # * openjdk-6-jre-lib
  # * is java only required for the android ccnx?

  # sample options
  # option '32-bit'
  option 'with-arch-x86-64', 'Specify x86_64 architecture'
  option 'with-arch-i386', 'Specify i386 architecture'
  option 'with-arch-ppc', 'Specify ppc architecture'

  # can be built with gcc or clang

  def install
    ENV.libxml2 if MacOS.version >= :snow_leopard

    args = %W[
      --disable-debug
      --prefix=#{prefix}
      CC=#{ENV.cc}
]

    # osx should just use the default arch for the system
    #   * you can build for multiple architectures in the same binary, 
    #   * not supported in this formula right now
    case 
      when build.include?('with-arch-x86-64') then append_platcflags 'x86_64'
      when build.include?('with-arch-i386')   then append_platcflags 'i386'
      when build.include?('with-arch-ppc')    then append_platcflags 'ppc'
    end

    system "./configure", *args
    
    # system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test ccnx`.
    system "false"
  end

  private

  def append_platcflags(arch)
    ENV.append "PLATCFLAGS", "-fno-common -force_cpusubtype_ALL -arch #{arch}"
  end
end

__END__

For parts of the system written in C, you will require a standard
toolchain including gcc, make. etc. and the following libraries which
are not included in the distribution.

* libcrypto >= 0.9.8 from openssl available from http://openssl.org/source/
* expat available from http://sourceforge.net/projects/expat/
* libpcap available from http://www.tcpdump.org
  * optional, needed for certain utilities only)
  * distributed with OSX 
*  libxml2 available from xmlsoft.org

In addition, you will need vlc and wireshark to build and use the CCNx
plugins for those packages.  Please see the individual README files
for more information.



