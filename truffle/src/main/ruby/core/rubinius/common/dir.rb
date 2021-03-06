 # Copyright (c) 2007-2014, Evan Phoenix and contributors
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
# * Neither the name of Rubinius nor the names of its contributors
#   may be used to endorse or promote products derived from this software
#   without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Only part of Rubinius' dir.rb

class Dir

  # This seems silly, I know. But we do this to make Dir more resistent to people
  # screwing with ::File later (ie, fakefs)
  PrivateFile = ::File

  FFI = Rubinius::FFI

  def self.[](*patterns)
    if patterns.size == 1
      pattern = Rubinius::Type.coerce_to_path(patterns[0])
      return [] if pattern.empty?
      patterns = glob_split pattern
    end

    glob patterns
  end

  def self.glob(pattern, flags=0, &block)
    if pattern.kind_of? Array
      patterns = pattern
    else
      pattern = Rubinius::Type.coerce_to_path pattern

      return [] if pattern.empty?

      patterns = glob_split pattern
    end

    matches = []
    index = 0

    patterns.each do |pat|
      pat = Rubinius::Type.coerce_to_path pat
      enc = Rubinius::Type.ascii_compatible_encoding pat
      Dir::Glob.glob pat, flags, matches

      total = matches.size
      while index < total
        Rubinius::Type.encode_string matches[index], enc
        index += 1
      end
    end

    if block
      matches.each(&block)
      return nil
    end

    return matches
  end

  def self.glob_split(pattern)
    result = []
    start = 0
    while idx = pattern.find_string("\0", start)
      result << pattern.byteslice(start, idx)
      start = idx + 1
    end
    result << pattern.byteslice(start, pattern.bytesize)
  end

  def self.mkdir(path, mode = 0777)
    error = FFI::Platform::POSIX.mkdir(Rubinius::Type.coerce_to_path(path), mode)
    Errno.handle path if error != 0
    error
  end

  def self.chdir(path = ENV['HOME'])
    path = Rubinius::Type.coerce_to_path path

    if block_given?
      original_path = self.getwd
      error = FFI::Platform::POSIX.chdir path
      Errno.handle(path) if error != 0

      begin
        value = yield path
      ensure
        error = FFI::Platform::POSIX.chdir original_path
        Errno.handle(original_path) if error != 0
      end

      return value
    else
      error = FFI::Platform::POSIX.chdir path
      Errno.handle path if error != 0
      error
    end
  end

  def self.rmdir(path)
    error = FFI::Platform::POSIX.rmdir(Rubinius::Type.coerce_to_path(path))
    Errno.handle path if error != 0
    error
  end

  def self.getwd
    buf = String.pattern Rubinius::PATH_MAX, 0
    wd = FFI::Platform::POSIX.getcwd(buf, buf.length)
    Errno.handle unless wd
    Rubinius::Type.external_string wd
  end

  class << self
    alias_method :pwd, :getwd
    alias_method :delete, :rmdir
    alias_method :unlink, :rmdir
  end

  def self.exist?(path)
    PrivateFile.directory?(path)
  end

  class << self
    alias_method :exists?, :exist?
  end

end
