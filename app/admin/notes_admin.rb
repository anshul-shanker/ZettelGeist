# https://github.com/TrestleAdmin/trestle/issues/205
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

  # https://github.com/TrestleAdmin/trestle/wiki/How-To:-Add-Custom-Action
  # This can be used for filtering adn to add tags route as a sidebar

  menu do
    item :notes, icon: "fa fa-star"
    # item :tags, icon: "tags"
  end

  # Customize the table columns shown on the index view.
    scopes do
      scope :notes_by_user, -> { Note.notes_by_user(current_user) }, default: true, label: "All"
      
      # scope :notes_not_by_user, -> { Note.notes_not_by_user(current_user) }, label: "Notes by others"
      # scope :year_1900_1949, -> { Movie.between(1900, 1949) }, label: "1900-1949"
      # scope :published
      # scope :drafts, -> { Note.unpublished }
    end

  # index view
  table do
    column :title
    column :body
    column :user
    column :tags, format: :tags
    column :mentions, format: :tags
    column :created_at
    column :updated_at

    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |note|
    text_field :title
    editor :body
    text_field :tags, multiple: true, clickable: true
    text_field :mentions, multiple: true # Currently not working!
    hidden_field(:user_id,  :value => current_user.id)
    # editor :content
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:note).permit(:name, ...)
  # end
end
