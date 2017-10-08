describe "v1/tasks" do
  describe "index" do
    it "should return empty task list" do
      get '/api/v1/tasks'
      expect(last_response).to be_ok
      # TODO
    end
  end
end
