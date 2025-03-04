class UserFile < ApplicationRecord
  STORED_IN_DB = 0,
  STORED_ON_USER_DEVICE = 1

  attr_accessor :file_name, :file_path, :decryption_key_storage
end
