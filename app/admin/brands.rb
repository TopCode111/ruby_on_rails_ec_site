ActiveAdmin.register Brand do
  menu priority: 4
  permit_params :name
  remove_filter :items
end
