class Feedback < ApplicationRecord
  validates :name , presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :text , presence: true

  paginates_per 10
end
