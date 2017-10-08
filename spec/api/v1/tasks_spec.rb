describe 'v1/tasks' do
  let(:tag_dishes) {
    Tag.create!(title: 'dishes')
  }

  let(:task_do_dishes) {
    Task.create!(
      title: 'do dishes',
      tags: [tag_dishes],
    )
  }

  describe 'index' do
    it 'should return empty task list' do
      get '/api/v1/tasks'
      expect(last_response).to be_ok
      json = MultiJson.load(last_response.body)
      expect(json['data']).to be_empty
    end

    it 'should return persisted tasks' do
      task_do_dishes;

      get '/api/v1/tasks'
      expect(last_response).to be_ok
      json = MultiJson.load(last_response.body)

      expect(data = json['data']).to be_a(Array)
      expect(data.size).to eq 1
      task_0 = data[0]
      expect(task_0['id']).to eq task_do_dishes.id.to_s
      expect(task_0['type']).to eq 'tasks'
      expect(task_0['attributes']['title']).to eq 'do dishes'
    end
  end

  describe 'create' do
    it 'should create tasks + tags' do
      tag_dishes;

      request = {
        data: {
          attributes: {
            title: "Buy food and do dishes",
            tags: %w(dishes food),
          }
        }
      }

      post_json '/api/v1/tasks', request.to_json
      expect(last_response).to be_ok

      expect((tags = Tag.order(:id).to_a).size).to eq(2)
      expect((tasks = Task.all.to_a).size).to eq(1)

      json = MultiJson.load(last_response.body)

      expect(task_0 = json['data']).to be_a(Hash)
      expect(task_0['id']).to eq tasks.first.id.to_s
      expect(task_0['type']).to eq 'tasks'
      expect(task_0['attributes']['title']).to eq 'Buy food and do dishes'

      new_task = tasks.first
      expect(new_task.title).to eq 'Buy food and do dishes'
      expect(new_task.tag_ids.sort).to eq tags.map(&:id)

      expect(tags[0].title).to eq 'dishes'
      expect(tags[1].title).to eq 'food'
    end
  end
end
