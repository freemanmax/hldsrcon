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
     if ( @challenge =~ /rcon\s\d\d\d\d\d\d\d\d\d/ )
       @socket.send "\xFF\xFF\xFF\xFF#{@challenge} #{@pass}"
       rcon_paket = @socket.recvfrom(1400)
       if rcon_paket[0] == "\xFF\xFF\xFF\xFFl\x00\x00"
         @rcon_respons = "Good Rcon" 
         return @rcon_respons
       else
         @rcon_respons = "Bad Rcon"
         return @rcon_respons
       end
     end     
  end
end
