# encoding: UTF-8

<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_filter :find_<%= singular_table_name %>, <%= key_value :except, "[:index, :new, :create]" %>

  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
  end

  def show
  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  def edit
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "params[:#{singular_table_name}]") %>

    if @<%= orm_instance.save %>
      redirect_to admin_<%= index_helper %>_path, <%= key_value :notice, "'#{human_name} criado com sucesso.'" %>
    else
      render :new
    end
  end

  def update
    if @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
      redirect_to admin_<%= index_helper %>_path, <%= key_value :notice, "'#{human_name} atualizado com sucesso.'" %>
    else
      render :edit
    end
  end

  def destroy
    @<%= orm_instance.destroy %>

    redirect_to admin_<%= index_helper %>_path, <%= key_value :notice, "'#{human_name} excluído com sucesso.'" %>
  end

  private

  def find_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end
end
<% end -%>
