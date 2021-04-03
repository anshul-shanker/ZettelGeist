Trestle.resource(:notes) do
  collection do
    # Set the default order when manual sorting is not applied
    Note.order(updated_at: :desc)
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
      # scope :year_1900_1949, -> { Movie.between(1900, 1949) }, label: "1900-1949"
      # scope :published
      # scope :drafts, -> { Note.unpublished }
    end

  # table do
  #   column :title
  #   # column :updated_at, sort: s{ default: true, default_order: desc }, align: :center
  #   actions
  # end

  # Customize the form fields shown on the new/edit views.
  #
  form do |note|
    text_field :title
    text_field :body
    text_field :tags
    text_field :mentions # Currently not working!
    hidden_field(:user_id,  :value => current_user.id)
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
