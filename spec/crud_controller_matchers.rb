module CrudSetup
  def setup_crud_names
    # set up the variables we'll refer to in all specs below.
    # If we had an AssetsController, these would map to:
    # @model_name                    => 'Asset'
    # @model_klass                   => Asset
    # @model_symbol                  => :Asset
    # @pluralized_model_name         => 'Assets'
    # @assigns_model_name            => :asset
    # @pluralized_assigns_model_name => :assets
    @model_name                    = @model.classify
    @model_klass                   = @model_name.constantize
    @model_symbol                  = @model_name.to_sym
    @pluralized_model_name         = @model_name.humanize.pluralize
    @assigns_model_name            = @model_name.underscore.to_sym
    @pluralized_assigns_model_name = @model_name.underscore.pluralize.to_sym
    
    # continuing AssetsController example, this maps to:
    # @stubbed_model => mock_model(Asset, :id => 1)
    # @stubbed_model_collection => [@stubbed_model]
    # allow(Asset).to receive(:find).and_return(@stubbed_model_collection)
    @stubbed_model = @model_klass.new
    allow(@stubbed_model).to receive(:id).and_return(1)
      
    @stubbed_model_collection = [@stubbed_model]
    allow(@model_klass).to receive(:find).with(:all).and_return(@stubbed_model_collection)
  end
end

shared_examples "CRUD GET index" do
  include CrudSetup
  
  before(:each) do
    setup_crud_names
  end
  
  it "should find all #{@pluralized_model_name}" do
    allow(@model_klass).to receive(:find).with(:all)
    do_get
  end
  
  it "should be successful" do
    do_get
    expect(response).to be_success
  end
  
  it "should render the correct template" do
    do_get
    expect(response).to render_template(:index)    
  end
  
  it "should assign the #{@pluralized_model_name} to the #{@pluralized_model_name} view variable" do
    do_get
    expect(assigns[@pluralized_assigns_model_name]).not_to be_nil
  end

  def do_get
    get 'index'
  end
end

shared_examples "CRUD GET show" do
  include CrudSetup
  
  before(:each) do
    setup_crud_names
  end
  
  describe "with a valid ID" do
    before(:each) do
      allow(@model_klass).to receive(:find).and_return(@stubbed_model)
    end
    
    it "should find the correct #{@model_name}" do
      allow(@model_klass).to receive(:find).with(@stubbed_model.id.to_s).and_return(@stubbed_model)
      do_get
    end
    
    it "should render the correct template when requesting HTML" do
      do_get
      expect(response).to render_template(:show)
    end
    
    def do_get format = 'html'
      get 'show', :id => @stubbed_model.id, :format => format
    end
  end
  
  describe "with an invalid ID" do
    before(:each) do
      allow(@model_klass).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
    end
    
    it "should redirect to /#{@pluralized_assigns_model_name} if not found via HTML" do
      do_get
      expect(response).to redirect_to("/#{@pluralized_assigns_model_name}")
    end
    
    def do_get format = 'html'
      get 'show', :id => -1, :format => format
    end
  end
end

shared_examples "CRUD GET new" do
  include CrudSetup
  
  before(:each) do
    setup_crud_names
  end
  
  it "should be successful" do
    do_get
    expect(response).to be_success
  end
  
  it "should render the correct template" do
    do_get
    expect(response).to render_template(:new)    
  end
  
  it "should assign the #{@model_name} to the #{@model_name} view variable" do
    do_get
    expect(assigns[@assigns_model_name]).not_to be_nil
  end

  def do_get
    get 'new'
  end
end

shared_examples "CRUD POST create" do
  include CrudSetup
  
  before(:each) do
    setup_crud_names
  end
  
  describe "with valid params" do
    
    before(:each) do
      @new_stubbed_model = @model_klass.new
      allow(@model_klass).to receive(:new).and_return(@new_stubbed_model)
      
      @params = {"title" => 'test', "key" => "value"}
    end
    
    it "should build a new #{@model_name}" do
      allow(@model_klass).to receive(:new).with(@params).and_return(@new_stubbed_model)
      do_post
    end

    it "should save the #{@model_name}" do
      allow(@new_stubbed_model).to receive(:save).and_return(true)
      do_post
    end
    
    it "should redirect to the new #{@model_name}'s show page when requesting HTML" do
      do_post
      expect(response).to redirect_to("/#{@pluralized_assigns_model_name}/#{@new_stubbed_model.id}")
    end
    
    it "sets a flash message" do
      do_post
      expect(flash[:notice]).to be == "#{@model_name} was successfully created."
    end

    it "should return JSON when requesting JSON" do
      allow(@new_stubbed_model).to receive(:to_json).and_return('JSON')
      do_post 'json'
      expect(response.body).to be == "JSON"
    end
    
    def do_post format = 'html'
      post 'create', @assigns_model_name => @params, :format => format
    end
  end

  describe "with invalid parameters" do
    before(:each) do
      @errors = instance_double(Array, :collect => [], :to_json => 'JSON')
      
      @new_stubbed_model = instance_double(@model_klass, :id => 1, :save => true, :errors => @errors)
      allow(@new_stubbed_model).to receive(:save).and_return(false)
      allow(@model_klass).to receive(:new).and_return(@new_stubbed_model)
      
      @params = {"title" => 'test', "key" => "value"}
    end
    
    it "should render the new template when requesting HTML" do
      do_post
      expect(response).to render_template(:new)    
    end
    
    it "assigns #{@model_name}" do
      do_post
      expect(assigns[@assigns_model_name]).not_to be_nil
    end

    it "should render the errors to JSON when requesting JSON" do
      allow(@errors).to receive(:to_json).and_return('JSON')
      
      do_post 'json'
      expect(response.body).to be == 'JSON'
    end
    
    def do_post format = 'html'
      post 'create', @assigns_model_name => @params, :format => format
    end
  end
end

shared_examples "CRUD GET edit" do
  include CrudSetup
  
  before(:each) do
    setup_crud_names
  end
  
  describe "with a valid ID" do
    before(:each) do
      allow(@model_klass).to receive(:find).and_return(@stubbed_model)
    end
    
    it "should find the #{@model_name}" do
      allow(@model_klass).to receive(:find).with(@stubbed_model.id.to_s).and_return(@stubbed_model)
      do_get
    end
    
    it "should render the edit template when requesting HTML" do
      do_get
      expect(response).to render_template(:edit)    
    end
    
    it "should be successful" do
      do_get
      expect(response).to be_success
    end
    
    def do_get format = 'html'
      get 'edit', :id => @stubbed_model.id, :format => format
    end
  end
  
  describe "with an invalid ID" do
    before(:each) do
      allow(@model_klass).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
    end
    
    it "should redirect to the #{@model_name} index when requesting HTML" do
      do_get
      expect(response).to redirect_to("/#{@pluralized_assigns_model_name}")    
    end

    it "should render a 404 when requesting JSON" do
      do_get 'json'
      expect(response.status).to be == 404
    end
    
    def do_get format = 'html'
      get 'edit', :id => -1, :format => format
    end
  end
end

shared_examples "CRUD PUT update" do
  include CrudSetup
  
  before(:each) do
    setup_crud_names
  end
  
  describe "with valid parameters" do
    
    before(:each) do
      allow(@stubbed_model).to receive(:update).and_return(true)   
      
      allow(@model_klass).to receive(:find).and_return(@stubbed_model)
    end
    
    it "should find the #{@model_name}" do
      allow(@model_klass).to receive(:find).with(@stubbed_model.id.to_s).and_return(@stubbed_model)
      do_put
    end
    
    it "should save the #{@model_name}" do
      allow(@stubbed_model).to receive(:update_attributes).with({"title" => 'test'}).and_return(true)
      do_put
    end
    
    it "should redirect to the index path when requesting HTML" do
      do_put
      expect(response).to redirect_to("/#{@pluralized_assigns_model_name}")
      expect(flash[:notice]).to_not be_nil
    end

    it "sets a flash message" do
      do_put
      expect(flash[:notice]).to be == "#{@model_name} was successfully updated."
    end

    it "should render 200 OK for JSON" do
      do_put 'json'
      expect(response.status).to be == 200
    end

    def do_put format = 'html'
      put 'update', :id => @stubbed_model.id, @assigns_model_name => {:title => 'test'}, :format => format
    end
  end

  describe "with invalid parameters" do
    before(:each) do
      @errors = instance_double(Array, :collect => [], :to_json => 'JSON')
      allow(@stubbed_model).to receive(:errors).and_return(@errors)
      allow(@stubbed_model).to receive(:update).and_return(false)
      
      allow(@model_klass).to receive(:find).and_return(@stubbed_model)
    end
    
    it "should redirect to the #{@model_name} index if the #{@model_name} was not found" do
      allow(@model_klass).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
      do_put
      
      expect(response).to redirect_to("/#{@pluralized_assigns_model_name}")    
    end
    
    it "should render the edit action when requesting with HTML" do
      do_put
      expect(response).to render_template(:edit)    
    end
    
    it "should render the errors to JSON when requesting with JSON" do  
      allow(@errors).to receive(:to_json).and_return('JSON')
          
      do_put 'json'
      expect(response.body).to be == 'JSON'
    end
    
    def do_put format = 'html'
      put 'update', :id => @stubbed_model.id, @assigns_model_name => {:title => 'test'}, :format => format
    end
  end
end

shared_examples "CRUD DELETE destroy" do
  include CrudSetup
  
  before(:each) do
    setup_crud_names
  end
  
  describe "with a valid id" do
    
    before(:each) do
      allow(@model_klass).to receive(:find).and_return(@stubbed_model)
    end
    
    it "should find the correct #{@model_name}" do
      allow(@model_klass).to receive(:find).with(@stubbed_model.id.to_s).and_return(@stubbed_model)
      do_delete
    end
    
    it "should destroy the #{@model_name}" do
      allow(@stubbed_model).to receive(:destroy).and_return(true)    
      do_delete
    end
    
    it "should redirect to #{@model_name} index when requesting HTML" do
      do_delete
      expect(response).to redirect_to("/#{@pluralized_assigns_model_name}")
    end

    it "sets a flash message" do
      do_delete
      expect(flash[:notice]).to be == "#{@model_name} was successfully destroyed."
    end

    it "should render 200 when requesting JSON" do
      do_delete 'json'
      expect(response.status).to be == 204
    end
    
    def do_delete format = 'html'
      delete 'destroy', :id => @stubbed_model.id, :format => format
    end
  end
  
  describe "with an invalid ID" do
    
    before(:each) do
      allow(@model_klass).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
    end
    
    it "should redirect to #{@model_name} index when requesting HTML" do
      do_delete
      expect(response).to redirect_to("/#{@pluralized_assigns_model_name}")    
    end
    
    it "should render a 404 when requesting JSON" do
      do_delete 'json'
      expect(response.status).to be == 404
    end

    def do_delete format = 'html'
      delete 'destroy', :id => -1, :format => format
    end
  end
end

shared_examples "GET index redirects to login" do
  it "GET index" do
    get :index
    expect(response).to redirect_to(:auth_login)
  end
end

shared_examples "GET show redirects to login" do
  it "GET show" do
    get 'show', :id => 1, :format => 'html'
    expect(response).to redirect_to(:auth_login)
  end
end

shared_examples "GET new redirects to login" do
  it "GET new" do
    get :new
    expect(response).to redirect_to(:auth_login)
  end
end

shared_examples "POST create redirects to login" do
  it "POST create" do
    post :create
    expect(response).to redirect_to(:auth_login)
  end
end

shared_examples "GET edit redirects to login" do
  it "GET edit" do
    get :edit, :id => 1
    expect(response).to redirect_to(:auth_login)
  end
end

shared_examples "PUT update redirects to login" do
  it "PUT update" do
    put :update, :id => 1
    expect(response).to redirect_to(:auth_login)
  end
end

shared_examples "DELETE destroy redirects to login" do
  it "DELETE destroy" do
    delete :destroy, :id => 1
    expect(response).to redirect_to(:auth_login)
  end
end
