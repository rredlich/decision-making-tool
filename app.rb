class MyApp < Sinatra::Base
    configure :development do
        register Sinatra::Reloader
    end
    
    def read_tasks
        tasks_read = File.read("tasks.txt").split("\n")

        tasks = {}
        for record in tasks_read do
            task = record.split(", ")
            tasks[task[0]] = [task[1], task[2].to_i]
        end

        return tasks
    end

    def write_tasks(tasks, clear=false)
        File.open("tasks.txt", "w") do |file|
            tasks.each do |key, array|
                if clear
                    file.write(key + ", " + array[0] + ", 0\n")
                else
                    file.write(key + ", " + array[0] + ", " + array[1].to_s + "\n")
                end
            end
        end
    end

    get '/' do
        @tasks = read_tasks

        erb :index
    end

    get '/new' do
        erb :new
    end

    post '/result' do
        tasks_tmp = read_tasks
        for k in params.keys do
            tasks_tmp[k][1]=tasks_tmp[k][1]+1
        end
        write_tasks(tasks_tmp)
        @tasks = tasks_tmp.sort_by {|_key, array| array[1]}.reverse.to_h
        
        erb :result
    end

    post '/new-vote' do
        @tasks = {}
        for v in params do
            @tasks[v[0]] = [v[1], 0]
        end
        @tasks = @tasks.sort_by { |key| key }.to_h

        write_tasks(@tasks)
        
        erb :newvote
    end

    post '/clear' do
        tasks_tmp = read_tasks
        write_tasks(tasks_tmp, true)
        @tasks = read_tasks

        erb :result
    end
end