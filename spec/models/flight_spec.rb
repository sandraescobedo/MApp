require 'rails_helper'

RSpec.describe Flight, type: :model do
  it { should belong_to(:departured).class_name('Airport').with_foreign_key('departured_id') }
  it { should belong_to(:arrived).class_name('Airport').with_foreign_key('arrived_id') }
  it { should belong_to(:user) }
end
