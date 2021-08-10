Trestle.resource(:tags) do
  menu do
    item :tags, icon: "fa fa-bookmark"
  end

  scope :notes, -> { Tag.where(type: "Note::Tag") }, default: true

  collection do
    model.alphabetical
  end

  table do
    column :name, link: true
    column :media, sort: :type
    actions
  end

  form dialog: true do |genre|
    select :type, { "Tag" => "Note::Tag" }
    text_field :name
  end
end