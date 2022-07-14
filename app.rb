require "sinatra/activerecord"

class Task < ActiveRecord::Base
    belongs_to :decision
end

class Decision < ActiveRecord::Base
    has_many :tasks
end

class MyApp < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    
    configure :development do
        register Sinatra::Reloader
    end

    get '/' do
        
        erb :new
    end

    get '/decisions' do
        erb :new
    end

    post '/decisions' do
        hash = SecureRandom.base64(5)

        D = Decision.create(hash_id: hash)
        for v in params do
            D.tasks.create(name: v[1], votes: 0)
        end
        @tasks = D.tasks
        
        redirect to "settings/decisions/#{hash}"
    end

    get '/settings/decisions/:hash' do
        D = Decision.find_by(hash_id: params[:hash])
        @tasks = D.tasks.order(votes: :desc)
        @hash = params[:hash]

        erb :settings
    end

    get '/decisions/:hash/vote' do
        D = Decision.find_by(hash_id: params[:hash])
        @tasks = D.tasks
        @hash = params[:hash]

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
        
        redirect to "settings/decisions/#{@hash}"
    end
end