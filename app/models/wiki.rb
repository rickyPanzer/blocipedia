# == Schema Information
#
# Table name: wikis
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  private    :boolean
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_wikis_on_user_id  (user_id)
#

class Wiki < ActiveRecord::Base
  belongs_to :user

  after_initialize :init

  def init
    self.private ||= false
  end

end
