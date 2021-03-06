# frozen_string_literal: true

class Service < ApplicationRecord
  has_many :invoices, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true
end
