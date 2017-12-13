require 'spec_helper'

require 'active_record'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :immutable_with_after_creates, :force => true do |t|
    t.string :name
    t.timestamps
  end
end

describe ImmutabilityValidator do
  class ImmutableWithAfterCreate < ActiveRecord::Base
    validates :name, immutability: { message: 'but it was valid!' }

    after_create :call_save

    def call_save
      save!
    end
  end

  let(:object) { ImmutableWithAfterCreate.new(name: 'old_name') }

  it 'is valid so it should save' do
    expect(object).to be_valid
    object.save!
  end
end
