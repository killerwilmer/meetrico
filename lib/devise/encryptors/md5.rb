module Devise
  module Encryptors
    class Md5 < Base
      def self.digest(password)
        str = [password].flatten.compact.join
        Digest::MD5.hexdigest(str)
      end

      def self.salt(username)
        nil
      end
    end
  end
end
