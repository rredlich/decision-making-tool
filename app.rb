require "sinatra/activerecord"
require "sinatra/reloader"

class Task < ActiveRecord::Base
    belongs_to :decision
end

class Decision < ActiveRecord::Base
    has_many :tasks
end

class MyApp < Sinatra::Base
    helpers do
        def h(text)
            Rack::Utils.escape_html(text)
        end
      
        def hattr(text)
            Rack::Utils.escape_path(text)
        end
    end

    register Sinatra::ActiveRecordExtension
    
    configure :development do
        register Sinatra::Reloader
    end

    get '/' do
        @js = ["index.js"]
        erb :index
    end

    get '/decisions' do
        @js = ["new.js"]
        erb :new
    end

    post '/decisions' do
        hash = SecureRandom.base64(5)
        
        D = Decision.create(hash_id: hash, vote_limit: 3)
        for v in params do
            D.tasks.create(name: v[1], votes: 0)
        end
        @tasks = D.tasks
        
        redirect to "decisions/#{hash}"
    end

    patch '/decisions/:hash' do
        D = Decision.find_by(hash_id: params[:hash])
        hash = D.hash_id
        
        D.update(vote_limit: params[:vote_limit].to_i)

        redirect to "/decisions/#{hash}"
    end

    get '/decisions/:hash' do
        D = Decision.find_by(hash_id: params[:hash])
        @tasks = D.tasks.order(votes: :desc)
        @hash = params[:hash]
        @vote_limit = D.vote_limit        

        @js = ["settings.js"]
        erb :settings
    end

    get '/decisions/:hash/vote' do
        D = Decision.find_by(hash_id: params[:hash])
        @tasks = D.tasks
        @hash = params[:hash]
        @vote_limit = D.vote_limit

        @js = ["vote.js"]
        erb :vote
    end

    get '/decisions/:hash/result' do
        D = Decision.find_by(hash_id: params[:hash])
        @tasks = D.tasks.order(votes: :desc)
        @hash = D.hash_id
        
        erb :result
    end

    post '/decisions/:hash/result' do
        D = Decision.find_by(hash_id: params[:hash])
        @tasks = D.tasks
        @hash = D.hash_id

        for k in params.keys do
            if k != "hash"
                T = @tasks.find_by(id: k)
                T.update(votes: T.votes+1)
            end
        end
        
        redirect to "decisions/#{@hash}/result"
    end

    post '/decisions/:hash/clean' do
        D = Decision.find_by(hash_id: params[:hash])
        @tasks = D.tasks
        @hash = D.hash_id

        @tasks.each do |t|
            t.update(votes: 0)
        end
        
        redirect to "decisions/#{@hash}"
    end
end