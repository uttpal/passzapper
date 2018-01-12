class Crypto

  SECRET = Rails.application.secrets.secret_key_base
  SALT = SECRET
  def self.encrypt(payload, username)
    key=EzCrypto::Key.with_password SECRET+username[0,3], SALT
    key.encrypt64 payload
  end

  def self.decrypt(encrypted, username)
    key=EzCrypto::Key.with_password SECRET+username[0,3], SALT
    key.decrypt64 encrypted
  end
end
