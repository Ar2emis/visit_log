# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :name, :role, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :role
    actions
  end

  filter :email
  filter :name
  filter :role

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :role
      f.input :password if object.new_record?
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :name
      row :role
    end
  end

  controller do
    def create
      @user = User.new(permitted_params[:user])
      @user.skip_confirmation!
      super
    end

    def update_resource(user, attributes)
      attributes = attributes.first
      user.skip_reconfirmation! if attributes[:email]
      user.update_without_password(attributes)
    end
  end
end
