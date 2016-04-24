# encoding: US-ASCII
require "socket"

class RconHlds
  def initialize(ip_addr, port, bind_port)
     @socket = UDPSocket.new
     @socket.bind "", bind_port
     @socket.connect ip_addr, port
  end
  def close
     @socket.close
     @socket = nil
     return true
  end
  def rcon_pass(pass)
     @pass = pass
     @socket.send "\xFF\xFF\xFF\xFFchallenge rcon", 0
     paket = @socket.recvfrom(1400)
     data = paket[0]
     data.gsub!("\xFF\xFF\xFF\xFFchallenge ", "")
     data.gsub!("\n\x00", "")
     @challenge = data
     @rcon_pass_respons = ""
     if ( @challenge =~ /rcon\s\d/ )
       @socket.send "\xFF\xFF\xFF\xFF#{@challenge} #{@pass}", 0
       rcon_paket = @socket.recvfrom(1400)
       if rcon_paket[0] == "\xFF\xFF\xFF\xFFl\x00\x00"
         @rcon_pass_respons = "Good Rcon"  
         return @rcon_pass_respons
       else
         @rcon_pass_respons = "Bad Rcon"  
         return @rcon_pass_respons
       end
     end     
  end
  def rcon_command(command)
     @command = command
     if ( @rcon_pass_respons == "Good Rcon" )
       @socket.send "\xFF\xFF\xFF\xFF#{@challenge} #{@pass} #{@command}", 0
       @socket.send "\xFF\xFF\xFF\xFF#{@challenge} #{@pass}", 0
       @receve_paket = true
       @datas = ""
       while @receve_paket do
         @command_paket = @socket.recvfrom(1400)
         data = @command_paket[0]
         @datas << data
         if ( @command_paket[0] == "\xFF\xFF\xFF\xFFl\x00\x00" )
           @receve_paket = false
         end
       end
       @datas.gsub!("\xFF\xFF\xFF\xFFl", "")
       @datas.gsub!("\x00\x00", "")
       puts @datas
     else
       return "Bad Rcon"
     end
  end
end
