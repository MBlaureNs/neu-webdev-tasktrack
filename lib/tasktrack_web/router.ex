defmodule TaskTrackWeb.Router do
  use TaskTrackWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :get_current_user    
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # adapted from nat's notes
  # http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/12-microblog/notes.html
  def get_current_user(conn, _params) do
    # TODO: Move this function out of the router module.
    user_id = get_session(conn, :user_id)
    user = TaskTrack.Accounts.get_users(user_id || -1)
    assign(conn, :current_user, user)
  end
  
  scope "/", TaskTrackWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UsersController
    resources "/tasks", TasksController

    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", TaskTrackWeb do
  #   pipe_through :api
  # end
end
