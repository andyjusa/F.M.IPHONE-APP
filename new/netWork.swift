import SocketIO
import Foundation
import Starscream
import Network

class netWork:ObservableObject{
    @Published var id:Int = UserDefaults.standard.integer(forKey: "id") 
    @Published var name:String = UserDefaults.standard.string(forKey: "name") ?? "로그인이 필요함"
    @Published var value:Data = UserDefaults.standard.data(forKey: "schedule") ?? Data([0,1,2,3,4,5,
                                                                                      6,0,0,0,0,0,
                                                                                      7,0,0,0,0,0,
                                                                                      8,0,0,0,0,0,
                                                                                      9,0,0,0,0,0,
                                                                                      10,0,0,0,0,0,
                                                                                      11,0,0,0,0,0,
                                                                                      12,0,0,0,0,0])
    let manager = SocketManager(socketURL: URL(string: "http://localhost:8080")!, config: [.log(true), .compress])
    var socket:SocketIOClient!
    
    @Published var isConnected: Bool = false
    
    init(){
            socket = self.manager.socket(forNamespace: "/")
        socket.on(clientEvent: .disconnect)
        {_,_ in
            self.isConnected = false
        }
        socket.on(clientEvent: .connect)
        {_,_ in
            self.isConnected = true
        }
        socket.on(clientEvent: .error)
        {arg0,arg1 in
            print("error \(arg0)")
            if(arg0 as? [String] == ["Could not connect to the server."])
            {
                self.isConnected = false           
            }
        }
        socket.on("schedule")
        {data,sid in
            UserDefaults.standard.set(((data.first as? Data)!), forKey: "schedule")
            self.value = ((data.first as? Data)!)
        }
        socket.on("logined")
        {data,sid in
            if data[0] as! String == "suceed"{
                self.name = data[2] as! String
                self.id = data[1] as! Int
                UserDefaults.standard.set(self.name, forKey: "name")
                UserDefaults.standard.set(self.id, forKey: "id")
                self.getSchedule(i: self.id/100)
            }
        }
        socket.on("schedule")
        {data,sid in
            self.value = ((data.first as? Data)!)
        }
        socket.connect()
    }
    func connect() {
        socket.connect()
    }
    func getSchedule(i:Int) {
        socket.emit("getSchedule", i)
    }
    func email(s:String)
    {
        socket.emit("email", s)
    }
    func register(s:String,num:Int,name:String,psw:String)
    {
        socket.emit("register", [s,num,name,psw])
    }
    func login(name:String,psw:String)
    {
        socket.emit("login", [name,psw])
    }
    func disconnect() {
        socket.disconnect()
    }
}
  
