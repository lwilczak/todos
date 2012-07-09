class TodosController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_todo, :only => [:show, :edit, :update, :destroy]

  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'text/xml' }
  
  # GET /todos
  # GET /todos.json
  def index

    case params[:field]
      when 'subiect'
        field = "subiect"
      when 'priority'
        field = "priority_id"
      else
        field = "created_at"
    end

    @todos = current_user.todos.order(field)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
      format.xml { render xml: @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  # GET /todos/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: @todo }
      format.json { render json: @todo }
    end
  end

  def priorities
    @priorities = Priority.all

    respond_to do |format|
      format.xml { render xml: @priorities }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = Todo.new
    @priorities = Priority.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @priorities = Priority.all
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(params[:todo].merge(:user => current_user))

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
        format.json { render json: @todo, status: :created, location: @todo }
        format.xml { render xml: @todo }
      else
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
        format.xml { render xml: @todo.errors }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
        format.xml { render xml: @todo }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
        format.xml { render xml: @todo.errors }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to todos_url }
      format.json { head :no_content }
      format.xml { render xml: @todo }
    end
  end

  def find_todo
    @todo = Todo.find_by_id_and_user_id(params[:id],current_user.id)
    raise "You are not authorized to view this page!" if @todo.nil?
  end
end
