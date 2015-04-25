require 'rspec-rails'
require 'rails_helper'

puts 'Running this test file...'

RSpec.describe User, :type => :model do
  it "checks the health overlfow mechanic" do
    azorius = Character.create!(name: "Azorius", hitpoints: 10, max_hitpoints: 10)

    expect(azorius.health_overflow_check).to eq(azorius.max_hitpoints)
  end
end