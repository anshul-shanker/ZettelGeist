Trestle.resource(:notes) do
  collection do
    # Fetch notes only for current user and set the default order when manual sorting is not applied
    Note.notes_by_user(current_user).order(updated_at: :desc)
  end

  search do |query|
    query ? collection.pg_search(query) : collection
  end

  return_to do
    admin.path(:index)
  end

  menu do
    item :notes, icon: "fa fa-book"
  end

  # Customize the table on the index view.
    scopes do
      scope :notes_by_user, -> { Note.notes_by_user(current_user) }, default: true, label: "All"

      Tag.all.each do |tag|
        scope tag.name, -> { tag.notes }, label: "#{tag.name}"
      end
    end

  # index view
  table do
    column :title
    column :body
    column :tags, format: :tags, class: "hidden-xs" do |note|
      note.tags.map(&:name)
    end
    column :mentions, format: :tags
    column :created_at
    column :updated_at

    actions
  end

  # Customize the form fields shown on the new/edit views.
  form do |note|
    text_field :title
    editor :body

    # text_field :tags, multiple: true, clickable: true
    select :tag_ids, Note::Tag.alphabetical, { label: "Tags" }, multiple: true

    text_field :mentions, multiple: true # Currently not working!
    hidden_field(:user_id,  :value => current_user.id)
  end
end
