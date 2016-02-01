RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  config.excluded_models << BookAuthor
  config.excluded_models << OrderItem
  config.model Address do
    list do
      field :zipcode
      field :country
      field :city
      field :address
      field :phone
    end
  end

  config.model Author do
    list do
      field :firstname
      field :lastname
      field :biography
    end
  end

  config.model Book do
    list do
      field :title
      field :price
      field :category
      field :in_stock
      field :sold
      field :description
      field :full_description
    end
  end

  config.model Category do
    list do
      field :title
    end
  end

  config.model Country do
    list do
      field :name
    end
  end

  config.model CreditCard do
    list do
      field :firstname
      field :lastname
      field :customer
      field :number
      field :CVV
      field :expiration_month
      field :expiration_year
    end
  end

  config.model Customer do
    list do
      field :firstname
      field :lastname
    end
  end

  config.model Order do
    list do
      field :total_price
      field :completed_date
      field :state
      field :customer
      field :credit_card
      field :billing_address
      field :shipping_address
    end
  end

  config.model Review do
    list do
      field :title
      field :text
      field :value
      field :book
      field :customer
    end
  end
end
