class AddIndexEmailToNewsletter < ActiveRecord::Migration
  def self.up
    add_index :news_letter_emails, :email, :unique => true, :length => 255

  end

  def self.down
  end
end
