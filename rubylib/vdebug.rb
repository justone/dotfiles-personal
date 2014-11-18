require 'securerandom'

class Vdebug
  class BufferNotFound < StandardError; end;

  attr_reader :vim

  def initialize(vim)
    @lock_file = "../vdebug.lock"
    @instance_id = SecureRandom::hex(3)
    @vim = vim
  end

  def start_listening
    write_lock_file!
    clear_buffer_cache!
    vim.server.remote_send ":python debugger.run()<CR>"
    sleep 2
  end

  def messages
    vim.command("messages")
  end

  def step_to_line(number)
    vim.command "#{number}"
    vim.command "python debugger.run_to_cursor()"
  end

  def step_over
    vim.command 'python debugger.step_over()'
  end

  def step_in
    vim.command 'python debugger.step_into()'
  end

  def evaluate(expression)
    safe_expression = expression.gsub(/['"\\\x0]/,'\\\\\0')
    vim.command %Q{python debugger.handle_eval("#{safe_expression}")}
  end

  # Retrieve a hash with the buffer names (values) and numbers (keys)
  def buffers
    @buffers ||= fetch_buffers
  end

  # Do this when you want to refresh the buffer list
  def clear_buffer_cache!
    @buffers = nil
  end

  # Has the vdebug GUI been opened?
  def gui_open?
    names = buffers.values
    %w[DebuggerStack DebuggerStatus DebuggerWatch].all? { |b|
      names.include? b
    }
  end

  def running?
    gui_open? && connected?
  end

  def connected?
     is_connected = vim.command(
       "python print debugger.runner.is_alive()"
     )
     is_connected == "True"
  end

  def watch_window_content
    fetch_buffer_content 'DebuggerWatch'
  end

  def watch_vars
    watch_lines = watch_window_content.split("\n")[4..-1]
    Hash[watch_lines.join("").split('|').map { |v|
      v[3..-1].split("=", 2).map(&:strip)
    }]
  end

  def stack_window_content
    fetch_buffer_content 'DebuggerStack'
  end

  def stack
    stack_window_content.split("\n").map { |l|
      s = {}
      matches = /^\[(\d+)\] (\S+) @ ([^:]+):(\d+)/.match(l)
      if matches
        s[:level] = matches[1]
        s[:name] = matches[2]
        s[:file] = matches[3]
        s[:line] = matches[4]
        s
      else
        raise "Invalid stack line: #{l}"
      end
    }
  end

  def status_window_content
    fetch_buffer_content 'DebuggerStatus'
  end

  def status
    /Status: (\S+)/.match(status_window_content)[1]
  end

  def remove_lock_file!
    if File.exists?(@lock_file) && File.read(@lock_file) == @instance_id
      puts "Deleting lock file for #{@instance_id}"
      File.delete(@lock_file)
    end
  end

protected
  def write_lock_file!
    while File.exists?(@lock_file)
      puts "Waiting for lock to be removed"
      sleep 0.1
    end
    puts "Creating lock file for #{@instance_id}"
    File.write(@lock_file, @instance_id)
  end

  def fetch_buffer_content(name)
    bufnum = buffers.invert.fetch(name)
    vim.echo(%Q{join(getbufline(#{bufnum}, 1, "$"), "\\n")})
  rescue KeyError
    raise BufferNotFound, "#{name} buffer not found"
  end

  def fetch_buffers
    buffer_string = vim.command('buffers')
    names = buffer_string.split("\n").collect do |bufline|
      matches = /\A\s*(\d+).*"([^"]+)"/.match(bufline)
      [matches[1].to_i, matches[2]] if matches
    end
    Hash[names.compact]
  end
end
