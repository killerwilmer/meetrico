class CreateNewsLetterEmails < ActiveRecord::Migration
  def self.up
    create_table :news_letter_emails do |t|
      t.text :email, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :news_letter_emails
  end
end
