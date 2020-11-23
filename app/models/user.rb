require 'digest/sha1'

class User < ActiveRecord::Base
  validates_presence_of :username
  validates_uniqueness_of :username

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :password_non_blank

  has_many :albums

  accepts_nested_attributes_for :albums

  before_destroy :destroy_albums
  
  def destroy_albums
    self.albums.each {|x| x.destroy }
  end

  def password_non_blank
    errors.add_to_base("Missing password") if hashed_password.blank?
  end

  def self.authenticate(username, password)
    user = self.find_by_username(username)
     if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end


private

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end