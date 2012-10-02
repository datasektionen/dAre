# == Schema Information
#
# Table name: administrators
#
#  id         :integer         not null, primary key
#  kth_id     :string(255)
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class AdministratorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
