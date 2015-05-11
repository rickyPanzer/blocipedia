# == Schema Information
#
# Table name: collaborators
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  wiki_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_collaborators_on_user_id  (user_id)
#  index_collaborators_on_wiki_id  (wiki_id)
#

class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki
end
