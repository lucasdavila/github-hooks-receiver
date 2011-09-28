"
Copyright (c) 2011 Lucas D'Avila - email <lucassdvl@gmail.com> / twitter @lucadavila

This file is part of github-hooks-receiver.

github-hooks-receiver is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License (LGPL v3) as published by
the Free Software Foundation, on version 3 of the License.

github-hooks-receiver is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with github-hooks-receiver.  If not, see <http://www.gnu.org/licenses/>.
"

require 'sinatra'
require 'json'
require File.join(File.dirname(__FILE__), 'config.rb')

class RooksReceiver

  def initialize(name = '', params = nil)
    @name, @params = name, params
    @paths = {
      'post-receive' => File.join(File.dirname(__FILE__), 'hooks/post-receive')
    }
  end
  
  def exec_hook(name = '')

    if (name.nil? or name.empty?) and (@name.nil? or @name.empty?)
      raise "Oops! I need the name of hook :)"
    elsif name.nil? or name.empty?
      name = @name
    end

    hook_path = load_hook(name)
    puts "    Executing hook '#{name}' in '#{hook_path}"
    system("sh #{hook_path}")
  end

protected
  def load_hook(name)

    hook_path = File.join(@paths['post-receive'], name)
    if not File.exists? hook_path
      raise "hook named '#{name}'not found in '#{hook_path}'"
    end
    hook_path    

  end

end

#sinatra configurations
configure do
  set :port, @port
end

post '/post-receive/:hook' do

  #TODO check if request.ip in list allowed_hosts or denied_hosts

  hook_name = params[:hook]
  hook_params = JSON.parse(params[:payload])

  msg = "Hook named '#{hook_name}' received from client #{request.ip} with params: #{hook_params}"

  rr = RooksReceiver.new(hook_name, hook_params)
  rr.exec_hook()

  puts msg

  #TODO criar parametro nas configs para pegar as mensagens das excecoes e enviar na resposta ?
  "Ok hook received :)"
end
